import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fifteen_minute_diary/constant.dart';
import 'package:fifteen_minute_diary/custom_class/toast_list.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class FirebaseService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  //userUid 반환
  String getUserUid() => _auth.currentUser!.uid;

  // 유저 이미지를 업데이트 합니다.
  Future<void> updateUserImage(File image) async {
    String userUid = _auth.currentUser!.uid;
    Reference dataRef = FirebaseStorage.instance
        .ref()
        .child('user_image')
        .child(userUid)
        .child('$userUid.png');
    await dataRef.putFile(image);
    String imageUri = await dataRef.getDownloadURL();
    debugPrint(imageUri);
    await _auth.currentUser!.updatePhotoURL(imageUri);
  }

  // 유저 이름을 업데이트 합니다.
  Future<void> updateUserName(String name) async {
    await _auth.currentUser!.updateDisplayName(name);
  }

  //애플 로그인을 구현합니다.
  Future<void> signWithApple() async {
    final appleCredential = await _getAppleCredential();
    var userName = appleCredential.givenName;
    final oauthCredential = await _getAppleOAuthCredential(appleCredential);
    await FirebaseAuth.instance.signInWithCredential(oauthCredential);
    if (FirebaseAuth.instance.currentUser?.displayName == null) {
      FirebaseAuth.instance.currentUser!.updateDisplayName(userName);
    }
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(k_OAuthProvider, k_ProviderApple);
  }

  //애플 인증서를 반환합니다.
  Future<AuthorizationCredentialAppleID> _getAppleCredential() async {
    var data = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
    );
    return data;
  }

  // 애플 oauth인증서를 반환합니다.
  Future<OAuthCredential> _getAppleOAuthCredential(
      AuthorizationCredentialAppleID appleCredential) async {
    return OAuthProvider("apple.com").credential(
      idToken: appleCredential.identityToken,
      accessToken: appleCredential.authorizationCode,
    );
  }

  // 구글 로그인을 합니다.
  Future<void> signInwithGoogle() async {
    try {
      final credential = await _getGoogleCredential();
      await _auth.signInWithCredential(credential);

      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString(k_OAuthProvider, k_ProviderGoogle);
    } on FirebaseAuthException catch (e) {
      debugPrint(e.message);
      rethrow;
    }
  }

  // 구글 인증서를 생성합니다.
  Future<OAuthCredential> _getGoogleCredential() async {
    final GoogleSignInAccount? googleSignInAccount =
        await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount!.authentication;
    return GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );
  }

  //데이터를 업로드 합니다.
  Future<void> uploadDateToFireStore(Map<String, dynamic> list) async {
    String userUid = FirebaseAuth.instance.currentUser!.uid;
    CollectionReference users =
        FirebaseFirestore.instance.collection('usersBackupData');
    await users.doc(userUid).delete();
    users.doc(userUid).set(list);
    debugPrint('업로드 완료');
  }

  // 로그아웃을 구현합니다.
  Future<void> signOutFromGoogle() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(k_OAuthProvider, k_ProviderNull);
    await _googleSignIn.signOut();
    await _auth.signOut();
  }

  // 유저 데이터를 삭제합니다.
  Future<void> deleteUser() async {
    String userUid = FirebaseAuth.instance.currentUser?.uid ?? "null";
    // 파이어베이스 데이터 삭제
    deleteFirebaseStorage(userUid);
    // 일반 스토리지 데이터 삭제
    await deleteExternalStorage(userUid);
    // 계정 정보 삭제
    // 계정정보를 제거하기위해 인증을 재시도 합니다.
    await deleteUserData();
  }

  // 파이어베이스에서 데이터를 다운받아 옵니다.
  Future<Map<String, dynamic>?> downloadDataToFireStore() async {
    debugPrint('데이터를 다운 받습니다.');
    String userUid = FirebaseAuth.instance.currentUser!.uid;
    CollectionReference users =
        FirebaseFirestore.instance.collection('usersBackupData');
    var data = await users.doc(userUid).get();
    if (data.exists) {
      debugPrint('data : ' + data.data().toString());
      return data.data() as Map<String, dynamic>;
    } else {
      debugPrint('null 반환');
      return null;
    }
  }

  // 파이어베이스 데이터베이스의 해당 유저 데이터를 제거합니다.
  void deleteFirebaseStorage(String userUid) async {
    await FirebaseFirestore.instance
        .collection('usersBackupData')
        .doc(userUid)
        .delete();
  }

  // 일반 스토리지 데이터베이스를 제거합니다.
  // 유저이미지, 게시글 이미지 입니다.
  Future<void> deleteExternalStorage(String userUid) async {
    var data = await FirebaseStorage.instance
        .ref()
        .child('user_image')
        .child(userUid)
        .listAll();

    for (var item in data.items) {
      item.delete();
    }
  }

  // 유저 데이터를 삭제합니다.
  // 파이어베이스 정책상 일정시간 로그인이 없었으면 재 로그인을 해서 인증을 받은 다음에 계정을 삭제할 수 있습니다.
  Future<void> deleteUserData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var oauthProvider = pref.getString(k_OAuthProvider);
    ToastList.showRequireUserCreditialToast();
    late OAuthCredential credential;
    if (oauthProvider == k_ProviderApple) {
      final appleCredential = await _getAppleCredential();
      credential = await _getAppleOAuthCredential(appleCredential);
    } else if (oauthProvider == k_ProviderGoogle) {
      credential = await _getGoogleCredential();
    }
    await _auth.currentUser?.reauthenticateWithCredential(credential);
    await _auth.currentUser?.delete();
  }
}

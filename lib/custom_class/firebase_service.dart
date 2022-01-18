import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fifteen_minute_diary/private_constant.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_web_auth/flutter_web_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class FirebaseService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  //애플 로그인을 구현합니다.
  Future<void> signWithApple() async {
    final appleCredential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
    );
    var userName = appleCredential.givenName;
    final oauthCredential = OAuthProvider("apple.com").credential(
      idToken: appleCredential.identityToken,
      accessToken: appleCredential.authorizationCode,
    );
    await FirebaseAuth.instance.signInWithCredential(oauthCredential);
    if (FirebaseAuth.instance.currentUser?.displayName == null) {
      FirebaseAuth.instance.currentUser!.updateDisplayName(userName);
    }
  }

  // 깃허브 로그인을 합니다.
  Future<void> signInwithGithub() async {
    String code = await _getCodeTokenFromGithub();
    String accessToken = await _getAccessTokenFromGithub(codeToken: code);
    var githubAuthCredential = GithubAuthProvider.credential(accessToken);
    FirebaseAuth.instance.signInWithCredential(githubAuthCredential);
  }

  //  깃허브에 로그인을 해서 code 토큰을 얻습니다.
  Future<String> _getCodeTokenFromGithub() async {
    Uri url = Uri.parse(
        "https://github.com/login/oauth/authorize?client_id=$clientId&scope=user");
    String result = await FlutterWebAuth.authenticate(
        url: url.toString(),
        callbackUrlScheme: urlScheme,
        preferEphemeral: true);

    final code = Uri.parse(result).queryParameters['code'];
    return code ?? 'null';
  }

  // code 값을 받아서 AccessToken을 발급 받습니다.
  Future<String> _getAccessTokenFromGithub({required String codeToken}) async {
    var dater = await http.post(Uri.parse(
        'https://github.com/login/oauth/access_token?client_id=$clientId&client_secret=$clientSecret&code=$codeToken'));
    // 정규식으로 토큰을 검출합니다.
    RegExp regExp = RegExp(r"access_token=[^&]*");
    String accessToken =
        regExp.stringMatch(dater.body)?.substring(13) ?? 'null';
    return accessToken;
  }

  // 구글 로그인을 합니다.
  Future<String?> signInwithGoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount!.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
      await _auth.signInWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      debugPrint(e.message);
      rethrow;
    }
    return null;
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
    await _googleSignIn.signOut();
    await _auth.signOut();
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
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fifteen_minute_diary/custom_class/post.dart';
import 'package:fifteen_minute_diary/private_constant.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_web_auth/flutter_web_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;

class FirebaseService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

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
      print(e.message);
      throw e;
    }
    return null;
  }

  //데이터를 업로드 합니다.
  void uploadDateToFireStore(Map<String, dynamic> list) {
    String userUid = FirebaseAuth.instance.currentUser!.uid;
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference users =
        FirebaseFirestore.instance.collection('usersBackupData');
    users.doc(userUid).set(list);
    print('업로드 완료');
  }

  // 데이터를 다운로드 합니다.
  // Map<String, dynamic> downloadDataToFireStore() {

  // }

  // 로그아웃을 구현합니다.
  Future<void> signOutFromGoogle() async {
    await _googleSignIn.signOut();
    await _auth.signOut();
  }
}

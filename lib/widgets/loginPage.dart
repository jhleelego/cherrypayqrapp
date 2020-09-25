import 'dart:convert';

import 'package:cherrypayqrapp/constants/common_testCode.dart';
import 'package:cherrypayqrapp/constants/httpCommon.dart';
import 'package:cherrypayqrapp/valueObjects/userInfoPVO.dart';
import 'package:cherrypayqrapp/widgets/plazaPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import "package:http/http.dart" as http;
import 'joinPage.dart';

_LoginPageState pageState;

GoogleSignIn _googleSignIn = GoogleSignIn(scopes: <String>[
  'email',
  'https://www.googleapis.com/auth/contacts.readonly',
]);

class LoginPage extends StatefulWidget {
  static const String LoginPageRouteName = '/LoginPage';

  @override
  _LoginPageState createState() {
    pageState = _LoginPageState();
    return pageState;
  }
}

class _LoginPageState extends State<LoginPage> {
  GoogleSignInAccount _currentUser;

  @override
  Widget build(BuildContext context) {
    return loginPage(context);
  }

  Widget loginPage(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              flex: 2,
              child: Container(),
            ),
            Expanded(
              flex: 2,
              child: Container(
                child: Image.asset('assets/cherryqrlogo.png'),
                width: dWidth(context) / 3.5,
              ),
            ),
            Expanded(
              flex: 1,
              child: Column(
                children: <Widget>[
                  Text(
                    '기술로 세계를 섬기는 기업',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '국내외 IT 서비스 사업을 모범적으로 이끌어 가는 선두기업으로의 도약',
                    style: TextStyle(
                      fontSize: 12,
                    ),
                  ),
                  Text(
                    '글로벌 기업이 인정한 언어서비스 기업',
                    style: TextStyle(
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 4,
              child: Container(),
            ),
            Expanded(
              flex: 1,
              child: InkWell(
                child: Image.asset(
                  'assets/btn_google_signin_light_normal_web@2x.png',
                ),
                onTap: () => _handleSignIn(),
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    print('loginPage initState()');
    _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount account) {
      setState(() {
        _currentUser = account;
      });
      if (_currentUser != null) {
        _handleGetContact();
      }
      _googleSignIn.signInSilently();
    });
  }

  Future<void> _handleGetContact() async {
    print('loginPage _handleGetContact() start');
    print('_currentUser : $_currentUser');
    // FirebaseAuth auth = FirebaseAuth.instance;
    // GoogleSignInAuthentication authentication =
    //     await _currentUser.authentication;
    // print('--------------------------------------------------------------o');
    // print('account.id                 : ${_currentUser.id}');
    // print('account.email              : ${_currentUser.email}');
    // print('--------------------------------------------------------------o');
    // print('authentication.idToken     : ${authentication.idToken}');
    // print('authentication.accessToken : ${authentication.accessToken}');
    // print('--------------------------------------------------------------o');
    // AuthCredential credential = GoogleAuthProvider.getCredential(
    //     idToken: authentication.idToken,
    //     accessToken: authentication.accessToken);
    // AuthResult authResult = await auth.signInWithCredential(credential);
    // IdTokenResult idTokenResult = await authResult.user.getIdToken();

    print('loginPage _handleGetContact() done');
  }

  //연결 하기
  Future<void> _handleSignIn() async {
    try {
      FirebaseAuth auth = FirebaseAuth.instance;
      final GoogleSignInAccount account = await _googleSignIn.signIn();
      GoogleSignInAuthentication authentication = await account.authentication;
      print('--------------------------------------------------------------o');
      print('account.id                 : ${account.id}');
      print('account.email              : ${account.email}');
      print('--------------------------------------------------------------o');
      print('authentication.idToken     : ${authentication.idToken}');
      print('authentication.accessToken : ${authentication.accessToken}');
      print('--------------------------------------------------------------o');
      AuthCredential credential = GoogleAuthProvider.getCredential(
          idToken: authentication.idToken,
          accessToken: authentication.accessToken);
      AuthResult authResult = await auth.signInWithCredential(credential);
      IdTokenResult idTokenResult = await authResult.user.getIdToken();

      Map pMap = {'id': account.id};

      dynamic body = json.encode(pMap);
      print('body : $body');

      final http.Response response = await http.post(
        Uri.encodeFull('http://192.168.43.75:18080/cheryqr/user/login'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Accept' : 'application/json',
        },
        body: body,
      );
      if (response != null) {
        print('response : ${response.body.toString()}');
      }
      Map<String, dynamic> responseMap = json.decode(response.body.toString());
      print("responseMap['code'] : ${responseMap['code']}");
      if (responseMap['code'].toString() == '0000') {
        //가입유저
        Navigator.pushNamed(
          context,
          PlazaPage.PlazaPageRouteName,
          arguments: _googleSignIn,
        );
      } else if (responseMap['code'].toString() == '0001') {
        //미가입 유저
        Navigator.pushNamed(context, JoinPage.JoinPageRouteName,
            arguments: _googleSignIn);
      }
      print('OOOOOOOOOOOOOOOOOOOO_handleGetContact() done');
    } catch (error) {
      print(error);
    }
  }
}

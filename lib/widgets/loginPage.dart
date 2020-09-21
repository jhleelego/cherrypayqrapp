import 'dart:convert';

import 'package:cherrypayqrapp/constants/common_testCode.dart';
import 'package:cherrypayqrapp/widgets/confirmationPage.dart';
import 'package:cherrypayqrapp/widgets/plazaPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;

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
  String _contactText;
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
              child: Container(
                child: Text(
                  '기술로 세계를 섬기는 기업',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                child: Column(
                  children: <Widget>[
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
            ),
            Expanded(
              flex: 1,
              child: Container(),
            ),
            Expanded(
              flex: 1,
              child: Container(
                color: Colors.white,
                child: SizedBox(
                  width: dWidth(context) / 1.5,
                  child: RaisedButton(
                    child: Text(
                      '구글로 로그인',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    onPressed: () => _handleSignIn(),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 4,
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
    print('OOOOOOOOOOOOOOOOOOOO_handleGetContact() start');
    setState(() {
      _contactText = "Loading contact info...";
    });
    print('_currentUser.authHeaders : ${_currentUser.authHeaders}');
    final http.Response response = await http.get(
        'https://people.googleapis.com/v1/people/me/connections'
            '?requestMask.includeField=person.names',
        headers: await _currentUser.authHeaders);

    print('response.body : ${response.body}');
    if (response.statusCode != 200) {
      setState(() {
        _contactText = "People API gave a ${response.statusCode} "
            "response. Check logs for detailes.";
      });
      print("People API ${response.statusCode} response: ${response.body}");
      return;
    }

    final Map<String, dynamic> data = json.decode(response.body);
    print('data : $data');
    print('data : $data.providerData');
    final String namedContact = _pickFirstNamedContact(data);
    setState(() {
      if (namedContact != null) {
        _contactText = "I see you know $namedContact";
        print('$namedContact');
      } else {
        _contactText = "No contacts to display.";
      }
    });
    print('OOOOOOOOOOOOOOOOOOOO_handleGetContact() done');

    bool result = true;
    if(result){
      Navigator.pushNamed(context, PlazaPage.PlazaPageRouteName,);
    } else {
      Navigator.pushNamed(context, JoinPage.JoinPageRouteName,);
    }
  }

  String _pickFirstNamedContact(Map<String, dynamic> data) {
    final List<dynamic> connections = data['connections'];
    final Map<String, dynamic> contact = connections?.firstWhere(
          (dynamic contact) => contact['names'] != null,
      orElse: () => null,
    );;
    if (contact != null) {
      final Map<String, dynamic> name = contact['names'].firstWhere(
            (dynamic name) => name['displayName'] != null,
        orElse: () => null,
      );
      if (name != null) {
        return name['displayName'];
      }
    }
    return null;
  }

  //연결 하기
  Future<void> _handleSignIn() async {
    try {
      final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
      print('googleUser : $googleUser');
    } catch (error) {
      print(error);
    }
  }


  //연결 하기
  // Future<void> _handleSignIn() async {
  //   try {
  //     final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
  //     print('googleUser : $googleUser');
  //   } catch (error) {
  //     print(error);
  //   }
  // }

  //연결 끊기
  Future<void> _handleSignOut() async {
    _googleSignIn.disconnect();
  }
}

import 'dart:convert';

import 'package:cherrypayqrapp/constants/common_testCode.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:imagebutton/imagebutton.dart';
//import 'package:qrscan/qrscan.dart' as scanner;
import 'package:http/http.dart' as http;

import 'joinPage.dart';

GoogleSignIn _googleSignIn = GoogleSignIn(scopes: <String>[
  'email',
  'https://www.googleapis.com/auth/contacts.readonly',
]);
class PlazaPage extends StatefulWidget {
  static const PlazaPageRouteName = '/PlazaPageRouteName';

  @override
  _PlazaPageState createState() => _PlazaPageState();
}

class _PlazaPageState extends State<PlazaPage> {
  GoogleSignInAccount _currentUser;
  String _contactText;
  String _output = 'Empty Scan Code';

  @override
  Widget build(BuildContext context) {
    return plazaPage(context);
  }

  Widget plazaPage(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 16,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Container(
                      child: Image.asset('assets/cherryqrlogo.png'),
                      width: dWidth(context) / 3.5,
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
              flex: 7,
              child: Container(
                width: dWidth(context),
                child: ImageButton(
                  children: <Widget>[],
                  width: dWidth(context) / 1.8,
                  height: dWidth(context) / 1.8,
                  pressedImage: Image.asset(
                    "assets/qrbuttonimage1.png",
                  ),
                  unpressedImage: Image.asset(
                    "assets/qrbuttonimage2.png",
                  ),
                  onTap: () {
                    print('test');
                    //_scan();
                  },
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    InkWell(
                      child: Column(
                        children: <Widget>[
                          Container(
                            child: Image.asset(
                              'assets/paymenthistory.png',
                            ),
                            width: dWidth(context) / 11,
                            height: dWidth(context) / 11,
                          ),
                          Text(
                            '결제내역',
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    InkWell(
                      child: Column(
                        children: <Widget>[
                          Container(
                            child: Image.asset(
                              'assets/settingup.png',
                            ),
                            width: dWidth(context) / 11,
                            height: dWidth(context) / 11,
                          ),
                          Text(
                            '설정하기',
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: SizedBox(
                child: RaisedButton(
                  child: Text('로그아웃'),
                  onPressed: (){
                    _handleSignOut();
                  },
                ),
              ),
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
      Navigator.pop(context);
    } else {
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


//비동기 함수
   Future _scan() async {
//     print('_scan() 호출');
//     //스캔 시작 - 이때 스캔 될때까지 blocking
//     String barcode = await scanner.scan();
//     //스캔 완료하면 _output 에 문자열 저장하면서 상태 변경 요청.
//     setState(() => _output = barcode);
//     print('ㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁ');
//     print('ㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁ $_output ㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁ');
//     print('ㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁ');
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

  //연결 끊기
  Future<void> _handleSignOut() async {
    _googleSignIn.disconnect();
  }
}

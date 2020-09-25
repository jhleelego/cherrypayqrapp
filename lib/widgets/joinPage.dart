import 'dart:convert';

import 'package:cherrypayqrapp/constants/common_testCode.dart';
import 'package:cherrypayqrapp/constants/material_color.dart';
import 'package:cherrypayqrapp/widgets/phoneAuthPage.dart';
import 'package:cherrypayqrapp/widgets/plazaPage.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;

import 'confirmationPage.dart';
import 'loginPage.dart';

GoogleSignIn _googleSignIn = GoogleSignIn(scopes: <String>[
  'email',
  'https://www.googleapis.com/auth/contacts.readonly',
]);

class JoinPage extends StatefulWidget {
  static const String JoinPageRouteName = '/JoinPage';

  JoinPage(Type googleSignIn);

  @override
  _JoinPageState createState() => _JoinPageState();
}

class _JoinPageState extends State<JoinPage> {
  GoogleSignInAccount _currentUser;
  bool _fullAgreement = false;
  bool _termsOfServiceChecked = false;
  bool _privacyPolicyChecked = false;
  String _joinInfo = '아래 약관을 모두 읽고\n 동의해주세요.';
  String _joinAuthInfo = '본인확인으로 수집되는 개인정보는\n최대한 안전하게 보관되고 최소한의 용도로만 사용합니다.';
  int _agreeCount = 1;

  @override
  Widget build(BuildContext context) {
    return joinPage(context);
  }

  Widget joinPage(BuildContext context) {
    _googleSignIn = ModalRoute
        .of(context)
        .settings
        .arguments;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Row(
                children: <Widget>[
                  IconButton(
                    icon: Icon(
                      Icons.arrow_back_ios,
                      size: 20,
                    ),
                    onPressed: backCheck,
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(),
            ),
            _topArea(),
            (_agreeCount == 1)
                ? _centerArea()
                : Expanded(
              flex: 3,
              child: Container(),
            ),
            Expanded(
              flex: 3,
              child: Container(),
            ),
            Expanded(
                flex: 1,
                child: Column(
                  children: <Widget>[
                    Text(
                      '$_agreeCount / 3',
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: dWidth(context) / 9,
                      ),
                      height: 8,
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        child: LinearProgressIndicator(
                          value: 0.33,
                          valueColor: new AlwaysStoppedAnimation<Color>(
                              Colors.lightGreen),
                          backgroundColor: Color(0xffD6D6D6),
                        ),
                      ),
                    ),
                  ],
                )),
            Expanded(
              flex: 1,
              child: Container(
                width: dWidth(context),
                child: FlatButton(
                  color: mainColor,
                  onPressed: () {
                    nextCheck();
                  },
                  child: Text(
                    '다음',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _topArea() {
    return Expanded(
      flex: 2,
      child: (_agreeCount == 1)
          ? Text(
        '$_joinInfo',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
        textAlign: TextAlign.center,
      )
          : Column(
        children: <Widget>[
          Container(
            child: Text(
              '$_joinInfo',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: 14,
          ),
          Text(
            '$_joinAuthInfo',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Colors.black45,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _centerArea() {
    return Expanded(
      flex: 3,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 40,
        ),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Checkbox(
                  value: _fullAgreement,
                  checkColor: Colors.white,
                  activeColor: Colors.black,
                  onChanged: (bool value) {
                    setState(() {
                      checkWhether('_fullAgreement', value);
                    });
                  },
                ),
                Text('전체 동의'),
              ],
            ),
            Container(
              padding: EdgeInsets.fromLTRB(
                14,
                0,
                0,
                0,
              ),
              child: Divider(
                thickness: 1,
              ),
            ),
            Row(
              children: <Widget>[
                Checkbox(
                  value: _termsOfServiceChecked,
                  checkColor: Colors.white,
                  activeColor: Colors.black,
                  onChanged: (value) {
                    setState(() {
                      checkWhether('_termsOfServiceChecked', value);
                    });
                  },
                ),
                Expanded(
                  child: Text('서비스 이용 약관(필수)'),
                ),
                FlatButton(
                  child: Text(
                    '보기',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  onPressed: () async {
                    confirmation('_termsOfService');
                  },
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Checkbox(
                  value: _privacyPolicyChecked,
                  checkColor: Colors.white,
                  activeColor: Colors.black,
                  onChanged: (value) {
                    setState(() {
                      checkWhether('_privacyPolicyChecked', value);
                    });
                  },
                ),
                Expanded(
                  child: Text('개인정보처리방침(필수)'),
                ),
                FlatButton(
                  child: Text(
                    '보기',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  onPressed: () async {
                    confirmation('_privacyPolicy');
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    print('joinPage');
    _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount account) {
      print('_currentUser : $_currentUser');
      setState(() {
        _currentUser = account;
        print('_currentUser : $_currentUser');
      });
      if (_currentUser != null) {
        _handleGetContact();
      }
    });
  }

  void checkWhether(String item, bool value) {
    if (item == '_fullAgreement') {
      if (_termsOfServiceChecked && _privacyPolicyChecked) {
        checked(false, false, false);
      } else {
        checked(true, true, true);
      }
    } else if (item == '_termsOfServiceChecked') {
      if (_fullAgreement && _termsOfServiceChecked && _privacyPolicyChecked) {
        checked(false, false, _privacyPolicyChecked);
      } else if (_privacyPolicyChecked) {
        checked(true, true, _privacyPolicyChecked);
      } else {
        checked(_fullAgreement, value, _privacyPolicyChecked);
      }
    } else if (item == '_privacyPolicyChecked') {
      if (_fullAgreement && _termsOfServiceChecked && _privacyPolicyChecked) {
        checked(false, _termsOfServiceChecked, false);
      } else if (_termsOfServiceChecked) {
        checked(true, _termsOfServiceChecked, true);
      } else {
        checked(_fullAgreement, _termsOfServiceChecked, value);
      }
    }
    print('fullAgreement : $_fullAgreement');
    print('termsOfServiceChecked : $_termsOfServiceChecked');
    print('privacyPolicyChecked : $_privacyPolicyChecked');
  }

  void checked(bool fullAgreement, bool _termsOfServiceCheckedValue,
      bool _privacyPolicyCheckedValue) {
    _fullAgreement = fullAgreement;
    _termsOfServiceChecked = _termsOfServiceCheckedValue;
    _privacyPolicyChecked = _privacyPolicyCheckedValue;
  }

  confirmation(String confirmation) async {
    print('confirmation');
    print('_termsOfServiceChecked : $_termsOfServiceChecked');
    print('_privacyPolicyChecked : $_privacyPolicyChecked');
    if (confirmation == '_termsOfService') {
      final result = await Navigator.pushNamed(
          context, ConfirmationPage.ConfirmationPageRouteName,
          arguments: Arguments('_termsOfService'));
      if (result != null) {
        checkWhether('_termsOfServiceChecked', true);
      }
    } else if (confirmation == '_privacyPolicy') {
      final result = await Navigator.pushNamed(
          context, ConfirmationPage.ConfirmationPageRouteName,
          arguments: Arguments('_privacyPolicy'));
      if (result != null) {
        checkWhether('_privacyPolicyChecked', true);
      }
    }
    print('_termsOfServiceChecked : $_termsOfServiceChecked');
    print('_privacyPolicyChecked : $_privacyPolicyChecked');
  }

  Future<void> nextCheck() async {
    print('nextCheck()');
    if (_agreeCount == 2) {
      print('_agreeCount == 2');
      Navigator.pushNamed(context, PhoneAuthPage.PhoneAuthPageRouteName,);
    } else {
      print('_agreeCount != 2');
      if (_fullAgreement) {
        print('_fullAgreement');
        setState(() {
          ++_agreeCount;
          _joinInfo = '안전을 위해\n본인확인을 진행합니다.';
          print('_agreeCount : $_agreeCount');
          checked(false, false, false);
        });
      } else {
        print('!_fullAgreement');
        showToast('   모든 약관에 동의하여 주세요.  ');
      }
    }
  }

  Future<Uri> resolveRedirection({String url}) async {
    Dio dio = new Dio();
    dio.options.followRedirects = true;
    dio.options.responseType = ResponseType.plain;
    Response response = await dio.get(url.toString());
    return response.realUri;
  }

  void showToast(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 2,
        backgroundColor: Color(0x6FFFFFFF),
        textColor: Colors.black,
        fontSize: 13.0
    );
  }

  void backCheck() {
    print('backCheck()');
    print('_agreeCount : $_agreeCount');
    if (_agreeCount == 2) {
      setState(() {
        --_agreeCount;
        _joinInfo = '아래 약관을 모두 읽고\n동의해주세요..';
        print('_agreeCount : $_agreeCount');
      });
    } else if (_agreeCount == 1) {
      print('_agreeCount == 1');
      _handleSignOut();
    }
  }

  Future<void> _handleGetContact() async {
    print('OOOOOOOOOOOOOOOOOOOO_handleGetContact() start');
    if (_currentUser == null) {
      Navigator.pop(context);
    }
    print('OOOOOOOOOOOOOOOOOOOO_handleGetContact() done');
  }

  //연결 끊기
  Future<void> _handleSignOut() async {
    _googleSignIn.signOut();
    Navigator.pop(context);
  }
}
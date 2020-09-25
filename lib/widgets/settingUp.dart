import 'package:cherrypayqrapp/constants/common_testCode.dart';
import 'package:cherrypayqrapp/widgets/loginPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'confirmationPage.dart';

GoogleSignIn _googleSignIn = GoogleSignIn(scopes: <String>[
  'email',
  'https://www.googleapis.com/auth/contacts.readonly',
]);

class SettingUpPage extends StatefulWidget {
  static const SettingUpPageRouteName = '/SettingUpPageRouteName';

  SettingUpPage(Type googleSignIn);

  @override
  _SettingUpPageState createState() => _SettingUpPageState();
}

class _SettingUpPageState extends State<SettingUpPage> {
  GoogleSignInAccount _currentUser;
  @override
  Widget build(BuildContext context) {
    return settingUpPage(context);
  }

  Widget settingUpPage(BuildContext context) {
    _googleSignIn = ModalRoute.of(context).settings.arguments;
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
            _personalInformationSetting(),
            _informationUse(),
            _membershipWithdrawal(),
            Expanded(
              flex: 3,
              child: Container(),
            ),
            ],
    ),
      ),
    );
  }

  Widget _personalInformationSetting() {
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
                Text(
                  '개인정보설정',
                  style: TextStyle(
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: Text('결제비밀번호 변경', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.grey[800],),),
                ),
                IconButton(
                  icon: Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.grey[700],
                  ),
                  onPressed: () async {
                    //confirmation('_termsOfService');
                  },
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: Text('계좌 관리', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.grey[800],),),
                ),
                IconButton(
                  icon: Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.grey[700],
                  ),
                  onPressed: () async {
                    //confirmation('_termsOfService');
                  },
                ),
              ],
            ),
            Container(
              child: Divider(
                thickness: 1,
                color: Colors.grey[400],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _informationUse() {
    return Expanded(
      flex: 4,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 40,
        ),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Text(
                  '이용안내',
                  style: TextStyle(
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: Text('서비스이용약관', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.grey[800],),),
                ),
                IconButton(
                  icon: Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.grey[700],
                  ),
                  onPressed: () async {
                    confirmation('_termsOfService');
                  },
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: Text('제3자정보제공', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.grey[800],),),
                ),
                IconButton(
                  icon: Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.grey[700],
                  ),
                  onPressed: () async {
                    confirmation('_privacyPolicy');
                  },
                ),
              ],
            ),

            SizedBox(
              height: 12,
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: Text('문의하기', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.grey[800],),),
                ),
                Text('주소 들어갈곳'),
              ],
            ),

            SizedBox(
              height: 12,
            ),
            Container(
              child: Divider(
                thickness: 1,
                color: Colors.grey[400],
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
        print('_currentUser : $_currentUser');
      });
      if (_currentUser != null) {
        _handleGetContact();
      }
      _googleSignIn.signInSilently();
    });
    print('plazaPage');
  }

  Future<void> _handleGetContact() async {
    print('OOOOOOOOOOOOOOOOOOOO_handleGetContact() start');
    bool result = true;
    if(result){
      Navigator.pop(context);
    }
    print('OOOOOOOOOOOOOOOOOOOO_handleGetContact() done');
  }

  Widget _membershipWithdrawal() {
    return Expanded(
      flex: 1,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 40,
        ),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child:InkWell(
                  child: Text('회원탈퇴', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.grey[800],),),
                    onTap: _handleSignOut,
                ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void confirmation(String confirmation) async {
    print('confirmation');
    if (confirmation == '_termsOfService') {
      final result = await Navigator.pushNamed(
          context, ConfirmationPage.ConfirmationPageRouteName,
          arguments: Arguments('_termsOfService'));
    } else if (confirmation == '_privacyPolicy') {
      Navigator.pushNamed(
          context, ConfirmationPage.ConfirmationPageRouteName,
          arguments: Arguments('_privacyPolicy'));
    }
  }

  void backCheck() {
    print('backCheck()');
    Navigator.of(context).pop();
  }

  //연결 끊기
  Future<void> _handleSignOut() async {
    _googleSignIn.signOut();
    Navigator.of(context)
        .popUntil(ModalRoute.withName(LoginPage.LoginPageRouteName));
  }
}

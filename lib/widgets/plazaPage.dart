import 'dart:convert';

import 'package:cherrypayqrapp/constants/common_testCode.dart';
import 'package:cherrypayqrapp/widgets/paymentHistory.dart';
import 'package:cherrypayqrapp/widgets/settingUp.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:imagebutton/imagebutton.dart';
import 'package:barcode_scan/barcode_scan.dart';

GoogleSignIn _googleSignIn = GoogleSignIn(scopes: <String>[
  'email',
  'https://www.googleapis.com/auth/contacts.readonly',
]);

class PlazaPage extends StatefulWidget {
  static const PlazaPageRouteName = '/PlazaPageRouteName';

  PlazaPage(Type googleSignIn);

  @override
  _PlazaPageState createState() => _PlazaPageState();
}

class _PlazaPageState extends State<PlazaPage> {
  GoogleSignInAccount _currentUser;
  String barcode = '';

  @override
  Widget build(BuildContext context) {
    return plazaPage(context);
  }
  Widget plazaPage(BuildContext context) {
    _googleSignIn = ModalRoute.of(context).settings.arguments;
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
                    scan();
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
                      onTap: () {
                        Navigator.pushNamed(context, PaymentHistoryPage.PaymentHistoryPageRouteName,);
                      },
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
                      onTap: (){
                        Navigator.pushNamed(context, SettingUpPage.SettingUpPageRouteName, arguments: _googleSignIn);
                      },
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 1,child: Container(),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    print('plazaPage');
    _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount account) {
      setState(() {
        _currentUser = account;
        print('account : $account');
        print('account.toString() : ${account.toString()}');
        print('_currentUser : $_currentUser');
      });
      if (_currentUser != null) {
        _handleGetContact();
      }
      _googleSignIn.signInSilently();
    });
  }

  Future<void> _handleGetContact() async {
    print('OOOOOOOOOOOOOOOOOOOO_handleGetContact() start');
    bool result = true;
    if(result){
      Navigator.pop(context);
    }
    print('OOOOOOOOOOOOOOOOOOOO_handleGetContact() done');
  }

  //비동기 함수
  Future scan() async {
    try {
      String barcode = await BarcodeScanner.scan();
      setState(() => barcode = barcode);
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.CameraAccessDenied) {
        setState(() {
          this.barcode = 'The user did not grant the camera permission!';
        });
      } else {
        setState(() => this.barcode = 'Unknown error: $e');
      }
    } on FormatException{
      setState(() => this.barcode = 'null (User returned using the "back"-button before scanning anything. Result)');
    } catch (e) {
      setState(() => this.barcode = 'Unknown error: $e');
    }
  }
}

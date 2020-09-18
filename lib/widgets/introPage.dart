import 'package:cherrypayqrapp/constants/common_testCode.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'loginPage.dart';

class IntroPage extends StatelessWidget {
  static const String IntroPageRouteName = '/IntroPage';

  @override
  Widget build(BuildContext context) {
    return introPage(context);
  }

  Widget introPage(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          child: InkWell(
            onTap: () => pageMove(context),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  flex: 4,
                  child: Container(
                    width: dWidth(context),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    child: Image.asset('assets/cherryqrlogo.png'),
                    width: dWidth(context) / 3.5,
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: Container(),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    child: Column(
                      children: <Widget>[
                        Text(
                          'from',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 20,
                          ),
                        ),
                        Text(
                          'CHERRY',
                          style: TextStyle(
                            color: Colors.grey[800],
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 3,
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
              ],
            ),
          ),),
      ),
    );
  }

  pageMove(BuildContext context) {
    Navigator.pushNamed(context, LoginPage.LoginPageRouteName,);
  }
}

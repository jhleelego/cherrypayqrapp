import 'package:cherrypayqrapp/widgets/confirmationPage.dart';
import 'package:cherrypayqrapp/widgets/introPage.dart';
import 'package:cherrypayqrapp/widgets/joinPage.dart';
import 'package:cherrypayqrapp/widgets/loginPage.dart';
import 'package:cherrypayqrapp/widgets/plazaPage.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: IntroPage(),
      routes: {
        IntroPage.IntroPageRouteName: (context) => IntroPage(),
        LoginPage.LoginPageRouteName: (context) => LoginPage(),
        JoinPage.JoinPageRouteName: (context) => JoinPage(),
        ConfirmationPage.ConfirmationPageRouteName: (context) =>
            ConfirmationPage('_termsOfServiceChecked'),
        PlazaPage.PlazaPageRouteName: (context) => PlazaPage(),
      },
    );
  }
}

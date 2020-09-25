import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PhoneAuthPage extends StatefulWidget {
  static const String PhoneAuthPageRouteName = '/PhoneAuthPage';

  @override
  _PhoneAuthPageState createState() => _PhoneAuthPageState();
}

class _PhoneAuthPageState extends State<PhoneAuthPage> {
  @override
  Widget build(BuildContext context) {
    return _phoneAuthPage();
  }

  Widget _phoneAuthPage() {
    print('PhoneAuthPage');
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: <Widget>[
            Expanded(
              flex: 12,
              child: WebView(
                initialUrl: 'http://192.168.43.75:18080/mobilians/auth/authEnter',
                //initialUrl: 'http://192.168.43.75:18080/mobilians/auth/authCancel',
                //initialUrl: 'https://www.google.com',
                javascriptMode: JavascriptMode.unrestricted,
                // initialOptions: InAppWebViewGroupOptions(
                //   crossPlatform: InAppWebViewOptions(
                //     debuggingEnabled: true,
                //   ),
                // ),
                // onWebViewCreated: (InAppWebViewController controller) {
                //   //_webViewController = controller;
                // },
                // onLoadStart: (InAppWebViewController controller, String url) {
                //   setState(() {
                //     //this.url = url;
                //   });
                // },
                // onLoadStop:
                //     (InAppWebViewController controller, String url) async {
                //   setState(() {
                //     //this.url = url;
                //   });
                // },
                // onProgressChanged:
                //     (InAppWebViewController controller, int progress) {
                //   setState(() {
                //     //this.progress = progress / 100;
                //   });
                // },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

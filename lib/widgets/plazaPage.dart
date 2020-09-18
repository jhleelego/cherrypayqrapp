import 'package:cherrypayqrapp/constants/common_testCode.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:imagebutton/imagebutton.dart';
//import 'package:qrscan/qrscan.dart' as scanner;

class PlazaPage extends StatefulWidget {
  static const PlazaPageRouteName = '/PlazaPageRouteName';

  @override
  _PlazaPageState createState() => _PlazaPageState();
}

class _PlazaPageState extends State<PlazaPage> {
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
              child: Container(),
            ),
          ],
        ),
      ),
    );
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
}

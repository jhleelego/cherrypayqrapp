import 'package:cherrypayqrapp/constants/common_testCode.dart';
import 'package:cherrypayqrapp/constants/material_color.dart';
import 'package:cherrypayqrapp/widgets/paymentInfo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PaymentHistoryPage extends StatefulWidget {
  static const String PaymentHistoryPageRouteName = '/PaymentHistoryPage';

  @override
  _PaymentHistoryPageState createState() => _PaymentHistoryPageState();
}

class _PaymentHistoryPageState extends State<PaymentHistoryPage> {
  String nowDate;

  @override
  void initState() {
    super.initState();
    date();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Container(),
          ),
          Expanded(
            flex: 1,
            child: SizedBox(
              width: dWidth(context) / 1.2,
              child: Container(
                color: mainColor,
                child: Row(
                  children: <Widget>[
                    IconButton(
                      icon: Icon(
                        Icons.arrow_back_ios,
                        color: Colors.grey[100],
                      ),
                      onPressed: dateDown,
                    ),
                    Expanded(
                      child: Text(
                        '$nowDate',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.grey[100],
                      ),
                      onPressed: dateUp,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            flex: 8,
              child: ListView.builder(
              itemBuilder: feedListBuilder,
              itemCount: 3,

            ),
          ),
          Expanded(
            flex: 1,
            child: Container(),
          ),
          Expanded(
            flex: 1,
            child: Container(),
          ),
        ],
      ),
    );
  }

  date() {
    DateTime today = new DateTime.now();
    print(today);
    print(today.month);
    setState(() {
      nowDate =
          "${today.year.toString()}.${today.month.toString().padLeft(2, '0')}";
    });
    print(nowDate);
  }

  dateDown() {}

  dateUp() {}

  Widget feedListBuilder(BuildContext context, int index) {
    return PaymentInfo(index);
  }
}

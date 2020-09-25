import 'package:cherrypayqrapp/constants/common_testCode.dart';
import 'package:flutter/material.dart';

List paymentList = [
  Payment('2020.09.01 14:00', '스타벅스 삼성점', '-20,000원'),
  Payment('2020.09.02 15:00', '맥도날드', '-12,000원'),
  Payment('2020.09.03 16:00', 'CU건대점', '-9,000원'),
  Payment('2020.09.05 14:00', '연타발', '-88,000원'),
];

class Payment {
  final String time;
  final String storeName;
  final String pay;

  const Payment(this.time, this.storeName, this.pay);
}

class PaymentInfo extends StatelessWidget {
  final int index;
  String dateTime = '2020.09.01 14:00';
  String storeName = '스타벅스 삼성점';
  String payPrice = '-12,000';

  PaymentInfo(this.index, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
     child:
       Padding(
         padding: EdgeInsets.symmetric(horizontal: 40,),
         child: Row(
       children: <Widget>[
         Column(
           children: [
             _paymentInfoDateTime(context),
             _paymentInfoStoreName(context),
           ],
         ),
         Row(
           children: [
             _paymentInfoPrice(context),
             _paymentInfoDetailInfo(context),
           ],
         )
       ],
     ),
      ),
    );
  }

  Widget _paymentInfoDateTime(BuildContext context) {
    return SizedBox(
      child: Text(
        '${paymentList[index].time}',
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _paymentInfoStoreName(BuildContext context) {
    return SizedBox(
      child: Text(
        '${paymentList[index].storeName}',
        textAlign: TextAlign.left,
      ),
    );
  }

  Widget _paymentInfoPrice(BuildContext context) {
    return
    SizedBox(
      child: Text(
        '${paymentList[index].pay}',
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _paymentInfoDetailInfo(BuildContext context) {
    return SizedBox(
      child: IconButton(
        icon: Icon(Icons.arrow_forward_ios,),
      ),
    );
  }
}

import 'dart:convert';

import 'package:cherrypayqrapp/constants/common_testCode.dart';
import 'package:cherrypayqrapp/constants/material_color.dart';
import 'package:cherrypayqrapp/widgets/plazaPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'confirmationPage.dart';

class JoinPage extends StatefulWidget {
  static const String JoinPageRouteName = '/JoinPage';

  @override
  _JoinPageState createState() => _JoinPageState();
}

class _JoinPageState extends State<JoinPage> {
  Future<Post> post;
  bool _fullAgreement = false;
  bool _termsOfServiceChecked = false;
  bool _privacyPolicyChecked = false;
  String _joinInfo = '아래 약관을 모두 읽고\n 동의해주세요.';
  int _aggreeCount = 1;

  @override
  void initState() {
    print('_JoinPageState');
    super.initState();
    post = fetchPost();
  }
  @override
  Widget build(BuildContext context) {
    return joinPage(context);
  }

  Widget joinPage(BuildContext context) {
    Arguments arguments = ModalRoute.of(context).settings.arguments;
    if (arguments != null) {
      print('arguments != null ${arguments.arg}');
      setState(() {
        checkWhether(arguments.arg, true);
      });
    }
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
                    onPressed: () {},
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(),
            ),
            _topArea(),
            _centerArea(),
            Expanded(
              flex: 3,
              child: Center(
                child: FutureBuilder<Post>(
                  future: post,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Text(snapshot.data.title);
                    } else if (snapshot.hasError) {
                      return Text("${snapshot.error}");
                    }

                    // 기본적으로 로딩 Spinner를 보여줍니다.
                    return CircularProgressIndicator();
                  },
                ),
              ),
            ),
            Expanded(
                flex: 1,
                child: Column(
                  children: <Widget>[
                    Text(
                      '$_aggreeCount/4',
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
                    agreedCheck();
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
      child: Container(
        child: Text(
          '$_joinInfo',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black54,
          ),
          textAlign: TextAlign.center,
        ),
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
      if (result!= null) {
        checkWhether('_termsOfServiceChecked', true);
      }
    } else if (confirmation == '_privacyPolicy') {
      final result = await Navigator.pushNamed(
          context, ConfirmationPage.ConfirmationPageRouteName,
          arguments: Arguments('_privacyPolicy'));
      if (result!= null) {
        checkWhether('_privacyPolicyChecked', true);
      }
    }
    print('_termsOfServiceChecked : $_termsOfServiceChecked');
    print('_privacyPolicyChecked : $_privacyPolicyChecked');
  }

  void agreedCheck() {
    if (_fullAgreement) {
      Navigator.pushNamed(
        context,
        PlazaPage.PlazaPageRouteName,
        arguments: Arguments(PlazaPage.PlazaPageRouteName),
      );
    }
  }
  Future<Post> fetchPost() async {
    final response =
    await http.get('https://jsonplaceholder.typicode.com/posts/1');

    if (response.statusCode == 200) {
      // 만약 서버가 OK 응답을 반환하면, JSON을 파싱합니다.
      return Post.fromJson(json.decode(response.body));
    } else {
      // 만약 응답이 OK가 아니면, 에러를 던집니다.
      throw Exception('Failed to load post');
    }
  }
}

class Post {
  final int userId;
  final int id;
  final String title;
  final String body;

  Post({this.userId, this.id, this.title, this.body});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
      body: json['body'],
    );
  }
}

import 'dart:convert';

import 'package:http/http.dart' as http;

class HttpCommon {
  // String uri;
  // String method;
  Map headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };
  // Map body;

  HttpCommon(
    // this.uri,
    // this.body,
    // this.method,
  ) {
    print(
        'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa');
    // print('uri : $uri');
    // print('body : $body');
    // print('method : $method');


    // if (method == 'POST')
    //   post(uri, headers, json.encode(body));
    // else if (method == 'GET') get(uri, headers);
    print(
        'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa');
  }

  //uri : 'www.e4net.net'

  //body :
  // String after json.encode(body);
  //headers :
  // headers['Content-Type'] = 'application/json'

  //method :
  // 'POST' OR 'GET'

  Future<http.Response> post(String url, Map<String, String> body) async {
    print('post');
    final http.Response response =
        await http.post(url, headers: headers, body: json.encode(body));
    return response;
  }

  Future<http.Response> get(uri, headers) async {
    http.Response response = await http.get(uri, headers: headers);
    return response;
  }

  httpGetParam(dynamic uri, Map body) {
    print(body); // {a: 1, b: 2}
  }
}

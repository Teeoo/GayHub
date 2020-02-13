import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:gayhub/utils/notify.dart';
import 'package:gayhub/models/authorizations.dart';
import 'package:gayhub/utils/localStorage.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart' show ChangeNotifier;

class AuthModel with ChangeNotifier {
  Authorizations _user;

  String _token;

  Authorizations get user => _user;

  String get token => _token;

  void setToken(token) {
    _token = token;
    LocalStorage.set('token', _token);
    notifyListeners();
  }

  getToken() async {
    return await LocalStorage.get('token');
  }

  restore() {
    _token = null;
    LocalStorage.remove("token");
    notifyListeners();
  }

  login(BuildContext context, _data) async {
    var bytes = utf8.encode("${_data['name']}:${_data['password']}");
    var basicAuth = base64.encode(bytes);
    var param = jsonEncode({
      "scopes": ["repo", "notifications", "user", "gist"],
      "note": "note",
      "client_id": "",
      "client_secret": ""
    });
    final response = await http.post('https://api.github.com/authorizations',
        headers: {
          HttpHeaders.authorizationHeader: "Basic $basicAuth",
          HttpHeaders.contentTypeHeader: "application/json"
        },
        body: param);
    if (response.statusCode != 401) {
      final responseJson = json.decode(response.body);

      _user = Authorizations.fromJson(responseJson);

      setToken(_user.token);

      return _user;
    } else {
      Notify.message(context, "用户名或者密码不正确!", type: CommonType.error);
      return null;
    }
  }
}

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class Auth with ChangeNotifier {
  String _token;
  var _userInfo = {};

  String get token {
    return _token;
  }

  bool get isAuth {
    return token != null;
  }

  get userInfo {
    return _userInfo;
  }

  Future<void> login(String email, String password) async {
    final baseUrl = 'http://192.168.0.70:1337/auth/local';
    try {
      var res = await Dio().post(baseUrl, data: {
          'identifier': email,
          'password': password
        });
        print('🎈🎈🎈👇');
        print(res.data['user']);
        if(res != null) {
          _token = res.data['jwt'];
          _userInfo = res.data['user'];
        }
    } catch(error) {
      print(error);
    }
    notifyListeners();
  }

}
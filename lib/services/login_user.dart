import 'dart:convert';

import 'package:store_app/helper/api.dart';

class LoginUser {
  Future<dynamic> loginUser({
    required String username,
    required String password,
  }) async {
    
    dynamic data = await Api().post(
      url: 'https://fakestoreapi.com/auth/login',
      body: jsonEncode(<String, String>{
        "username": username,
        "password": password,
      }),
      token: null,
    );

    return data;
  }
}

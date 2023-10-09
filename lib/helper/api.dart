import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Api {
  Future<dynamic> get({required String url}) async {
    http.Response response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception(
          'There is error in the status code: ${response.statusCode} with body: ${response.body}');
    }
  }

  Future<dynamic> post(
      {required String url,
      required dynamic body,
      @required String? token}) async {
    Map<String, String> headers = {};
    headers.addAll({
      "Content-Type": "application/json",
    });

    http.Response response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: body,
    );

    if (response.statusCode == 200) {
      dynamic data = jsonDecode(response.body);
      return data;
    } else  {
       throw 'There is error in the status code: ${response.statusCode}';
    }
  }

  Future<dynamic> put(
      {required String url,
      required dynamic body,
      @required String? token}) async {
    Map<String, String> headers = {};
    headers.addAll({
      "Content-Type": "application/json",
    });
    
    if (token != null) {
      headers.addAll({
        'Authorization': 'Bearar $token',
      });
    }
    http.Response response = await http.put(
      Uri.parse(url),
      headers: headers,
      body: body,
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      return data;
    } else {
      throw Exception(
          'There is error in the status code: ${response.statusCode}');
    }
  }
}

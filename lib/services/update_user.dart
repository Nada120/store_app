import 'dart:convert';
import '../models/user_model.dart';
import '../helper/api.dart';

class UpdateUser {
  Future<dynamic> updateProduct({
    required UserModel user,
    required String firstName,
    required String lastName,
    required String username,
    required String password,
    required String email,
    required String phone,
    required String city,
  }) async {
    final data = await Api().put(
      url: 'https://fakestoreapi.com/users/${user.id}',
      body: jsonEncode(<String, dynamic>{
        "email": email,
        "username": username,
        "password": password,
        "name": {
          "firstname": firstName,
          "lastname": lastName,
        },
        "address": {
          "city": city,
          "street": user.address.streat,
          "number": user.address.number,
          "zipcode": user.address.zipcode,
          "geolocation": {
            "lat": user.address.lat,
            "long": user.address.long,
          },
        },
        "phone": phone,
      }),
      token: null,
    );
    return UserModel.fromJSON(data);
  }
}

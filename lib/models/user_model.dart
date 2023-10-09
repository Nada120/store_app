import 'package:store_app/models/address_model.dart';

class UserModel {
  final String firstName;
  final String lastName;
  final String username;
  final String password;
  final String email;
  final String phone;
  final AddressModel address;
  final int? id;

  UserModel({
    required this.firstName,
    required this.lastName,
    required this.username,
    required this.password,
    required this.email,
    required this.phone,
    required this.address,
    required this.id,
  });

  factory UserModel.fromJSON(Map<String, dynamic> json) => UserModel(
        firstName: json['name']['firstname'],
        lastName: json['name']['lastname'],
        username: json['username'],
        password: json['password'],
        email: json['email'],
        phone: json['phone'],
        address: AddressModel.fromJSON(json['address']),
        id: json['id'],
      );
}

import 'package:flutter/cupertino.dart';

class UserModel{
  final String? name;
  final String? email;
  final String? phone;
  final String? image;
  final String? token;

  UserModel(
{
  required this.name,
  required this.email,
  required this.phone,
  required this.image,
  required this.token,
});

  factory UserModel.fromJson(jsonData){
    return UserModel(name: jsonData['name'],
        email:jsonData['email'],
        phone: jsonData['phone'],
        image: jsonData['image'],
        token: jsonData['token']);
  }
}
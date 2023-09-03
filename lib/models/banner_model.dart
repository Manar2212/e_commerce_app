import 'dart:core';

import 'package:flutter/cupertino.dart';

class BannerModel{
  int id;
  String image;

  BannerModel({required this.id,required this.image});

  factory BannerModel.fromJson(jsonData){
    return BannerModel(id: jsonData['id'], image: jsonData['image']);
  }
}
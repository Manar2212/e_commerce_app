import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
class Api{

  String baseURl = 'https://student.valuxapps.com/api/';

//get
Future<dynamic> get({required String url,@required String? token})async{
  Map<String , String> headers={
    'lang':'en'
  };

  if(token != null){
    headers.addAll({
      'Authorization':'$token',
    });
  }

  http.Response response = await  http.get(
    Uri.parse('$baseURl$url'),
    headers: headers
  );

  if(response.statusCode == 200){
    return jsonDecode(response.body);
  }else{
    throw Exception('there is a problem with status code: ${response.statusCode}');
  }
}

//add
Future<dynamic> post({required String url,@required body,@required token})async{
  Map<String , String> headers={
    'lang':'en'
  };

  if(token != null){
    headers.addAll({
      'Authorization':token,
    });
  }

  http.Response response = await http.post(
    Uri.parse('$baseURl$url'),
    headers: headers,
    body: body,
  );

  if(response.statusCode == 200){
    print(jsonDecode(response.body));
    return jsonDecode(response.body);
  }else{
    throw Exception('there is a problem with status code ${response.statusCode} with body ${jsonDecode(response.body)}');
  }
}

//update

Future<dynamic> put({required String url,@required body,@required token})async{
  Map<String , String> headers={
    'lang':'en'
  };
  if(token != null){
    headers.addAll({
      'Authorization':token,
    });
  }
  http.Response response = await http.put(
    Uri.parse('$baseURl$url'),
    body: body,
    headers: headers
  );

  if(response.statusCode == 200){
    return jsonDecode(response.body);
  }else{
    throw Exception('there is a problem with status code ${response.statusCode} with body ${jsonDecode(response.body)}');
  }
}

}
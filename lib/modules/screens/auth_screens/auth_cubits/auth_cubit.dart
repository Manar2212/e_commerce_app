import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:e_commerce_app/shared/constants/constants.dart';
import 'package:e_commerce_app/shared/network/local/local_network.dart';
import 'package:e_commerce_app/shared/network/remote/end_points.dart';
import 'package:http/http.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

import '../../../../shared/network/remote/api_helper.dart';
part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  Future<void> register({required String name,required String email,required String phone,required String password})async{
    emit(RegisterLoadingState());
    // try{
    //   Response response = await http.post(
    //       Uri.parse('https://student.valuxapps.com/api/register'),
    //       body: {
    //         'name':name,
    //         'email':email,
    //         'phone':phone,
    //         'password':password,
    //       },
    //       headers: {
    //         'lang':'en',
    //       }
    //   );
    //   if(response.statusCode == 200){
    //     var responseBody = jsonDecode(response.body);
    //     if(responseBody['status'] == true){
    //       emit(RegisterSuccessState());
    //       print(responseBody);
    //     }else{
    //       emit(RegisterFailureState(errMessage: responseBody['message']));
    //       print(responseBody);
    //     }
    //   }
    // }on Exception catch(e){
    //   emit(RegisterFailureState(errMessage: e.toString()));
    // }

    var responseBody = await Api().post(url: Register, body: {
            'name':name,
            'email':email,
            'phone':phone,
            'password':password,
          },);
    if(responseBody['status'] == true){
            emit(RegisterSuccessState());
            print(responseBody);
          }else{
            emit(RegisterFailureState(errMessage: responseBody['message']));
            print(responseBody);
          }
  }
  
  Future<void> login({required String email,required String password})async{
    emit(LoginLoadingState());
    // try{
    //   Response response = await http.post(
    //     Uri.parse('https://student.valuxapps.com/api/login'),
    //     body: {
    //       'email':email,
    //   'password':password
    //   },
    //     headers: {
    //       'lang':'en',
    //     }
    //   );
    //   if(response.statusCode == 200){
    //     var responseBody = jsonDecode(response.body);
    //     if(responseBody['status'] == true){
    //       print('User login success and his data is ${responseBody}');
    //       await CacheNetwork.insertToCache(key: 'token', value: responseBody['data']['token']);
    //       emit(LoginSuccessState());
    //     }else{
    //       print('Failed to login and reason is ${responseBody['message']} ');
    //       emit(LoginFailureState(
    //         errMessage: responseBody['message'],
    //       ));
    //     }
    //   }
    // }on Exception catch(e){
    //   emit(LoginFailureState(errMessage: e.toString()));
    // }
    var responseBody = await Api().post(url: Login, body:{
          'email':email,
      'password':password
      });

    if(responseBody['status'] == true){
            print('User login success and his data is ${responseBody}');
            await CacheNetwork.insertToCache(key: 'token', value: responseBody['data']['token']);
            await CacheNetwork.insertToCache(key: 'password', value: password);
            token = CacheNetwork.getCacheData(key: 'token');
            currentPassword = CacheNetwork.getCacheData(key: 'password');
            emit(LoginSuccessState());
          }else{
            print('Failed to login and reason is ${responseBody['message']} ');
            emit(LoginFailureState(
              errMessage: responseBody['message'],
            ));
          }
  }
 }

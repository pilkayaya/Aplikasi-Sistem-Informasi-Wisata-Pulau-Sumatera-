import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:wisata_app/core/api_client.dart';
import 'package:wisata_app/core/api_exception.dart';
import 'package:wisata_app/params/auth_param.dart';

import '../response/login_response.dart';

class AuthRepository extends ApiClient{
  Future<LoginResponse> signIn(AuthParam param) async{
    try{
      var response = await dio.post('login', data: param.toJson());
      debugPrint('Login Response : ${response.data}');
      return LoginResponse.fromJson(response.data);
    }on DioException catch(e){
      if(e.response != null){
        debugPrint('Error response : ${e.response!.data}');
        throw ApiException(message: e.response!.data['message'].toString());
      }else {
        debugPrint('Message error : ${e.message}');
        debugPrint('Type of error : ${e.type}');
      }
      throw Exception(e.toString());
    }
  }
}
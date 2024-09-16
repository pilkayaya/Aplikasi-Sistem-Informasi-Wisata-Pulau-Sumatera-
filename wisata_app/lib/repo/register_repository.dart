import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:wisata_app/core/api_client.dart';
import 'package:wisata_app/core/api_exception.dart';
import 'package:wisata_app/params/register_param.dart';
import '../response/register_response.dart';

class RegisterRepository extends ApiClient {
  Future<RegisterResponse> register(RegisterParam param) async {
    try {
      var response = await dio.post('register', data: param.toJson());
      debugPrint('Register Response: ${response.data['data']}');
      return RegisterResponse.fromJson(response.data['data']);
    } on DioException catch (e) {
      if (e.response != null) {
        debugPrint('Error response: ${e.response!.data}');
        throw ApiException(message: e.response!.data['message'].toString());
      } else {
        debugPrint('Message error: ${e.message}');
        debugPrint('Type of error: ${e.type}');
      }
      throw Exception(e.toString());
    }
  }
}

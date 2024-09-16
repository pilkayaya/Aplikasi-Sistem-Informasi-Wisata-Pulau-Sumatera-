import 'package:dio/dio.dart';

abstract class ApiClient{
  final Dio _dio = Dio();

  ApiClient(){
    _dio.options.headers['content-type'] = 'application/json';
    _dio.options.baseUrl = 'http://10.0.2.2:8000/webservice/';
  }

  Dio get dio => _dio;
}
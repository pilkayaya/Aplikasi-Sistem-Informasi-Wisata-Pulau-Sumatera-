import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:wisata_app/core/api_client.dart';

import '../models/objek_wisata_model.dart';

class ObjekWisataRepository extends ApiClient{
  Future<List<ObjekWisataModel>> getPaginationObjekWisata(
      int _limit, int _offset) async {
    try{
      var response = await dio.get('objek_wisata_filter/?limit=${_limit}&offset=${_offset}');
      debugPrint('Response Objek Wisata');
      if(response.statusCode !=200){
        throw Exception('Failed fetch data...');
      }
      List list = response.data['results'];
      List<ObjekWisataModel> listObjekWisata =
          list.map((element) => ObjekWisataModel.fromJson(element)).toList();
      return listObjekWisata;
    }on DioException catch(e){
      throw Exception(e.toString());
    }
  }

  Future<ObjekWisataModel> getObjekWisataDetail(int id) async {
    try {
      var response = await dio.get('objek_wisata/$id');
      debugPrint('Response Detail Objek Wisata: ${response.data['data']}');
      if (response.statusCode != 200) {
        throw Exception('Failed fetch data...');
      }
      return ObjekWisataModel.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw Exception(e.toString());
    }
  }
}

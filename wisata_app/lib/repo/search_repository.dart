import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:wisata_app/core/api_client.dart';
import 'package:wisata_app/models/objek_wisata_model.dart';

import '../models/search_model.dart';
import '../response/search_response.dart';

class SearchRepository extends ApiClient {

  Future<SearchResponse> searchObjekWisata(SearchModel searchModel) async {
    try {
      var response = await dio.get(
        'objek_wisata_filter/',
        queryParameters: {
          if (searchModel.keyword != null) 'nama': searchModel.keyword,
          'kategori_provinsi__provinsi': searchModel.kategoriProvinsi,
          'kategori_objek_wisata': searchModel.kategoriObjekWisata,
        },
      );
      debugPrint('Response Objek Wisata: ${response.data['results']}');
      SearchResponse searchResponse = SearchResponse.fromJson(response.data['results']);
      return searchResponse;
    } on DioException catch (e) {
      debugPrint(e.toString());
      throw Exception(e.toString());
    }
  }

  Future<List<ObjekWisataModel>> getObjekWisataPagination(int limit, int offset) async {
    try {
      var response = await dio.get(
        'objekWisata',
        queryParameters: {
          'limit': limit,
          'offset': offset,
        },
      );
      debugPrint('Response Objek Wisata: ${response.data}');
      List<ObjekWisataModel> objekWisataList = (response.data as List)
          .map((objekWisataJson) => ObjekWisataModel.fromJson(objekWisataJson))
          .toList();
      return objekWisataList;
    } on DioException catch (e) {
      debugPrint(e.toString());
      throw Exception(e.toString());
    }
  }

}


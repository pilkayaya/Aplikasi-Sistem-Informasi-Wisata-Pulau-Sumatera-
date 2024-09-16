import 'package:dio/dio.dart';
import 'package:wisata_app/core/api_client.dart';
import 'package:wisata_app/models/objek_wisata_model.dart';

class SearchCobaRepository extends ApiClient {
  Dio get dio => super.dio;

  Future<List<ObjekWisataModel>> searchByName(String query, int limit, int offset) async {
    try {
      final response = await dio.get(
        'objek_wisata_filter/',
        queryParameters: {
          'search': query,
          'limit': limit,
          'offset': offset,
        },
      );
      List<dynamic> results = response.data['results'];
      List<ObjekWisataModel> objekWisataList = results.map((json) => ObjekWisataModel.fromJson(json)).toList();
      return objekWisataList;
    } catch (e) {
      print('Error searching by name: $e');
      throw Exception('Gagal mengambil hasil pencarian');
    }
  }

  Future<List<ObjekWisataModel>> searchByProvince(String province, int limit, int offset) async {
    try {
      final response = await dio.get(
        'objek_wisata_filter/',
        queryParameters: {
          'kategori_provinsi__provinsi': province,
          'limit': limit,
          'offset': offset,
        },
      );
      List<dynamic> results = response.data['results'];
      List<ObjekWisataModel> objekWisataList = results.map((json) => ObjekWisataModel.fromJson(json)).toList();
      return objekWisataList;
    } catch (e) {
      print('Error searching by province: $e');
      throw Exception('Gagal mengambil hasil pencarian');
    }
  }

  Future<List<ObjekWisataModel>> searchByCategory(String category, int limit, int offset) async {
    try {
      final response = await dio.get(
        'objek_wisata_filter/',
        queryParameters: {
          'kategori_objek_wisata__kategori': category,
          'limit': limit,
          'offset': offset,
        },
      );
      List<dynamic> results = response.data['results'];
      List<ObjekWisataModel> objekWisataList = results.map((json) => ObjekWisataModel.fromJson(json)).toList();
      return objekWisataList;
    } catch (e) {
      print('Error searching by category: $e');
      throw Exception('Gagal mengambil hasil pencarian');
    }
  }
}

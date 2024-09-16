import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:wisata_app/core/api_client.dart';
import 'package:wisata_app/core/api_exception.dart';
import '../params/review_param.dart';
import '../response/review_response.dart';

class ReviewRepository extends ApiClient {
  Future<List<ReviewResponse>> fetchReviews() async {
    try {
      var response = await dio.get('webservice/review');
      debugPrint('Fetch Reviews Response: ${response.data}');
      List<dynamic> body = response.data;
      return body.map((dynamic item) => ReviewResponse.fromJson(item)).toList();
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

  Future<ReviewResponse> createReview(ReviewParam reviewParam) async {
    try {
      var response = await dio.post(
        'webservice/review',
        data: reviewParam.toJson(),
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ),
      );
      debugPrint('Create Review Response: ${response.data}');
      return ReviewResponse.fromJson(response.data);
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

  Future<void> updateReview(int id, ReviewParam reviewParam) async {
    try {
      var response = await dio.put(
        'webservice/review/$id',
        data: reviewParam.toJson(),
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ),
      );
      debugPrint('Update Review Response: ${response.data}');
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

  Future<void> deleteReview(int id) async {
    try {
      var response = await dio.delete('webservice/review/$id');
      debugPrint('Delete Review Response: ${response.data}');
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
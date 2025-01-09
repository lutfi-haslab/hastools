import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:hastools/core/constants/api_constants.dart';
import 'package:network_logger/network_logger.dart';

class DioClient {
  final Dio _dio;

  DioClient(this._dio) {
    _dio.options.baseUrl = ApiConstants.baseUrl;
    _dio.interceptors.add(DioNetworkLogger());
  }

  Future<Response> get(String endpoint) async {
    try {
      final response = await _dio.get(endpoint);
      return response;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<Response> post(String endpoint, dynamic data) async {
    try {
      // Convert data to JSON string
      final response = await _dio.post(
        endpoint,
        data: data,
        options: Options(
          contentType: 'application/json',
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );
      return response;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException error) {
    if (kDebugMode) {
      print('DioError: ${error.message}');
      print('DioError Response: ${error.response}'); // For debugging
    } // For debugging

    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        return Exception('Connection timed out');
      case DioExceptionType.receiveTimeout:
        return Exception('Unable to receive data');
      case DioExceptionType.badResponse:
        return Exception(
            'Server returned ${error.response?.statusCode}: ${error.response?.statusMessage}');
      default:
        return Exception('Something went wrong: ${error.message}');
    }
  }
}

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:test_multi_image_picker/domain/api/interceptors/logging_interceptor.dart';
import 'package:test_multi_image_picker/domain/utilities/config.dart';

class APIRepository {
  final BaseOptions _baseOptions = BaseOptions(
    baseUrl: Config().get(kReleaseMode ? 'release_api_url' : 'debug_api_url'),
    contentType: ContentType.json.toString(),
    responseType: ResponseType.json,
    connectTimeout: 10000,
    receiveTimeout: 30000,
  );

  late Dio _dio;

  APIRepository() {
    _dio = Dio(_baseOptions);
    _dio.interceptors.add(LoggingInterceptor());
  }

  Future<Response> post(String endpoint,
      {required data, Options? options}) async {
    return await _dio.post(endpoint, data: data, options: options);
  }

  get dio => _dio;
}

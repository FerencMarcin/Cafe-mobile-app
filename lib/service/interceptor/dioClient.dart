import 'dart:developer';

import 'package:cafe_mobile_app/service/interceptor/jwt_interceptor.dart';
import 'package:dio/dio.dart';


class DioClient {
  final dioC = Dio()
    ..options = BaseOptions(
        contentType: 'application/json'
    )
    ..interceptors.add(JwtInterceptor(),);
}
import 'dart:developer';

import 'package:cafe_mobile_app/service/storage_service.dart';
import 'package:dio/dio.dart';

class JwtInterceptor extends Interceptor with StorageService{
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    var accessToken = await getAccessToken();
    if(accessToken != null) {
      options.headers['Authorization'] = 'Bearer $accessToken';
      log("token : Bearer $accessToken");
      log('REQUEST[${options.method}] => PATH: ${options.path}');
    }
    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print(
      'RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}',
    );
    return super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    if((err.response?.statusCode == 401)){
      log("trzeba nowy token");
    } else if ((err.response?.statusCode == 403)){
      log("Błędny token - przeterminowany");
    }
  }
}
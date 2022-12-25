import 'dart:developer';

import 'package:cafe_mobile_app/service/storage_service.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart' as g;

import 'dioClient.dart';

class JwtInterceptor extends Interceptor with StorageService{
  Dio api = Dio();
  
  // api.options.headers["cookie"] = 'jwt=$refreshToken';

  JwtInterceptor() {
    api.interceptors
        .add(InterceptorsWrapper(onError: (error, handler) async {
          if(error.response?.statusCode == 403) {
            //TODO implementacja
            log('potrzebne ponowne zalogowanie');
          }
        }, onRequest: (options, handler) async {
          log('dodaje options');
          options.followRedirects = false;
          options.validateStatus = (status) {return status! < 500;};
          log('REQUEST[${options.method}] => PATH: ${options.path}');
          return super.onRequest(options, handler);
        }
    ));
  }
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    var accessToken = await getAccessToken();

    if(accessToken != null) {
      options.headers['Authorization'] = 'Bearer $accessToken';
      options.followRedirects = false;
      options.validateStatus = (status) {return status! < 500;};
      log("token : Bearer $accessToken");
      log('REQUEST[${options.method}] => PATH: ${options.path}');
    }
    return super.onRequest(options, handler);
  }

  @override
  Future<void> onResponse(Response response, ResponseInterceptorHandler handler) async {
    print(
      'RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}',
    );
    if(response.statusCode == 403) {
      log('Token wygasł');
      if (await secureStorage.containsKey(key: 'RefreshToken')) {
        log('mam refresh token');
        int? refreshStatusCode = await refreshToken();
        if(refreshStatusCode != 403) {
          log('ponawiam request');
          return handler.resolve(await retryRequest(response.requestOptions));
        }
        log(response.statusCode.toString() + 'koncowy res');
      }
    }
    return super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    if((err.response?.statusCode == 401)){
      log("trzeba nowy token");
    } else if ((err.response?.statusCode == 403)){
      log("Błędny token - przeterminowany");
    } else {
      log("inny blad");
      return super.onError(err, handler);
    }
  }

  Future<int?> refreshToken() async {
    final refreshToken = await secureStorage.read(key: 'RefreshToken');
    //Dio api = Dio();
    api.options.headers["cookie"] = '$refreshToken';
    api.options.followRedirects = false;
    api.options.validateStatus = (status) {return status! < 500;};
    log('token refresh $refreshToken');
    final response = await api.get('http://10.0.2.2:3001/auth/refresh');
    if (response.statusCode == 200) {
      log(response.data.toString());
      String? accessToken = response.data['accessToken'];
      if (accessToken != null) {
        log('zapisuje');
        await setAccessToken(accessToken);
      }
      log('nowy act: ' + accessToken!);
    } else {
      log('procesuje wylogowanie');
      // g.Get.defaultDialog(
      //     title: 'Sesja wygasła',
      //     middleText: 'Musisz zalogować się ponownie',
      //     textConfirm: 'Zaloguj',
      //     onConfirm: () async {
      //       await removeTokens();
      //       g.Get.back();
      //       g.Get.toNamed('/start');
      //     }
      // );
      //removeTokens();
      //TODO need logout
    }
    return response.statusCode;
  }

  Future<Response<dynamic>> retryRequest(RequestOptions requestOptions) async {
    //Dio api = Dio();
    final accessToken = await secureStorage.read(key: 'AccessToken');
    log('header: ${requestOptions.headers}');
    api.options.headers['Authorization'] = 'Bearer $accessToken';
    final options = Options(
      method: requestOptions.method,
      //headers: requestOptions.headers,
    );
    return api.request<dynamic>(requestOptions.path,
      data: requestOptions.data,
      queryParameters: requestOptions.queryParameters,
      options: options
    );
  }
}
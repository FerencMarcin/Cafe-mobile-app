import 'package:cafe_mobile_app/service/storage_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class JwtInterceptor extends Interceptor with StorageService{
  final String refreshTokenUrl = '${dotenv.env['BASE_URL']!}/auth/refresh';
  Dio api = Dio();

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    var accessToken = await getAccessToken();
    if(accessToken != null) {
      options.headers['Authorization'] = 'Bearer $accessToken';
      options.followRedirects = false;
      options.validateStatus = (status) {return status! < 500;};
    }
    return super.onRequest(options, handler);
  }

  @override
  Future<void> onResponse(Response response, ResponseInterceptorHandler handler) async {
    if(response.statusCode == 403) {
      if (await secureStorage.containsKey(key: 'RefreshToken')) {
        int? refreshStatusCode = await refreshToken();
        if(refreshStatusCode != 403) {
          return handler.resolve(await retryRequest(response.requestOptions));
        }
      }
    }
    return super.onResponse(response, handler);
  }

  Future<int?> refreshToken() async {
    final refreshToken = await secureStorage.read(key: 'RefreshToken');
    api.options.headers["cookie"] = '$refreshToken';
    api.options.followRedirects = false;
    api.options.validateStatus = (status) {return status! < 500;};
    final response = await api.get(refreshTokenUrl);
    if (response.statusCode == 200) {
      String? accessToken = response.data['accessToken'];
      if (accessToken != null) { await setAccessToken(accessToken); }
    }
    return response.statusCode;
  }

  Future<Response<dynamic>> retryRequest(RequestOptions requestOptions) async {
    final accessToken = await secureStorage.read(key: 'AccessToken');
    api.options.headers['Authorization'] = 'Bearer $accessToken';
    final options = Options(
      method: requestOptions.method,
    );
    return api.request<dynamic>(requestOptions.path,
      data: requestOptions.data,
      queryParameters: requestOptions.queryParameters,
      options: options
    );
  }
}
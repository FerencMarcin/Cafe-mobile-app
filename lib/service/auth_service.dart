import 'dart:developer';

import 'package:cafe_mobile_app/service/storage_service.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'interceptor/dioClient.dart';

class AuthService extends GetxController with StorageService {
  RxBool isLogged = false.obs;
  final DioClient _dioClient = Get.put(DioClient());

  final String userInfoUrl = '${dotenv.env['BASE_URL']!}/users/email';

  Future<void> checkAuthStatus() async {
    try {
      var accessToken = await getAccessToken();
      if(accessToken != null) {
        if(!JwtDecoder.isExpired(accessToken)) { isLogged = true.obs; log('is exp $isLogged');}
      } else {
        isLogged = false.obs;
      }
      log('end $isLogged');
    } catch(e) { isLogged = false.obs; log('catch $isLogged');}
  }

  void login(String? token) async {
    if(token != null) {
      isLogged = true.obs;
      await setAccessToken(token);
      await fetchUserInfo(token);
    }
  }

  void addRefreshToken(String token) async {
    await setRefreshToken(token);
  }

  void logout() async {
    isLogged = false.obs;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    removeTokens();
  }

  void saveRefreshToken(response) async {
    var cookies = response.headers['set-cookie'];

    if(cookies != null) {
      final cookiesList = cookies!.split(';');
      for (var element in cookiesList) {
        if(element.contains('jwt=')){
          addRefreshToken(element);
        }
      }
    }
  }

  Future<void> fetchUserInfo(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
    String userEmail = decodedToken['user']['email'];
    final response = await _dioClient.dioClient.get('$userInfoUrl/$userEmail');

    prefs.setString('userFirstname', response.data['firstname']);
    prefs.setString('userLastname', response.data['lastname']);
    prefs.setInt('userId', response.data['id']);
    prefs.setInt('userPoints', response.data['points']);
  }

  Future<bool> checkIsTokensExpired() async {
    var accessToken = await getAccessToken();
    var refreshToken = await getRefreshToken();
    if((accessToken != null) && (refreshToken != null)){
      if (JwtDecoder.isExpired(accessToken) && JwtDecoder.isExpired(refreshToken)){
        return true;
      } else {
        return false;
      }
    } else {
      return true;
    }
  }
}
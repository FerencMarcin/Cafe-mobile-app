import 'dart:developer';

import 'package:cafe_mobile_app/service/storage_service.dart';
import 'package:get/get.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

import 'interceptor/dioClient.dart';

class AuthService extends GetxController with StorageService {
  final isLogged = false.obs;
  DioClient _dioClient = Get.put(DioClient());

  void login(String? token) async {
    if(token != null) {
      isLogged.value = true;
      await setAccessToken(token!);
      await saveUserInfo(token);
    }
  }

  void addRefreshToken(String token) async {
    await setRefreshToken(token);
  }

  void logout() async {
    isLogged.value = false;
    removeTokens();
  }

  void saveRefreshToken(response) async {
    var cookies = response.headers['set-cookie'];

    if(cookies != null) {
      final cookiesList = cookies!.split(';');
      for (var element in cookiesList) {
        if(element.contains('jwt=')){
          //TODO delete
          log("refresh " + element);
          addRefreshToken(element);
        }
      }
    }
  }

  Future<void> checkAuthStatus() async {
    try {
      bool accessToken = await isAccessToken();
      if (accessToken) {
        isLogged.value = true;
      }
    } catch(e) {
      isLogged.value = false;
    }
  }

  Future<void> saveUserInfo(String token) async {
    Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
    //decodedToken.forEach((key, value) {log("key val: "+ key.toString() + " - " + value.toString());});
    log("email: " + decodedToken['user']['email'].toString());
    String userEmail = decodedToken['user']['email'];
    final result = await _dioClient.dioClient.get('http://10.0.2.2:3001/users/email/' + userEmail);
    log("res: " + result.toString());
  }
}
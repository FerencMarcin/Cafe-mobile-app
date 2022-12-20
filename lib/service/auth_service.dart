import 'dart:developer';

import 'package:cafe_mobile_app/service/storage_service.dart';
import 'package:get/get.dart';

class AuthService extends GetxController with StorageService {
  final isLogged = false.obs;

  void login(String? token) async {
    isLogged.value = true;
    await setAccessToken(token!);
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
}
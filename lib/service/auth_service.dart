import 'package:cafe_mobile_app/service/storage_service.dart';
import 'package:get/get.dart';

class AuthService extends GetxController with StorageService {
  final isLogged = false.obs;

  void login(String? token) async {
    isLogged.value = true;
    await setToken(token!);
  }

  void logout() async {
    isLogged.value = false;
    removeToken();
  }

  Future<void> checkAuthStatus() async {
    try {
      bool token = await isToken();
      if (token) {
        isLogged.value = true;
      }
    } catch(e) {
      isLogged.value = false;
    }
  }
}
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

mixin StorageService {
  final secureStorage = const FlutterSecureStorage();

  Future<void> setAccessToken(String token) async {
    await secureStorage.write(key: 'AccessToken', value: token);
  }

  Future<void> setRefreshToken(String token) async{
    await secureStorage.write(key: 'RefreshToken', value: token);
  }

  Future<String?> getAccessToken() async {
    return await secureStorage.read(key: 'AccessToken');
  }

  Future<String?> getRefreshToken() async {
    return await secureStorage.read(key: 'RefreshToken');
  }

  Future<bool> isAccessToken() async {
    String? value = await getAccessToken();
    return !(value == null);
  }

  Future<void> removeTokens() async {
    secureStorage.delete(key: 'AccessToken');
    secureStorage.delete(key: 'RefreshToken');
    secureStorage.deleteAll();
  }
}
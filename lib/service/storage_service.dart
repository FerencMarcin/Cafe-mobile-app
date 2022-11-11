import 'package:flutter_secure_storage/flutter_secure_storage.dart';

mixin StorageService {
  final secureStorage = FlutterSecureStorage();

  Future<void> setToken(String token) async {
    await secureStorage.write(key: 'TOKEN', value: token);
  }

  Future<String?> getToken() async {
    final value = await secureStorage.read(key: 'TOKEN');
    return value;
  }

  Future<void> removeToken() async {
    secureStorage.delete(key: 'TOKEN');
    secureStorage.deleteAll();
  }
}
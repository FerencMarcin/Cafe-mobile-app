import 'dart:developer';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

mixin StorageService {
  final secureStorage = FlutterSecureStorage();

  Future<void> setAccessToken(String token) async {
    await secureStorage.write(key: 'AccessToken', value: token);
  }

  Future<void> setRefreshToken(String token) async{
    await secureStorage.write(key: 'RefreshToken', value: token);
  }

  Future<String?> getAccessToken() async {
    final value = await secureStorage.read(key: 'AccessToken');
    log('token form storage: $value');
    return value;
  }

  Future<String?> getRefreshToken() async {
    final value = await secureStorage.read(key: 'RefreshToken');
    log('token form storage: $value');
    return value;
  }

  Future<bool> isAccessToken() async {
    var value = await secureStorage.read(key: 'AccessToken');
    return !(value == null); // MF: refactor
    if(value != null) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> removeTokens() async {
    secureStorage.delete(key: 'AccessToken');
    secureStorage.delete(key: 'RefreshToken');
    secureStorage.deleteAll();
  }
}
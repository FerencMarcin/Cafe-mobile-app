import 'dart:developer';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

mixin StorageService {
  final secureStorage = FlutterSecureStorage();

  Future<void> setToken(String token) async {
    await secureStorage.write(key: 'TOKEN', value: token);
  }

  Future<String?> getToken() async {
    final value = await secureStorage.read(key: 'TOKEN');
    //log('token form storage: $value');
    return value;
  }

  Future<bool> isToken() async {
    var value = await secureStorage.read(key: 'token');
    return !(value == null); // MF: refactor
    if(value != null) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> removeToken() async {
    secureStorage.delete(key: 'TOKEN');
    secureStorage.deleteAll();
  }
}
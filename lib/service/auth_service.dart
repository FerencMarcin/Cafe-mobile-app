import 'dart:convert';
import 'dart:developer';

import 'package:cafe_mobile_app/service/storage_service.dart';
import 'package:get/get.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'interceptor/dioClient.dart';

class AuthService extends GetxController with StorageService {
  final isLogged = false.obs;
  final DioClient _dioClient = Get.put(DioClient());


  void login(String? token) async {
    if(token != null) {
      isLogged.value = true;
      await setAccessToken(token!);
      await fetchUserInfo(token);
    }
  }

  void addRefreshToken(String token) async {
    await setRefreshToken(token);
  }

  void logout() async {
    isLogged.value = false;
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

  Future<void> fetchUserInfo(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
    String userEmail = decodedToken['user']['email'];
    final response = await _dioClient.dioClient.get('http://10.0.2.2:3001/users/email/' + userEmail);
    //log("data : " + response.toString());

    prefs.setString('userFirstname', response.data['firstname']);
    prefs.setString('userLastname', response.data['lastname']);
    prefs.setInt('userId', response.data['id']);
    prefs.setInt('userPoints', response.data['points']);
    //Todo refactor
    // String? stringValue = prefs.getString('userFirstname');
    // log('firstname $stringValue');
  }

  Future<bool> checkIsTokensExpired() async {
    var accessToken = await getAccessToken();
    var refreshToken = await getRefreshToken();
    if((accessToken != null) && (refreshToken != null)){
      if (JwtDecoder.isExpired(accessToken) && JwtDecoder.isExpired(refreshToken)){
        log('tokeny przeterminowane');
        return true;
      } else {
        log('tokeny zdatne');
        return false;
      }
    } else {
      return true;
    }
  }

  // Future<void> fetchUserPoints(String token) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //
  //   Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
  //   String userEmail = decodedToken['user']['email'];
  //   final response = await _dioClient.dioClient.get('http://10.0.2.2:3001/users/email/' + userEmail);
  //
  //   prefs.setInt('userPoints', response.data['points']);
  // }

}
import 'dart:developer';

import 'package:cafe_mobile_app/model/user_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../service/interceptor/dioClient.dart';

class UserViewModel {
  final DioClient _dioClient = Get.put(DioClient());

  final String userInfoUrl = '${dotenv.env['BASE_URL']!}/users';
  final String userEditUrl = '${dotenv.env['BASE_URL']!}/users/edit';
  final String userChangePasswordUrl = '${dotenv.env['BASE_URL']!}/users/changepassword';

  Future<String?> getUsername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return '${prefs.getString('userFirstname')} ${prefs.getString('userLastname')}';
  }

  Future<String> getUserPoints() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? userId = prefs.getInt('userId');
    if(userId == null) {
      return "Wystąpił błąd";
    }
    final response = await _dioClient.dioClient.get('$userInfoUrl/$userId');
    if(response.statusCode == 200) {
      prefs.setInt('userPoints', response.data['points']);
      return response.data['points'].toString();
    } else if (response.statusCode == 403) {
      throw 403;
    }
    return "Wystąpił błąd";
  }

  Future<UserModel> getUserData() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? userId = prefs.getInt('userId');
    if(userId == null) {
      throw "Wystąpił błąd";
    }
    final response = await _dioClient.dioClient.get('$userInfoUrl/$userId');
    if(response.statusCode == 200) {
      UserModel userData = UserModel();
      userData = UserModel.fromJSON(response.data);
      return userData;
    } else if (response.statusCode == 403) {
      throw 403;
    }
    throw "Wystąpił błąd";
  }

  Future<String> updateUserData(String firstName, String lastName, String email, String phone, String sex) async{
    log('firstname: $firstName, lastname: $lastName, email: $email, phone: $phone');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? userId = prefs.getInt('userId');
    if(userId == null) {
      throw "Wystąpił błąd";
    }
    final response = await _dioClient.dioClient.put('$userEditUrl/$userId', data: {
      'firstname': firstName,
      'lastname': lastName,
      'email': email,
      'phone': phone,
      'sex': sex,
      'RoleId': 1
    });
    log(response.data.toString());
    if(response.statusCode == 200) {
      return response.data['message'];
    } else if (response.statusCode == 403) {
      throw 403;
    } else if (response.statusCode == 400) {
      throw response.data['error'];
    }
    throw "Wystąpił błąd";
  }

  Future<String> changePassword(String currentPassword, String newPassword) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? userId = prefs.getInt('userId');
    if(userId == null) {
      throw "Wystąpił błąd";
    }
    final response = await _dioClient.dioClient.put('$userChangePasswordUrl/$userId', data: {
      'password': currentPassword,
      'newPassword': newPassword
    });
    log(response.data.toString());
    if(response.statusCode == 200) {
      return response.data['message'];
    } else if (response.statusCode == 403) {
      throw 403;
    } else if (response.statusCode == 400) {
      throw response.data['error'];
    }
    throw "Wystąpił błąd";
  }

}
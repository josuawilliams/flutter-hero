import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_hero/services/api.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  void showAlert() {}

  Future<dynamic> RegisterUser({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final req = {'name': name, 'email': email, 'password': password};
      final res = await API().RegisteredUser(req);
      return res;
    } catch (e) {
      return e;
    }
  }

  Future<dynamic> LoginUser(
      {required String email, required String password}) async {
    try {
      final req = {"email": email, "password": password};
      final res = await API().LoginUser(req);
      final access_token = jsonDecode(res.toString());
      SharedPreferences pref = await SharedPreferences.getInstance();
      await pref.setString("token", access_token["accessToken"]);
      await pref.setString("name", access_token["name"]);
      await pref.setString("email", access_token["email"]);
      await pref.setString("role", access_token["role"]);
      return 200;
    } catch (e) {
      return e;
    }
  }
}

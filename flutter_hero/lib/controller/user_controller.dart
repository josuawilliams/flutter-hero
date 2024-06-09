import 'package:dio/dio.dart';
import 'package:flutter_hero/services/api.dart';
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
      print(res);
      return res;
    } catch (e) {
      return e;
    }
  }
}

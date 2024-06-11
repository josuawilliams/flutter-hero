import 'package:flutter/material.dart';
import 'package:flutter_hero/models/favorite_res_model.dart';
import 'package:flutter_hero/models/heroes_res_model.dart';
import 'package:flutter_hero/pages/login_page.dart';
import 'package:flutter_hero/services/api.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HeroesController extends GetxController
    with StateMixin<List<HeroesResModel>> {
  @override
  void onInit() {
    getListHeroes();
    super.onInit();
  }

  void getListHeroes() async {
    final response = await API().getAllHeroes();
    response.fold((l) async {
      if (l == "jwt expired") {
        final prefs = await SharedPreferences.getInstance();
        await prefs.remove('token');
        Get.offAll(() => LoginPage());
        return;
      } else {
        change(null, status: RxStatus.error(l.toString()));
      }
    }, (r) => change(r, status: RxStatus.success()));
  }
}

class FavoriteController extends GetxController
    with StateMixin<List<FavoriteResModel>> {
  @override
  void onInit() {
    getFavoriteHeroes();
    super.onInit();
  }

  void getFavoriteHeroes() async {
    final response = await API().getAllFavoriteHeroes();
    response.fold((l) async {
      if (l == "jwt expired") {
        final prefs = await SharedPreferences.getInstance();
        await prefs.remove('token');
        Get.offAll(() => LoginPage());
        return;
      } else {
        change(null, status: RxStatus.error(l.toString()));
      }
    }, (r) => change(r, status: RxStatus.success()));
  }
}

class AddFavoriteController extends GetxController {

  Future<dynamic> AddFavoriteHeroes({
    required String id,
  }) async {
    try {
      final res = await API().AddFavoriteHero(id);
      return res;
    } catch (e) {
      return e;
    }
  }
}

class DeleteFavoriteController extends GetxController {

  Future<dynamic> DeleteFavoriteHeroes({
    required String id,
  }) async {
    try {
      final res = await API().DeleteFavoriteHero(id);
      return res;
    } catch (e) {
      return e;
    }
  }
}


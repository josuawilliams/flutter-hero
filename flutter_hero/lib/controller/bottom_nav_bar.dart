import 'package:flutter_hero/controller/heroes_controller.dart';
import 'package:flutter_hero/pages/component/favorite_heroes.dart';
import 'package:flutter_hero/pages/component/list_heroes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hero/pages/component/profile.dart';
import 'package:get/get.dart';

class BottomNavigationBarController extends GetxController {
  RxInt index = 0.obs;

  var pages = [ListHeroesPage(), FavoritePage(), ProfilePage()];

  void changePage(int newIndex) {
    index.value = newIndex;
    // Refresh the favorite page if it's selected
    if (newIndex == 1) {
      Get.find<FavoriteController>().getFavoriteHeroes();
    }
    if (newIndex == 0) {
      Get.find<HeroesController>().getListHeroes();
    }
  }
}

class BottomNavigationBarTitle extends GetxController {
  RxInt index = 0.obs;

  var pages = [
    const Center(
        child: Text(
      "List Heroes",
      style: TextStyle(
          fontSize: 30, fontWeight: FontWeight.bold, color: Colors.black),
    )),
    const Center(
        child: Text(
      "Favorite Heroes",
      style: TextStyle(
          fontSize: 30, fontWeight: FontWeight.bold, color: Colors.black),
    )),
    const Center(
        child: Text(
      "Profile",
      style: TextStyle(
          fontSize: 30, fontWeight: FontWeight.bold, color: Colors.black),
    )),
  ];
}

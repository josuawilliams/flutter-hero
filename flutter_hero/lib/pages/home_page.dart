import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hero/controller/bottom_nav_bar.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class HomePage extends StatelessWidget {
  var height, width;
  HomePage({super.key});

  BottomNavigationBarController controllerBar =
      Get.put(BottomNavigationBarController());

  BottomNavigationBarTitle controllerTitle =
      Get.put(BottomNavigationBarTitle());

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
        bottomNavigationBar: Container(
          color: Colors.black,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: GNav(
              gap: 6,
              textStyle: const TextStyle(
                  color: Colors.black, fontWeight: FontWeight.bold),
              backgroundColor: Colors.black,
              color: Colors.white,
              tabBorderRadius: 20,
              activeColor: Colors.orangeAccent,
              tabBackgroundColor: const Color.fromARGB(255, 231, 231, 231),
              padding: const EdgeInsets.only(
                  top: 10, bottom: 16, left: 40, right: 40),
              onTabChange: (value) {
                controllerBar.index.value = value;
                controllerTitle.index.value = value;
                controllerBar.changePage(value);
              },
              tabs: const [
                GButton(
                  icon: Icons.home,
                  text: "Home",
                ),
                GButton(
                  icon: Icons.favorite_border,
                  text: "Favorit",
                ),
                GButton(
                  icon: Icons.person,
                  text: "Profile",
                ),
              ],
            ),
          ),
        ),
        body: SafeArea(
            child: Container(
          color: Colors.blue[200],
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(),
                height: height * 0.08,
                width: width,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 15, left: 25),
                      child: Row(
                        children: [
                          Obx(() => controllerTitle
                              .pages[controllerTitle.index.value])
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30))),
                  height: height * 0.80,
                  width: width,
                  child: Obx(
                      () => controllerBar.pages[controllerBar.index.value])),
            ],
          ),
        )));
  }
}

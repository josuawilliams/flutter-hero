import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class HomePage extends StatelessWidget {
  var height, width;
  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
        bottomNavigationBar: Container(
          color: Colors.black,
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: GNav(
              gap: 6,
              textStyle:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              backgroundColor: Colors.black,
              color: Colors.white,
              activeColor: Colors.orangeAccent,
              tabBackgroundColor: Color.fromARGB(255, 231, 231, 231),
              padding:
                  EdgeInsets.only(top: 10, bottom: 16, left: 40, right: 40),
              tabs: [
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
                child: const Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 15, left: 25),
                      child: Row(
                        children: [
                          Text(
                            "List Heroes",
                            style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          )
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
              ),
            ],
          ),
        )));
  }
}

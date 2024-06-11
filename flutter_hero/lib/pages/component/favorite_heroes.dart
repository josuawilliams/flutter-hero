import 'package:flutter/material.dart';
import 'package:flutter_hero/controller/heroes_controller.dart';
import 'package:flutter_hero/pages/detail_hero_page.dart';
import 'package:get/get.dart';

class FavoritePage extends StatelessWidget {
  FavoritePage({Key? key}) : super(key: key);

  final controllerFavorite = Get.put(FavoriteController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: controllerFavorite.obx(
      (state) => ListView.builder(
        itemCount: state!.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              elevation: 4.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: ListTile(
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.network(
                    state[index].imageUrl.toString(),
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  ),
                ),
                title: Text(state[index].name.toString(),
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text(state[index].type.toString()),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => DetailHeroPage(
                            hero: state[index],
                          )));
                },
              ),
            ),
          );
        },
      ),
    ));
  }
}

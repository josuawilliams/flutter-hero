import 'package:flutter/material.dart';
import 'package:flutter_hero/pages/detail_hero_page.dart';
import 'package:get/get.dart';
import 'package:flutter_hero/controller/heroes_controller.dart';

class ListHeroesPage extends StatelessWidget {
  ListHeroesPage({Key? key}) : super(key: key);
  final controllerList = Get.put(HeroesController());

  @override
  Widget build(BuildContext context) {
    print(controllerList);

    return Padding(
        padding: const EdgeInsets.only(top: 25),
        child: controllerList.obx((state) => GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.6,
                mainAxisSpacing: 20,
              ),
              itemCount: state!.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => DetailHeroPage(
                              hero: state[index],
                            )));
                  },
                  child: Container(
                    margin:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black,
                          spreadRadius: 1,
                          blurRadius: 6,
                        )
                      ],
                    ),
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.network(
                            state[index].imageUrl.toString(),
                            height: 250,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          state[index].name.toString(),
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          state[index].type.toString(),
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            )));
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hero/components/allert.dart';
import 'package:flutter_hero/components/button.dart';
import 'package:flutter_hero/controller/heroes_controller.dart';
import 'package:flutter_hero/models/favorite_res_model.dart';
import 'package:flutter_hero/models/heroes_res_model.dart';
import 'package:flutter_hero/pages/home_page.dart';
import 'package:get/get.dart';

class DetailHeroPage extends StatefulWidget {
  DetailHeroPage({super.key, required this.hero});
  final dynamic hero;

  @override
  State<DetailHeroPage> createState() => _DetailHeroPageState();
}

class _DetailHeroPageState extends State<DetailHeroPage> {
  final controller = Get.put(AddFavoriteController());
  final controllerDelete = Get.put(DeleteFavoriteController());
  bool isLoading = false;

  void addFavorite(BuildContext context, id) async {
    setState(() {
      isLoading = true;
    });

    final response = await controller.AddFavoriteHeroes(id: id);
    if (response.toString().contains("Berhasil")) {
      // ignore: use_build_context_synchronously
      showAlert(
          context,
          response.toString(),
          () => {
                Get.find<FavoriteController>().getFavoriteHeroes(),
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                )
              });
    } else {
      showAlertError(context, response.toString());
    }

    setState(() {
      isLoading = false;
    });
  }

  void deleteFavorite(BuildContext context, id) async {
    setState(() {
      isLoading = true;
    });

    final response = await controllerDelete.DeleteFavoriteHeroes(id: id);
    if (response.toString().contains("Berhasil")) {
      // ignore: use_build_context_synchronously
      showAlert(
          context,
          response.toString(),
          () => {
                Get.find<FavoriteController>().getFavoriteHeroes(),
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                )
              });
    } else {
      showAlertError(context, response.toString());
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.width - (40),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: const [
                    BoxShadow(
                        color: Colors.grey, offset: Offset(3, 3), blurRadius: 5)
                  ],
                  image: DecorationImage(
                    image: NetworkImage(widget.hero.imageUrl.toString()),
                    scale: 1.2,
                  )),
            ),
            const SizedBox(height: 30),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
                boxShadow: const [
                  BoxShadow(
                      color: Colors.grey, offset: Offset(3, 3), blurRadius: 5)
                ],
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 120, vertical: 20),
                child: Column(
                  children: [
                    Text(
                      widget.hero.name.toString(),
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      widget.hero.type.toString(),
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 2.0,
                      ),
                      child: ButtonWidget(
                        onTap: () =>
                            addFavorite(context, widget.hero.sId.toString()),
                        TextButton: 'Tambah Favorit',
                        // Mengatur warna tombol menjadi merah
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 2.0),
                      child: ButtonWidget(
                        onTap: () =>
                            deleteFavorite(context, widget.hero.sId.toString()),
                        TextButton: 'Hapus Favorit',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

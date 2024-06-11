import 'package:flutter/material.dart';
import 'package:flutter_hero/components/allert.dart';
import 'package:flutter_hero/components/button.dart';
import 'package:flutter_hero/controller/user_controller.dart';
import 'package:flutter_hero/pages/home_page.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditUserPage extends StatefulWidget {
  EditUserPage({super.key, required this.name});
  final dynamic name;

  @override
  State<EditUserPage> createState() => _EditUserPageState();
}

class _EditUserPageState extends State<EditUserPage> {
  final controller = Get.put(UserController());
  final TextEditingController namaController = TextEditingController();

  void initState() {
    namaController.text = widget.name.toString();
  }

  void editUser(BuildContext context, nama) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    final response = await controller.UpdateUser(name: nama);
    if (response.toString() != null) {
      await pref.setString("name", response.toString());
      // ignore: use_build_context_synchronously
      showAlert(
          context,
          "Berhasil Mengganti Nama",
          () => {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                )
              });
    } else {
      showAlertError(context, response.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        appBar: AppBar(
          title: Text("Edit Nama"),
          centerTitle: true,
        ),
        body: Container(
          padding: EdgeInsets.all(20),
          child: ListView(
            children: [
              TextFormField(
                controller: namaController,
                decoration: InputDecoration(
                    labelText: "Nama", border: OutlineInputBorder()),
              ),
              SizedBox(height: 20),
              ButtonWidget(
                onTap: () {
                  editUser(context, namaController.text.toString());
                  // Navigator.pushReplacement(context,
                  //     MaterialPageRoute(builder: (context) => LoginPage()));
                },
                TextButton: 'Submit',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

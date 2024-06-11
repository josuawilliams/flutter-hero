import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hero/components/allert.dart';
import 'package:flutter_hero/components/button.dart';
import 'package:flutter_hero/components/input_field.dart';
import 'package:flutter_hero/controller/user_controller.dart';
import 'package:flutter_hero/pages/login_page.dart';
import 'package:get/get.dart';
import 'package:quickalert/quickalert.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  final controller = Get.put(UserController());
  bool isLoading = false;

  void signUpUser(BuildContext context) async {
    setState(() {
      isLoading = true;
    });

    final response = await controller.RegisterUser(
      email: emailController.text,
      name: nameController.text,
      password: passwordController.text,
    );
    if (response.toString().contains("Berhasil")) {
      // ignore: use_build_context_synchronously
      showAlert(
        context,
        response.toString(),
        () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => LoginPage()),
          );
        },
      );
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
      backgroundColor: Colors.grey[300],
      body: SingleChildScrollView(
        child: SafeArea(
          child: Center(
            child: Column(
              children: [
                const SizedBox(
                  height: 100,
                ),
                Text(
                  "Welcome To Hero App",
                  style: TextStyle(color: Colors.grey[800], fontSize: 25),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "Register User",
                  style: TextStyle(color: Colors.grey[800], fontSize: 25),
                ),
                const SizedBox(
                  height: 25,
                ),
                InputField(
                  controller: nameController,
                  hintText: "Nama",
                  obscureText: false,
                ),
                const SizedBox(
                  height: 15,
                ),
                InputField(
                  controller: emailController,
                  hintText: "Email",
                  obscureText: false,
                ),
                const SizedBox(
                  height: 15,
                ),
                InputField(
                  controller: passwordController,
                  hintText: "Password",
                  obscureText: false,
                ),
                const SizedBox(
                  height: 45,
                ),
                isLoading
                    ? const CircularProgressIndicator()
                    : ButtonWidget(
                        onTap: () => signUpUser(context),
                        TextButton: 'Sign Up',
                      ),
                const SizedBox(
                  height: 15,
                ),
                RichText(
                  text: TextSpan(
                    text: "Have an account? ",
                    style: const TextStyle(fontSize: 15, color: Colors.black),
                    children: [
                      TextSpan(
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginPage()),
                            );
                          },
                        text: "Sign In",
                        style: const TextStyle(
                          fontSize: 15,
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

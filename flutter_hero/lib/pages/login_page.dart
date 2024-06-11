import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hero/components/allert.dart';
import 'package:flutter_hero/components/button.dart';
import 'package:flutter_hero/components/input_field.dart';
import 'package:flutter_hero/controller/user_controller.dart';
import 'package:flutter_hero/pages/home_page.dart';
import 'package:flutter_hero/pages/register_page.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // Editing Controller
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final controller = Get.put(UserController());
  bool isLoading = false;

  void signInUser(BuildContext context) async {
    setState(() {
      isLoading = true;
    });

    final response = await controller.LoginUser(
        email: emailController.text, password: passwordController.text);

    print(response.toString());
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    if (token != null) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomePage()));
    } else if (token == null) {
      if (response.toString() == "Masukkan Email") {
        showAlertError(context, response.toString());
      } else if (response.toString() == "Masukkan Password") {
        showAlertError(context, response.toString());
      } else {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => LoginPage()));
      }
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
                const SizedBox(height: 50),
                const Icon(
                  Icons.lock,
                  size: 100,
                ),
                const SizedBox(
                  height: 50,
                ),
                Text(
                  "Welcome To Hero App",
                  style: TextStyle(color: Colors.grey[800], fontSize: 25),
                ),
                const SizedBox(
                  height: 25,
                ),

                //Username
                InputField(
                  controller: emailController,
                  hintText: "Email",
                  obscureText: false,
                ),
                const SizedBox(
                  height: 15,
                ),

                //Password
                InputField(
                  controller: passwordController,
                  hintText: "Password",
                  obscureText: true,
                ),
                const SizedBox(
                  height: 45,
                ),
                isLoading
                    ? const CircularProgressIndicator()
                    : ButtonWidget(
                        onTap: () => signInUser(context),
                        TextButton: 'Sign In',
                      ),
                const SizedBox(
                  height: 15,
                ),

                RichText(
                  text: TextSpan(
                      text: "Don't have an account? ",
                      style: const TextStyle(fontSize: 15, color: Colors.black),
                      children: [
                        TextSpan(
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => RegisterPage()));
                            },
                          text: "Sign up",
                          style: const TextStyle(
                              fontSize: 15,
                              color: Colors.blue,
                              fontWeight: FontWeight.bold),
                        ),
                      ]),
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

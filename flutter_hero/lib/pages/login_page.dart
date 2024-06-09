import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hero/components/button.dart';
import 'package:flutter_hero/components/input_field.dart';
import 'package:flutter_hero/pages/register_page.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  // Editing Controller
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void signInUser() {
    print("Loginnnnnnn");
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
                ButtonWidget(
                  onTap: signInUser,
                  TextButton: "Sign In",
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

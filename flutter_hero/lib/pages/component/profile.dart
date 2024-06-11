import 'package:flutter/material.dart';
import 'package:flutter_hero/components/button.dart';
import 'package:flutter_hero/pages/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: FutureBuilder(
            future: SharedPreferences.getInstance(),
            builder: (context, AsyncSnapshot<SharedPreferences> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else {
                if (snapshot.hasData) {
                  SharedPreferences prefs = snapshot.data!;
                  String name = prefs.getString('name') ?? '';
                  String email = prefs.getString('email') ?? '';
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Name: $name',
                        style: const TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10.0),
                      Text(
                        'Email: $email',
                        style: const TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 20.0),
                      ButtonWidget(
                        onTap: () async {
                          await prefs.remove('token');
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginPage()));
                        },
                        TextButton: 'Log Out',
                      ),
                    ],
                  );
                } else {
                  return const Text('Failed to load user information');
                }
              }
            },
          ),
        ),
      ),
    );
  }
}

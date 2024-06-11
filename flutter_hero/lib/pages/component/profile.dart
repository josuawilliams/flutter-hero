import 'package:flutter/material.dart';
import 'package:flutter_hero/components/button.dart';
import 'package:flutter_hero/pages/login_page.dart';
import 'package:flutter_hero/pages/update_user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
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
                          'Nama: $name',
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
                        const SizedBox(height: 20),
                        ButtonWidget(
                          onTap: () async {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        EditUserPage(name: name)));
                          },
                          TextButton: 'Edit Nama',
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
      ),
    );
  }
}

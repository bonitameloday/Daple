import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginHomePage extends StatefulWidget {
  const LoginHomePage({super.key});

  @override
  State<LoginHomePage> createState() => _LoginHomePageState();
}

class _LoginHomePageState extends State<LoginHomePage> {

  final user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('signed in as: ' + user.email!),
              SizedBox(height: 25),
              MaterialButton(onPressed: () {
                FirebaseAuth.instance.signOut();
              },
                color: Colors.lightGreen[200],
                child: Text('Log Out'),
              )
            ],
          )
      ),
    );
  }
}


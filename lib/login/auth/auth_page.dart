import 'package:flutter/material.dart';
import 'package:google_map/login/pages/login_page.dart';
import 'package:google_map/login/pages/register_page.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {

  // initially, show the login page
  bool showLoginPage = true;

  void toogleScreens() {
    setState(() {
      showLoginPage =! showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginPage) {
      return LoginPage(showRegisterPage: toogleScreens);
    } else {
      return RegisterPage(showLoginPage: toogleScreens);
    }
  }
}

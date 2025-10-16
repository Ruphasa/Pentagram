import 'package:flutter/material.dart';
import 'package:pentagram/pages/login/login_form.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                LoginHeader(),
                SizedBox(height: 40),
                LoginForm(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

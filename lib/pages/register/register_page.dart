import 'package:flutter/material.dart';
import 'package:pentagram/widgets/register_form.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    const secondaryColor = Color(0xFF5a63b9);

    return Scaffold(
      backgroundColor: secondaryColor.withOpacity(0.08),
      body: const SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Jawara Pintar',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF5a63b9),
                  ),
                ),
                SizedBox(height: 40),
                RegisterForm(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

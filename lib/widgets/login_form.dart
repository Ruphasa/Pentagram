import 'package:flutter/material.dart';

class LoginHeader extends StatelessWidget {
  const LoginHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text(
      'Jawara Pintar',
      style: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: Color(0xFF5a63b9), 
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isHoveringButton = false;
  bool _isHoveringRegister = false;

  void _login() {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Email dan password harus diisi'), backgroundColor: Colors.red),
      );
      return;
    }

    if (email == 'admin@gmail.com' && password == 'password') {
      Navigator.pushReplacementNamed(context, '/');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Email atau password salah'), backgroundColor: Colors.red),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 500),
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Masuk ke akun anda',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Login untuk mengakses sistem Jawara Pintar.',
            style: TextStyle(fontSize: 14, color: Colors.black54),
          ),
          const SizedBox(height: 32),
          _buildTextField('Email', _emailController, false),
          const SizedBox(height: 24),
          _buildTextField('Password', _passwordController, true),
          const SizedBox(height: 32),
          _buildLoginButton(),
          const SizedBox(height: 20),
          _buildRegisterLink(context),
        ],
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller, bool obscure) {
    const secondaryColor = Color(0xFF5a63b9);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          obscureText: obscure,
          style: const TextStyle(color: Colors.black87),
          decoration: InputDecoration(
            hintText: 'Masukkan $label di sini',
            hintStyle: const TextStyle(color: Colors.black38),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.black26, width: 1.5),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.black26, width: 1.5),
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: secondaryColor, width: 2),
            ),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          ),
        ),
      ],
    );
  }

  Widget _buildLoginButton() {
    const secondaryColor = Color(0xFF5a63b9);

    return MouseRegion(
      onEnter: (_) => setState(() => _isHoveringButton = true),
      onExit: (_) => setState(() => _isHoveringButton = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        transform: Matrix4.identity()..scale(_isHoveringButton ? 1.02 : 1.0),
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: _login,
            style: ElevatedButton.styleFrom(
              backgroundColor: secondaryColor,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              elevation: _isHoveringButton ? 8 : 2,
            ),
            child: const Text(
              'Login',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRegisterLink(BuildContext context) {
    const secondaryColor = Color(0xFF5a63b9);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('Belum punya akun? ',
            style: TextStyle(fontSize: 14, color: Colors.black54)),
        MouseRegion(
          onEnter: (_) => setState(() => _isHoveringRegister = true),
          onExit: (_) => setState(() => _isHoveringRegister = false),
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: () => Navigator.pushReplacementNamed(context, '/register'),
            child: Text(
              'Daftar',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: secondaryColor,
                decoration: _isHoveringRegister
                    ? TextDecoration.underline
                    : TextDecoration.none,
                decorationColor: secondaryColor,
                decorationThickness: 2,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

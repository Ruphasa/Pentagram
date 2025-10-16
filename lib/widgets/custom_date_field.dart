import 'package:flutter/material.dart';
import 'package:pentagram/utils/app_colors.dart';

class CustomDateField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final VoidCallback onTap;
  final String? Function(String?)? validator;

  const CustomDateField({
    super.key,
    required this.controller,
    required this.hint,
    required this.onTap,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      readOnly: true,
      onTap: onTap,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(
          color: Colors.grey[600],
          fontSize: 14,
        ),
        filled: true,
        fillColor: const Color(0xFF0F0F13),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Color(0xFF333333)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Color(0xFF333333)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.magenta, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
        suffixIcon: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.close, size: 18, color: AppColors.white),
              onPressed: () {
                controller.clear();
              },
            ),
            IconButton(
              icon: const Icon(Icons.calendar_today, size: 18, color: AppColors.cyan),
              onPressed: onTap,
            ),
          ],
        ),
      ),
      style: const TextStyle(color: AppColors.white),
      validator: validator ?? (value) {
        if (value == null || value.isEmpty) {
          return 'Field ini harus diisi';
        }
        return null;
      },
    );
  }
}

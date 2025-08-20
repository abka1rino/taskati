import 'dart:ui';

import 'package:flutter/material.dart';

class CustomSearchTextFormField extends StatelessWidget {
  const CustomSearchTextFormField({
    super.key,
    required this.labelText,
    this.suffixIcon,
    this.prefixIcon,
    this.onChanged,
    this.validator,
    this.obscureText = false,
  });
  final String labelText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final Function(String)? onChanged;
  final String? Function(dynamic)? validator;
  final bool obscureText;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText,
      validator: validator,
      onChanged: onChanged,
      decoration: InputDecoration(
        fillColor: Color(0xFFF2F3F2),
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.0),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.0),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.0),
          borderSide: BorderSide.none,
        ),
        prefixIconColor: Color(0xFF181B19),
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        label: Text(labelText),
      ),
    );
  }
}

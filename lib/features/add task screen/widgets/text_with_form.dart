import 'package:flutter/material.dart';
import 'package:taskati/core/utils/app_colors.dart';
import 'package:taskati/core/utils/text_style.dart';

class TextWithForm extends StatelessWidget {
  const TextWithForm({
    super.key,
    required this.title,
    this.controller,
    this.readOnly = false,
    this.suffixIcon,
    this.onTap,
    this.maxLines,
    this.hintText,
    this.validator,
    this.onChanged,
  });
  final String title;
  final TextEditingController? controller;
  final bool readOnly;
  final IconData? suffixIcon;
  final VoidCallback? onTap;
  final int? maxLines;
  final String? hintText;
  final String? Function(String?)? validator;
  final ValueChanged<String>? onChanged;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: TextStyles.getBody(fontWeight: FontWeight.w600)),
        SizedBox(height: 7),
        TextFormField(
          validator: validator,
          maxLines: maxLines,
          onTap: onTap,
          controller: controller,
          readOnly: readOnly,
          onChanged: onChanged,
          decoration: InputDecoration(
            hintStyle: TextStyles.getBody(),
            hintText: hintText,
            suffixIcon: Icon(suffixIcon, color: AppColors.primaryColor),
          ),
        ),
      ],
    );
  }
}

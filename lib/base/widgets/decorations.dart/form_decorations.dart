import 'package:flutter/material.dart';
import 'package:zoozitest/base/utils/colors.dart';

class FormDecorations {
  FormDecorations._();

  static InputDecoration defaultDecoration({
    String? hintText,
    Widget? prefixIcon,
    required BuildContext context,
  }) {
    return InputDecoration(
      filled: true,
      fillColor: AppColors.formBackground(context),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      hintText: hintText,
      prefixIcon: prefixIcon,
    );
  }
}

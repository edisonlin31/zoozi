import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // Primary colors
  static const Color primary = Colors.teal;

  // Light mode colors
  static const Color lightGrey = Color(0xFFF9F9F9);
  static const Color lightBackground = Colors.white;
  static const Color lightCard = Color(0xFFF5F5F5);
  static const Color lightText = Colors.black;
  static const Color lightSecondaryText = Color(0xFF757575);
  static const Color lightFormBackground = Color(0xFFF0F0F0);
  // Dark mode colors
  static const Color darkGrey = Color(0xFF212121);
  static const Color darkBackground = Color(0xFF1A1A1A);
  static const Color darkCard = Color(0xFF424242);
  static const Color darkText = Colors.white;
  static const Color darkSecondaryText = Color(0xFFBDBDBD);
  static const Color darkFormBackground = Color(0xFF2A2A2A);

  // Method to get colors based on theme
  static Color background(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark
      ? darkBackground
      : lightBackground;

  static Color card(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark ? darkCard : lightCard;

  static Color text(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark ? darkText : lightText;

  static Color secondaryText(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark
      ? darkSecondaryText
      : lightSecondaryText;

  static Color formBackground(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark
      ? darkFormBackground
      : lightFormBackground;
}

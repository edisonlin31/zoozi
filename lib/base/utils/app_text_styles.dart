import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextStyles {
  static TextStyle regular({
    double fontSize = 14,
    Color? color,
    TextDecoration? decoration,
    bool isSnapShot = false,
    Color? decorationColor,
    List<Shadow>? shadows,
  }) {
    return GoogleFonts.openSans(
      fontWeight: FontWeight.w400,
      fontSize: fontSize,
      color: color,
      shadows: shadows,
      decorationColor: decorationColor ?? color,
      decoration: decoration,
    );
  }

  static TextStyle medium({
    double fontSize = 14,
    Color? color,
    bool isSnapShot = false,
    TextDecoration? decoration,
    Color? decorationColor,
    List<Shadow>? shadows,
  }) {
    return GoogleFonts.openSans(
      fontWeight: FontWeight.w600,
      fontSize: fontSize,
      color: color,
      shadows: shadows,
      decoration: decoration,
      decorationColor: decorationColor ?? color,
      decorationThickness: 2,
      decorationStyle: TextDecorationStyle.solid,
    );
  }

  static TextStyle semibold({
    double fontSize = 14,
    Color? color,
    List<Shadow>? shadows,
    TextDecoration? decoration,
    Color? decorationColor,
    bool isSnapShot = false,
  }) {
    return GoogleFonts.openSans(
      fontWeight: FontWeight.w700,
      fontSize: fontSize,
      color: color,
      shadows: shadows,
      decoration: decoration,
      decorationColor: decorationColor ?? color,
      decorationThickness: 2,
    );
  }

  static TextStyle bold({
    double fontSize = 14,
    Color? color,
    List<Shadow>? shadows,
    TextDecoration? decoration,
    Color? decorationColor,
    bool isSnapShot = false,
  }) {
    return GoogleFonts.openSans(
      fontWeight: FontWeight.w700,
      fontSize: fontSize,
      color: color,
      shadows: shadows,
      decoration: decoration,
      decorationColor: decorationColor ?? color,
      decorationThickness: 2,
    );
  }
}

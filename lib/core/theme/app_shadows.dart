import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppShadows {
  static const List<BoxShadow> none = [];

  static const List<BoxShadow> xs = [
    BoxShadow(
      color: Color(0x0A000000), // 4% black
      offset: Offset(0, 1),
      blurRadius: 2,
    ),
  ];

  static const List<BoxShadow> sm = [
    BoxShadow(
      color: Color(0x0F000000), // 6% black
      offset: Offset(0, 2),
      blurRadius: 8,
    ),
  ];

  static const List<BoxShadow> md = [
    BoxShadow(
      color: Color(0x14000000), // 8% black
      offset: Offset(0, 4),
      blurRadius: 16,
    ),
  ];

  static const List<BoxShadow> lg = [
    BoxShadow(
      color: Color(0x1A000000), // 10% black
      offset: Offset(0, 8),
      blurRadius: 32,
    ),
  ];

  static const List<BoxShadow> xl = [
    BoxShadow(
      color: Color(0x1F000000), // 12% black
      offset: Offset(0, 16),
      blurRadius: 48,
    ),
  ];

  static List<BoxShadow> primary = [
    BoxShadow(
      color: AppColors.primary.withOpacity(0.30),
      offset: const Offset(0, 4),
      blurRadius: 16,
    ),
  ];

  static List<BoxShadow> floatingNav = [
    const BoxShadow(
      color: Color(0x14000000),
      offset: Offset(0, 8),
      blurRadius: 24,
      spreadRadius: 0,
    ),
  ];

  static List<BoxShadow> cardElevated = [
    const BoxShadow(
      color: Color(0x0D000000),
      offset: Offset(0, 6),
      blurRadius: 18,
    ),
  ];
}

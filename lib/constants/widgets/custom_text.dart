import 'package:coffee_shop_online/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomText extends StatelessWidget {
  CustomText({
    super.key,
    required this.text,
    this.fontSize = 24,
    this.color = AppColors.primaryColor,
    this.isBold = false,
  });

  final String text;
  final double fontSize;
  bool isBold;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.playfairDisplay(
        fontSize: fontSize,
        fontWeight: isBold ? FontWeight.w700 : FontWeight.w300,
        color: color,
      ),
    );
  }
}

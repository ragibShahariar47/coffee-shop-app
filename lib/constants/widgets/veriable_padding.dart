import 'package:flutter/material.dart';

Widget veriablePadding({required double screenWidth}) {
  return SizedBox(width: screenWidth > 1100 ? 300 : screenWidth * 0.04);
}

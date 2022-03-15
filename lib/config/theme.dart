import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData theme() {
  return ThemeData(
    primarySwatch: Colors.blue,
    fontFamily: 'San Francisco',
  );
}

const kPrimaryColor = Color.fromARGB(255, 157, 83, 231);
const kPrimaryLightColor = Color(0xFFF1E6FF);

TextStyle get subHeadingStyle {
  return GoogleFonts.lato(
    textStyle: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.bold,
      color: Colors.grey[500],
    ),
  );
}

TextStyle get headingStyle {
  return GoogleFonts.lato(
    textStyle: const TextStyle(
      fontSize: 30,
      fontWeight: FontWeight.bold,
    ),
  );
}

TextStyle get titleStyle {
  return GoogleFonts.lato(
    textStyle: const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: Colors.black,
    ),
  );
}

TextStyle get subTitleStyle {
  return GoogleFonts.lato(
    textStyle: TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.w500,
      color: Colors.grey[600],
    ),
  );
}

Color? tealColor = Colors.teal[300];
Color? whiteColor = Colors.white;
Color? redColor = Colors.red;
Color? redColor200 = Colors.red[200];
Color? blackCoffeeColor = const Color(0xFF3B2F2F);

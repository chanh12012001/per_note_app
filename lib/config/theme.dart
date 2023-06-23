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
      color: Colors.black
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

/// note

var shadow = [
  BoxShadow(
    color: Colors.grey[300]!,
    blurRadius: 30,
    offset: const Offset(0, 10),
  )
];

var itemTitle = GoogleFonts.roboto(
  textStyle: TextStyle(
    fontSize: 20.0,
    color: blackColor,
    fontWeight: FontWeight.bold,
  ),
);

var itemDateStyle = GoogleFonts.roboto(
  textStyle: TextStyle(
    fontSize: 14.0,
    color: grey2Color,
  ),
);

var itemContentStyle = GoogleFonts.roboto(
  textStyle: TextStyle(
    fontSize: 17.0,
    color: grey2Color,
  ),
);

var viewTitleStyle = GoogleFonts.roboto(
  fontWeight: FontWeight.w900,
  fontSize: 28.0,
);
var viewContentStyle = GoogleFonts.roboto(
  letterSpacing: 1.0,
  fontSize: 20.0,
  height: 1.5,
  fontWeight: FontWeight.w400,
);

var createTitle = GoogleFonts.roboto(
    textStyle: const TextStyle(
  fontSize: 28.0,
  fontWeight: FontWeight.w900,
));
var createContent = TextStyle(
  letterSpacing: 1.0,
  fontSize: 14.0,
  height: 1.5,
  fontWeight: FontWeight.w400,
);

Color? tealColor = Colors.teal[300];
Color? blueColor = Colors.blue;
Color? whiteColor = Colors.white;
Color? greyColor = Colors.grey;
Color? grey2Color = Colors.grey[700];
Color? redColor = Colors.red;
Color? redColor200 = Colors.red[200];
Color? blackColor = Colors.black;
Color? blackCoffeeColor = const Color(0xFF3B2F2F);

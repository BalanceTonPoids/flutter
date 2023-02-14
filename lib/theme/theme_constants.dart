import 'package:flutter/material.dart';

const Color black1 = Color(0xff292929);
const Color white1 = Color(0xffeeeded);
const Color blue = Color(0xff0044D6);
const Color red = Color(0xffCB0B0B);
const Color green = Color(0xff28AB21);

class LogoSection extends StatelessWidget {
  final ThemeData themeData;
  const LogoSection({Key? key, required this.themeData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 20),
      child: Image.asset(
        themeData.brightness == Brightness.light ? "assets/logo-light.png" : "assets/logo-light.png",
        height: 80,
      ),
    );
  }
}

final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: blue,
    textTheme: const TextTheme(
      bodyLarge: TextStyle(
        color: Colors.black,
      ),
      displayLarge: TextStyle(
        color: Colors.black,
      ),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: blue
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(blue)
        )
    ),
    inputDecorationTheme: InputDecorationTheme(
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: blue,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.grey,
          ),
          borderRadius: BorderRadius.circular(10),
        ),

    )
);

final ThemeData darkTheme = ThemeData(
  primaryColor: blue,
  brightness: Brightness.dark,
  textTheme: const TextTheme(
    bodyLarge: TextStyle(
      color: Colors.white,
    ),
    displayLarge: TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
    ),
  ),
  switchTheme: SwitchThemeData(
    trackColor: MaterialStateProperty.all<Color>(black1),
    thumbColor: MaterialStateProperty.all<Color>(white1),
  ),
    inputDecorationTheme: InputDecorationTheme(
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          color: white1,
          width: 3.0,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          color: Colors.grey,
          width: 3.0,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
    ),
  elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
          foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
          overlayColor: MaterialStateProperty.all<Color>(Colors.black26)
      )
  ), colorScheme: ColorScheme.fromSwatch().copyWith(secondary: white1),
);

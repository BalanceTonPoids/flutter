import 'package:flutter/material.dart';


const Color black1 = Color(0xff292929);
const Color white1 = Color(0xffeeeded);
const Color blue = Color(0xff0044D6);
const Color red = Color(0xffCB0B0B);
const Color green = Color(0xff28AB21);
final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: blue,
    floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: blue
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
            padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                EdgeInsets.symmetric(horizontal: 40.0,vertical: 20.0)
            ),
            shape: MaterialStateProperty.all<OutlinedBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0))
            ),
            backgroundColor: MaterialStateProperty.all<Color>(blue)
        )
    ),
    inputDecorationTheme: InputDecorationTheme(
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: blue,
            width: 3.0,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        filled: true,
        fillColor: Colors.grey.withOpacity(0.1)
    )
);

final ThemeData darkTheme = ThemeData(

  brightness: Brightness.dark,
  accentColor: Colors.white,
  switchTheme: SwitchThemeData(
    trackColor: MaterialStateProperty.all<Color>(Colors.black),
    thumbColor: MaterialStateProperty.all<Color>(Colors.white),
  ),
  inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),borderSide: BorderSide.none
      ),
      filled: true,
      fillColor: Colors.grey.withOpacity(0.1)
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
          padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
              EdgeInsets.symmetric(horizontal: 40.0,vertical: 20.0)
          ),
          shape: MaterialStateProperty.all<OutlinedBorder>(
              RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)
              )
          ),
          backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
          foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
          overlayColor: MaterialStateProperty.all<Color>(Colors.black26)
      )
  ),
);

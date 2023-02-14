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
      padding: EdgeInsets.only(top: 20),
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


textTheme: TextTheme(

      bodyText1: TextStyle(
        color: Colors.black,
        fontSize: 16.0,
      ),
      headline1: TextStyle(
        color: Colors.black,
        fontSize: 24.0,
        fontWeight: FontWeight.bold,
      ),
    ),
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
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.grey,
            width: 3.0,
          ),
          borderRadius: BorderRadius.circular(10),
        ),

    )
);

final ThemeData darkTheme = ThemeData(
  primaryColor: blue,
  brightness: Brightness.dark,
  accentColor: white1,
  textTheme: TextTheme(
    bodyText1: TextStyle(
      color: Colors.white,
      fontSize: 16.0,
    ),
    headline1: TextStyle(
      color: Colors.white,
      fontSize: 24.0,
      fontWeight: FontWeight.bold,
    ),
  ),
  switchTheme: SwitchThemeData(
    trackColor: MaterialStateProperty.all<Color>(black1),
    thumbColor: MaterialStateProperty.all<Color>(white1),
  ),
    inputDecorationTheme: InputDecorationTheme(
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: white1,
          width: 3.0,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.grey,
          width: 3.0,
        ),
        borderRadius: BorderRadius.circular(10),
      ),

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

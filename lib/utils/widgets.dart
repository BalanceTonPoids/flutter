import 'dart:ui';
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import '../theme/theme_manager.dart';

double screenWidth = MediaQueryData.fromWindow(window).size.width;
ThemeManager _themeManager = ThemeManager();

AppBar appBar(String title, bool automaticallyImplyLeading, context) {
  return AppBar(
    title: Row(
      children: [
        Expanded(
          child: Text(title),
        ),
        Expanded(
          child: GestureDetector(
            onTap: () => {
              AdaptiveTheme.of(context).toggleThemeMode(),
            },
            child: Image.asset("assets/logo_white.png",
                width: 50, height: 50, alignment: Alignment.centerRight),
          ),
        ),
      ],
    ),
    automaticallyImplyLeading: automaticallyImplyLeading,
    shadowColor: Colors.transparent,
  );
}

GestureDetector buttonCard(
    String title, String subtitle, Color color, bool isAlert, context, onTap) {
  return GestureDetector(
    onTap: () => {
      PersistentNavBarNavigator.pushNewScreen(
        context,
        screen: onTap,
        pageTransitionAnimation: PageTransitionAnimation.cupertino,
      )
    },
    child: Card(
      child: Column(
        children: [
          isAlert
              ? Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(10),
                  decoration: const BoxDecoration(
                    color: Colors.red,
                  ),
                  child: RichText(
                      text: const TextSpan(children: [
                    WidgetSpan(
                      alignment: PlaceholderAlignment.middle,
                      child: Icon(Icons.warning, color: Colors.white),
                    ),
                    TextSpan(
                        text: " Actions requises",
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Roboto',
                          fontSize: 15,
                        )),
                  ])),
                )
              : Container(),
          Container(
            decoration: BoxDecoration(color: color),
            padding: const EdgeInsets.all(10),
            width: double.infinity,
            child: Column(
              children: [
                Text(title,
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: color == Colors.white
                            ? Colors.black
                            : Colors.white)),
                Text(subtitle,
                    style: TextStyle(
                        fontSize: 15,
                        color: color == Colors.white
                            ? Colors.black
                            : Colors.white)),
              ],
            ),
          )
        ],
      ),
    ),
  );
}

GestureDetector squareButton(String title, String filePath, context, screen) {
  return GestureDetector(
    onTap: () => {
      PersistentNavBarNavigator.pushNewScreen(
        context,
        screen: screen,
        pageTransitionAnimation: PageTransitionAnimation.cupertino,
      )
    },
    child: SizedBox(
      width: (screenWidth - 40) / 2,
      child: Card(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Image.asset(
              filePath,
              fit: BoxFit.cover,
              opacity: const AlwaysStoppedAnimation(.5),
            ),
            Text(title,
                style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue)),
          ],
        ),
      ),
    ),
  );
}

Widget button(context, String text, Color backgroundColor, Color textColor,
    Color borderColor, int borderWidth, onPressed) {
  return ElevatedButton(
      onPressed: () => {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => onPressed))
          },
      style: ElevatedButton.styleFrom(
          side: const BorderSide(color: Colors.blue, width: 2),
          fixedSize: const Size(300, 50),
          foregroundColor: textColor,
          backgroundColor: backgroundColor,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15)))),
      child: Text(text));
}

// button for form
Widget buttonForm(context, String text, Color backgroundColor, Color textColor,
    Color borderColor, int borderWidth, onPressed) {
  return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
          side: const BorderSide(color: Colors.blue, width: 2),
          fixedSize: const Size(300, 50),
          foregroundColor: textColor,
          backgroundColor: backgroundColor,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15)))),
      child: Text(text));
}
// end button for form

Container titleSection(
  String title,
  String subtitle,
) {
  return Container(
    width: double.infinity,
    decoration: const BoxDecoration(
      color: Colors.blue,
    ),
    child: Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Text(title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontFamily: 'Roboto',
                fontSize: 25,
                fontWeight: FontWeight.bold,
              )),
          Text(subtitle,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontFamily: 'Roboto',
                fontSize: 15,
                fontWeight: FontWeight.normal,
              ))
        ],
      ),
    ),
  );
}

CustomPaint weightPolygon(Color bgColor, double width, int height) {
  return CustomPaint(
    size: Size(
        width,
        (height * 0.5)
            .toDouble()), //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
    painter: WeightPainter(bgColor),
  );
}

class WeightPainter extends CustomPainter {
  const WeightPainter(this.bgColor) : super();

  final Color bgColor;

  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width * 0.7839500, size.height);
    path_0.lineTo(size.width * 0.2187500, size.height);
    path_0.lineTo(size.width * 0.002500000, 0);
    path_0.lineTo(size.width * 1.002500, 0);
    path_0.lineTo(size.width * 0.7839500, size.height);
    path_0.close();

    Paint paint_0_fill = Paint()..style = PaintingStyle.fill;
    paint_0_fill.color = bgColor;
    canvas.drawPath(path_0, paint_0_fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

Stack weightStack(
    double weight,
    String metric,
    Color bgColor,
    double width,
    int height
    ) {
  return Stack(
    alignment: Alignment.center,
    children: [
      Container(
        child: weightPolygon(bgColor, width, height),
      ),
      Container(
        child: Text("$weight $metric",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: bgColor == Colors.white ? Colors.black : Colors.white,
              fontFamily: 'Roboto',
              fontSize: 40,
              fontWeight: FontWeight.bold,
            )),
      ),
    ],
  );
}

Column loadingSpinner() {
  return Column(
    children: const [
      Padding(
          padding: EdgeInsets.only(top: 20),
          child: SpinKitFadingCircle(
            color: Colors.blue,
            size: 50.0,
          )),
      Text("Ne bougez pas... prise du poids en cours...",
          style: TextStyle(
            color: Colors.blue,
            fontFamily: 'Roboto',
            fontSize: 15,
            fontWeight: FontWeight.normal,
          ),
          textAlign: TextAlign.center)
    ],
  );
}

SizedBox inputForm(
    TextEditingController controller,
    bool autofocus,
    bool obscureText,
    bool enableSuggestions,
    bool autocorrect,
    String label,
    Icon icon,
    ) {
  return SizedBox(
    width: 300,
    height: 60,
    child: TextFormField(
      controller: controller,
      autofocus: autofocus,
      obscureText: obscureText,
      enableSuggestions: enableSuggestions,
      autocorrect: autocorrect,
      decoration: InputDecoration(
        labelText: label,
        suffix: icon,
      ),
    ),
  );
}

Container headerPolygon(
    double double,
    String metric,
    String title,
    String description,
    Color bgColor,
    ) {
  return Container(
    decoration: BoxDecoration(
      color: bgColor,
    ),
    child: Column(
      children: [
        titleSection(title, description),
        weightStack(double, metric, bgColor == Colors.blue ? Colors.white : Colors.blue, 200, 220)
      ],
    ),
  );
}
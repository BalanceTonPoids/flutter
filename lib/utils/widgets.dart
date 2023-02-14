import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

double screenWidth = MediaQueryData.fromWindow(window).size.width;

AppBar appBar(String title) {
  return AppBar(
    title: Row(
      children: [
        Expanded(
          flex: 1,
          child: Text(title),
        ),
        Expanded(
          flex: 1,
          child: Image.asset("assets/logo_white.png", width: 50, height: 50, alignment: Alignment.centerRight),
        ),
      ],
    ),
    automaticallyImplyLeading: false,
    shadowColor: Colors.transparent,
  );
}

GestureDetector buttonCard(
    String title,
    String subtitle,
    Color color,
    bool isAlert,
    onTap
    ) {
  return GestureDetector(
    onTap: onTap,
    child: Card(
      child: Column(
        children: [
          isAlert ? Container(
            width: double.infinity,
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
              color: Colors.red,
            ),
            child: RichText(
              text: const TextSpan(
                children: [
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
                ]
              )
            ),
          ) : Container(),
          Container(
            decoration: BoxDecoration(
                color: color
            ),
            padding: const EdgeInsets.all(10),
            width: double.infinity,
            child: Column(
              children: [
                Text(title, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: color == Colors.white ? Colors.black : Colors.white)),
                Text(subtitle, style: TextStyle(fontSize: 15, color: color == Colors.white ? Colors.black : Colors.white)),
              ],
            ),
          )
        ],
      ),
    ),
  );
}

GestureDetector squareButton(
    String title,
    String filePath,
    onTap
    ) {
  return GestureDetector(
    onTap: onTap,
    child: SizedBox(
      width: (screenWidth - 40) / 2,
      child: Card(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Image.asset(filePath,
              fit: BoxFit.cover,
              opacity: const AlwaysStoppedAnimation(.5),
            ),
            Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blue)),
          ],
        ),
      ),
    ),
  );
}

Widget button(
    context,
    String text,
    Color backgroundColor,
    Color textColor,
    Color borderColor,
    int borderWidth,
    onPressed) {
  return ElevatedButton(
      onPressed: () => {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => onPressed)
        )
      },
      style: ElevatedButton.styleFrom(
          side: const BorderSide(color: Colors.blue, width: 2),
          fixedSize: const Size(300, 50),
          foregroundColor: textColor,
          backgroundColor: backgroundColor,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15))
          )
      ),
      child: Text(text));
}

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

CustomPaint weightPolygon(Color bgColor) {
  return CustomPaint(
    painter: WeightPainter(bgColor),
    child: const SizedBox(
      width: 200,
      height: 200,
    ),
  );
}

class WeightPainter extends CustomPainter {
  const WeightPainter(this.bgColor) : super();

  final Color bgColor;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = bgColor
      ..style = PaintingStyle.fill;

    final path = Path();
    path.addPolygon([
      Offset(0, size.height / 2),
      Offset(size.width, size.height / 2),
      Offset(size.width * 2 / 3, size.height),
      Offset(size.width * 1 / 3, size.height)
    ], true);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

Stack weightStack(
    String weight,
    String metric,
    Color bgColor
    ) {
  return Stack(
    alignment: Alignment.center,
    children: [
      Container(
        child: weightPolygon(bgColor),
      ),
      Container(
        padding: const EdgeInsets.only(top: 90),
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
      Text("Ne bougez pas... prise du poids en cours...", style:
      TextStyle(
        color: Colors.blue,
        fontFamily: 'Roboto',
        fontSize: 15,
        fontWeight: FontWeight.normal,
      ), textAlign: TextAlign.center)
    ],
  );
}
import 'dart:ui';
import 'package:flutter/material.dart';

double screenWidth = MediaQueryData.fromWindow(window).size.width;

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
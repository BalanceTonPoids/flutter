import 'dart:ui';

import 'package:flutter/material.dart';
import '../main.dart';
import '../utils/widgets.dart';
import './auth.dart';

class Welcome extends StatefulWidget {
  const Welcome({Key? key}) : super(key: key);

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: PageView(
        children: [
          Container(
              color: Colors.white,
              child: Column(
                children: [
                  logoSection,
                  titleText,
                  const Padding(
                      padding: EdgeInsets.only(top: 50),
                      child: Text("Bienvenue sur l'application de suivi de poids.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Roboto',
                            fontSize: 15,
                            fontWeight: FontWeight.normal,
                          ))
                  ),
                  const Padding(
                      padding: EdgeInsets.only(top: 200),
                      child: Text("Swipez vers la droite pour continuer.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Roboto',
                            fontSize: 15,
                            fontWeight: FontWeight.w100,
                          ))
                  ),
                ],
              )
          ),
          Container(
            child: Column(
              children: const [
                Padding(
                    padding: EdgeInsets.only(top: 50),
                    child: Text("Connecter ma balance",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Roboto',
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ))
                ),
              ]
            ),
          ),
          Container(
            color: Colors.white,
            child: Center(
              child: Column(
                children: [
                  logoSection,
                  titleText,
                  const Padding(
                      padding: EdgeInsets.only(top: 25,bottom: 50),
                      child: Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: "Connectez-vous à votre compte pour retrouver votre progression ou "
                            ),
                            TextSpan(
                              text: "continuez en tant qu'invité.",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              )
                            )
                          ]
                      ),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Roboto',
                            fontSize: 15,
                            fontWeight: FontWeight.normal,
                          ))
                  ),
                  Padding(
                      padding: const EdgeInsets.only(top: 10,bottom: 10),
                      child: button(context, "Continuez avec un Email", Colors.blue, Colors.white, Colors.blue, 2, const Register())),
                  Padding(
                      padding: const EdgeInsets.only(top: 10,bottom: 10),
                      child: button(context, "Continuez en tant qu'invité", Colors.white, Colors.blue, Colors.blue, 2, const MyHomePage())),
                ]
              ),
            ),
          ),
        ],
      )
    );
  }
}

Widget logoSection = Padding(padding: const EdgeInsets.only(top: 100),
    child: Image.asset('assets/logo_black.png', width: 200, height: 200, fit: BoxFit.cover));

Widget titleText = const Padding(
    padding: EdgeInsets.only(top: 50),
    child: Text("BalanceTonPoids",
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.black,
          fontFamily: 'Roboto',
          fontSize: 30,
          fontWeight: FontWeight.bold,
        ))
);


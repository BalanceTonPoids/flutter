import 'dart:ui';
import 'package:balancetonpoids/theme/theme_constants.dart';
import 'package:flutter/material.dart';
import '../main.dart';
import 'package:balancetonpoids/pages/terms_and_policies.dart';

import 'inscription-connexion.dart';
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

              child: Column(
                children: [
                  LogoSection(),
                  titleText,
                  const Padding(
                      padding: EdgeInsets.only(top: 50),
                      child: Text("Bienvenue sur l'application de suivi de poids.",
                          textAlign: TextAlign.center,
                          style: TextStyle(

                            fontFamily: 'Roboto',
                            fontSize: 15,
                            fontWeight: FontWeight.normal,
                          ))
                  ),
                   Padding(
                    padding: EdgeInsets.only(top: 200),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Swipez vers la droite pour continuer.",
                            textAlign: TextAlign.center,
                            style: TextStyle(

                              fontFamily: 'Roboto',
                              fontSize: 15,
                              fontWeight: FontWeight.w100,
                            )),
                        SizedBox(width: 10),
                        Icon(
                          Icons.swipe_left,
                          size: 40,

                        ),
                      ],
                    ),
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

                          fontFamily: 'Roboto',
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        )
                       )
                ),
              ]
            ),
          ),
          Container(

            child: Center(
              child: Column(
                children: [
                  LogoSection(),
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

                            fontFamily: 'Roboto',
                            fontSize: 15,
                            fontWeight: FontWeight.normal,
                          ))
                  ),
                  Padding(
                      padding: const EdgeInsets.only(top: 10,bottom: 10),
                      child: button(context, "Continuez avec un Email", Colors.blue, Colors.white, Colors.blue, 2,   TermsAndPoliciesPage())),
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

class LogoSection extends StatefulWidget {
  @override
  _LogoSectionState createState() => _LogoSectionState();
}

class _LogoSectionState extends State<LogoSection> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 100),
      child: Image.asset(
        Theme.of(context).brightness == Brightness.light
            ? 'assets/logo-light.png'
            : 'assets/logo-dark.png',
        width: 200,
        height: 200,
        fit: BoxFit.cover,
      ),
    );
  }
}

Widget titleText = const Padding(
    padding: EdgeInsets.only(top: 50),
    child: Text("BalanceTonPoids",
        textAlign: TextAlign.center,
        style: TextStyle(

          fontFamily: 'Roboto',
          fontSize: 30,
          fontWeight: FontWeight.bold,
        ))
);

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
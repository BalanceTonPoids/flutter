import 'package:flutter/material.dart';
import '../main.dart';
import '../utils/widgets.dart';
import 'package:balancetonpoids/pages/terms_and_policies.dart';

class Welcome extends StatefulWidget {
  const Welcome({Key? key}) : super(key: key);

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: PageView(
          children: [
            Column(
              children: [
                const LogoSection(),
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
                  padding: const EdgeInsets.only(top: 200),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
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
            ),
            Column(
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
            Center(
              child: Column(
                  children: [
                    const LogoSection(),
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
                        child: button(context, "Continuez avec un Email", Colors.blue, Colors.white, Colors.blue, 2, const TermsAndPoliciesPage())),
                    Padding(
                        padding: const EdgeInsets.only(top: 10,bottom: 10),
                        child: button(context, "Continuez en tant qu'invité", Colors.white, Colors.blue, Colors.blue, 2, const MainPage())),
                  ]
              ),
            ),
          ],
        )
    );
  }
}

class LogoSection extends StatefulWidget {
  const LogoSection({super.key});

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


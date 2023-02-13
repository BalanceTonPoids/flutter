import 'dart:ui';
import 'package:flutter/material.dart';

import '../utils/widgets.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const Expanded(
              flex: 1,
              child: Text("Bienvenue"),
            ),
            Expanded(
              flex: 1,
              child: Image.asset("assets/logo_white.png", width: 50, height: 50, alignment: Alignment.centerRight),
            ),
          ],
        ),
        automaticallyImplyLeading: false,
        shadowColor: Colors.transparent,
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Colors.blue,
            ),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                  children: const [
                    Text("Mon poids",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Roboto',
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        )),
                    Text("Dernier poids enregistré",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Roboto',
                          fontSize: 15,
                          fontWeight: FontWeight.normal,
                        ))
                  ],
              ),
            ),
          ),
          Container(
            decoration: const BoxDecoration(
              color: Colors.blue,
            ),
            padding: const EdgeInsets.all(20),
            child: buttonCard("Commencer la prise de poids", "Effectuer la première prise de poids", Colors.white, false, null),
          ),
          Container(
            padding: const EdgeInsets.all(20),
            child: buttonCard("Modifier mon profil", "Renseignez ma taille, mes objectifs, etc.", Colors.blue, true, null),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20, bottom: 20, left: 10, right: 10),
            child: Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                squareButton("IMC", "assets/imc.jpg", null),
                squareButton("Evolution", "assets/evolution.jpg", null),
                squareButton("Objectifs", "assets/objectifs.jpg", null),
              ],
            ),
          )
        ]
      ),
    );
  }
}
import 'package:balancetonpoids/pages/modifier_profil.dart';
import 'package:balancetonpoids/pages/profile.dart';
import 'package:balancetonpoids/pages/weight.dart';
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
      appBar: appBar("Bienvenue", false, context),
      body: Column(
        children: [
          titleSection("Mon poids", "Dernier poids enregistré"),
          Container(
            decoration: const BoxDecoration(
              color: Colors.blue,
            ),
            padding: const EdgeInsets.all(20),
            child: buttonCard("Commencer la prise de poids", "Effectuer la première prise de poids", Colors.white, false, context, const Weight()),
          ),
          Container(
            padding: const EdgeInsets.all(20),
            child: buttonCard("Modifier mon profil", "Renseignez ma taille, mes objectifs, etc.", Colors.blue, true, context, const EditProfilePage()),
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
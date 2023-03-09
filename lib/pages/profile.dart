import 'package:balancetonpoids/pages/modifier_profil.dart';
import 'package:flutter/material.dart';
import '../utils/widgets.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar("Mon profil", false, context),
      body: Column(
        children: [
          Container(
            decoration: const BoxDecoration(
              color: Colors.blue,
            ),
            child: Column(
              children: [
                titleSection("Mon poids", "Dernier poids enregistré"),
                weightStack(55.0, 'kg', Colors.white, 200, 220)
              ],
            ),
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
        ],
      ),
    );
  }
}

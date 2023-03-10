import 'package:balancetonpoids/pages/imc.dart';
import 'dart:convert';

import 'package:balancetonpoids/models/scale_data.dart';
import 'package:balancetonpoids/pages/edit_profile.dart';
import 'package:balancetonpoids/pages/profile.dart';
import 'package:balancetonpoids/pages/weight.dart';
import 'package:balancetonpoids/services/api_client.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user.dart';
import '../utils/widgets.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final Future<SharedPreferences> prefs = SharedPreferences.getInstance();
  late Future<bool> user;
  // TODO remove after test
  late Future<double?> weight;
  late Future<List<String>?> scale;

  @override
  void initState() {
    super.initState();
    user = ApiClient(httpClient: http.Client()).getUserInfo();
    // TODO remove after test
    weight = prefs.then((value) => value.getDouble('weight'));
    weight.then((value) => print('weight : $value'));

    scale = prefs.then((value) => value.getStringList('scale'));
    scale.then((value) => print('scale : $value'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar("Bienvenue", false, context),
      body: Column(children: [
        titleSection("Mon poids", "Dernier poids enregistré"),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Weight()),
            );
          },
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.blue,
            ),
            padding: const EdgeInsets.all(20),
            child: buttonCard(
                "Commencer la prise de poids",
                "Effectuer la première prise de poids",
                Colors.white,
                false,
                context,
                const Weight(), false),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(20),
          child: buttonCard(
              "Modifier mon profil",
              "Renseignez ma taille, mes objectifs, etc.",
              Colors.blue,
              true,
              context,
              const EditProfilePage(), false),
        ),
        Padding(
          padding:
              const EdgeInsets.only(top: 20, bottom: 20, left: 10, right: 10),
          child: Wrap(
            spacing: 10,
            runSpacing: 10,
            children: [
              squareButton("IMC", "assets/imc.jpg", context, IMCPage(), false),
              squareButton("Evolution", "assets/evolution.jpg", context, null, false),
              squareButton("Objectifs", "assets/objectifs.jpg", context, null, false),
            ],
          ),
        )
      ]),
    );
  }
}

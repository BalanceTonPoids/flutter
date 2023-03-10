import 'package:balancetonpoids/pages/imc.dart';
import 'package:balancetonpoids/pages/stats.dart';
import 'package:balancetonpoids/pages/weight.dart';
import 'package:balancetonpoids/services/api_client.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../utils/widgets.dart';
import 'edit_profile.dart';

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
          padding: const EdgeInsets.only(
              top: 60, bottom: 10, left: 20, right: 20),

          child: buttonCard(
              "Modifier mon profil",
              "Renseignez ma taille, mes objectifs, etc.",
              Colors.blue,
              true,
              context,
              const EditProfilePage(), false),
        ),
        Container(
          padding: const EdgeInsets.only(
              top: 0, bottom: 20, left: 20, right: 20),

          child: buttonCard(
              "Stats",
              "Renseignez les Statistiques ",
              Colors.blue,
              false,
              context,
              const Stats(), false),
        ),
        Container(
          padding: const EdgeInsets.only(
              top: 0, bottom: 10, left: 24, right: 24),
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) =>  IMCPage()),
              );
            },
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(double.infinity, 60),
              shape: const RoundedRectangleBorder(

                side: BorderSide(
                  color: Colors.blue,
                  width: 2,
                ),
              ),
              primary: Colors.white,
              onPrimary: Colors.blue,
              elevation: 3,
            ),
            child: const Text(
              "IMC",
              style: TextStyle(
                color: Colors.blue,
                fontSize: 18,
              ),
            ),
          ),
        ),
      ]),
    );
  }
}

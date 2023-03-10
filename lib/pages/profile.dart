import 'package:balancetonpoids/pages/imc.dart';
import 'package:balancetonpoids/pages/modifier_profil.dart';
import 'package:balancetonpoids/pages/stats.dart';
import 'package:balancetonpoids/pages/welcome.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../utils/widgets.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final Future<SharedPreferences> prefs = SharedPreferences.getInstance();
  late Future<double?> weight;
  late Future<String?> metric;

  @override
  void initState() {
    super.initState();
    weight = prefs.then((value) => value.getDouble('weight') ?? 0.0);
    metric = prefs.then((value) => value.getString('metric') ?? 'kg');
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Future.wait([weight, metric]),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            double showWeight = snapshot.data![0] as double;
            String showMetric = snapshot.data![1] as String;
            return Scaffold(
              appBar: appBar('Mon profil', false, context),
              body: Column(
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      color: Colors.blue,
                    ),
                    child: Column(
                      children: [
                        titleSection('Mon poids', 'Dernier poids enregistré'),
                        weightStack(
                            showWeight, showMetric, Colors.white, 200, 220)
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Column(
                      // Taille, Sexe, Préférences, dernière mise à jour des données
                      children: [
                        resumeDiv(const Icon(Icons.height, color: Colors.blue), "1m80"),
                        resumeDiv(const Icon(Icons.wc, color: Colors.blue), "Homme"),
                        resumeDiv(const Icon(Icons.favorite, color: Colors.blue), "60kg"),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        buttonCard("Modifier mon profil", "Renseignez ma taille, mes données, etc.", Colors.blue, true, context, const EditProfilePage(), true),
                        buttonCard("Changer ma balance", "Changer de balance connectée", Colors.blue, false, context, Welcome(), true)
                      ],
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          button(context, "Se déconnecter", Colors.white, Colors.blue, Colors.blue, 2, null, false),
                          Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: RichText(
                                  textAlign: TextAlign.center,
                                  text: const TextSpan(
                                      children: [
                                        WidgetSpan(child: Icon(Icons.update, color: Colors.blue)),
                                        TextSpan(text: " Dernière mise à jour : 12/12/2020", style: TextStyle(fontSize: 14, color: Colors.black))
                                      ]
                                  )
                              )
                          )
                        ],
                      )
                  )
                ],
              ),
            );
          } else {
            return const CircularProgressIndicator();
          }
        });
  }
}

RichText resumeDiv(
    Icon icon,
    String text,
) {
  return RichText(
    textAlign: TextAlign.center,
    text: TextSpan(
        children: [
          WidgetSpan(child: icon),
          TextSpan(text: " ${text}", style: const TextStyle(fontSize: 20, color: Colors.black))
        ]
    )
  );
}
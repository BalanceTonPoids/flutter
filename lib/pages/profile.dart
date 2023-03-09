import 'package:balancetonpoids/pages/imc.dart';
import 'package:balancetonpoids/pages/modifier_profil.dart';
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
                  Container(
                    padding: const EdgeInsets.all(20),
                    child: buttonCard(
                        'Modifier mon profil',
                        'Renseignez ma taille, mes objectifs, etc.',
                        Colors.blue,
                        true,
                        context,
                        const EditProfilePage()),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 20, bottom: 20, left: 10, right: 10),
                    child: Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: [
                        squareButton(
                            'IMC', 'assets/imc.jpg', context, IMCPage()),
                        squareButton(
                            'Evolution', 'assets/evolution.jpg', context, null),
                        squareButton(
                            'Objectifs', 'assets/objectifs.jpg', context, null),
                      ],
                    ),
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

import 'package:balancetonpoids/pages/connecter_ma_balance.dart';
import 'package:balancetonpoids/pages/edit_profile.dart';
import 'package:balancetonpoids/pages/welcome.dart';
import 'package:balancetonpoids/services/empty_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../utils/widgets.dart';
import 'package:intl/intl.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

getToken() async {
  final storage = const FlutterSecureStorage();
  String? token = await storage.read(key: 'token');
  print(token);
  return token;
}

class _ProfileState extends State<Profile> {
  final Future<SharedPreferences> prefs = SharedPreferences.getInstance();
  late Future<double?> weight;
  late Future<String?> metric;
  late Future<int?> height;
  late Future<String?> gender;
  late Future<String?> date;

  @override
  void initState() {
    super.initState();
    weight = prefs.then((value) => value.getDouble('weight') ?? 0.0);
    metric = prefs.then((value) => value.getString('metric') ?? 'kg');
    height = prefs.then((value) => value.getInt('height') ?? 0);
    gender = prefs.then((value) => value.getString('gender') ?? 'M');
    date = prefs.then((value) => value.getString('date') ?? '');
  }

  String returnGender(String gender) {
    switch (gender) {
      case 'M':
        return 'Homme';
      case 'F':
        return 'Femme';
      default:
        return 'Autre';
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Future.wait([weight, metric, height, gender, date]),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            double showWeight = snapshot.data![0] as double;
            String showMetric = snapshot.data![1] as String;
            int showHeight = snapshot.data![2] as int;
            String showGender = snapshot.data![3] as String;
            String rawDate = snapshot.data![4] as String;
            DateTime date =
                rawDate != '' ? DateTime.parse(rawDate) : DateTime.now();
            String showDate = DateFormat('dd/MM/yyyy à HH:mm').format(date);

            return Scaffold(
              appBar: appBar('Mon profil', false, context),
              body: ListView(
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
                        resumeDiv(const Icon(Icons.height, color: Colors.blue),
                            '$showHeight cm'),
                        resumeDiv(const Icon(Icons.wc, color: Colors.blue),
                            returnGender(showGender)),
                        resumeDiv(
                            const Icon(Icons.favorite, color: Colors.blue),
                            '$showWeight $showMetric'),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        if (getToken() != null)
                        buttonCard(
                            'Modifier mon profil',
                            'Renseignez ma taille, mes données, etc.',
                            Colors.blue,
                            true,
                            context,
                            const EditProfilePage(),
                            true),
                        buttonCard(
                            'Changer ma balance',
                            'Changer de balance connectée',
                            Colors.blue,
                            false,
                            context,
                            const connecterMaBalance(),
                            true)
                      ],
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          buttonForm(
                              context,
                              'Se déconnecter',
                              Colors.white,
                              Colors.blue,
                              Colors.blue,
                              2,
                              () => EmptyStorage().logout(context)),
                          Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: RichText(
                                  textAlign: TextAlign.center,
                                  text: TextSpan(children: [
                                    const WidgetSpan(
                                        child: Icon(Icons.update,
                                            color: Colors.blue)),
                                    TextSpan(
                                        text:
                                            'Dernière mise à jour : $showDate',
                                        style: const TextStyle(
                                            fontSize: 14, color: Colors.black))
                                  ])))
                        ],
                      ))
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
      text: TextSpan(children: [
        WidgetSpan(child: icon),
        TextSpan(
            text: text,
            style: const TextStyle(fontSize: 20, color: Colors.black))
      ]));
}

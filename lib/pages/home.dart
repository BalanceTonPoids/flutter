import 'package:balancetonpoids/pages/imc.dart';
import 'package:balancetonpoids/pages/edit_profile.dart';

import 'package:balancetonpoids/pages/weight.dart';
import 'package:balancetonpoids/services/api_client.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../utils/widgets.dart';
import 'package:url_launcher/url_launcher.dart';

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
      appBar: appBar('Bienvenue', false, context),
      body: Column(children: [
        titleSection('Mon poids', 'Dernier poids enregistré'),
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
                'Commencer la prise de poids',
                'Effectuer la première prise de poids',
                Colors.white,
                false,
                context,
                const Weight(),
                false),
          ),
        ),
        Container(
          padding:
              const EdgeInsets.only(top: 30, bottom: 10, left: 20, right: 20),
          child: buttonCard(
              'Modifier mon profil',
              'Renseignez ma taille, mes objectifs, etc.',
              Colors.blue,
              false,
              context,
              const EditProfilePage(),
              false),
        ),
        Container(
          padding:
              const EdgeInsets.only(top: 0, bottom: 20, left: 20, right: 20),
          child: buttonCard('Contact', 'Besoin d\'aide! contactez nous',
              Colors.blue, false, context, const ContactPage(), false),
        ),
        Container(
          padding:
              const EdgeInsets.only(top: 0, bottom: 10, left: 24, right: 24),
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => IMCPage()),
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
              'IMC',
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

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Accueil'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ContactPage()),
            );
          },
          child: const Text('Contact'),
        ),
      ),
    );
  }
}

class ContactPage extends StatelessWidget {
  const ContactPage({Key? key}) : super(key: key);

  static const String _phoneNumber =
      '0233445566'; // Numéro de téléphone à appeler
  static const String _email = 'info@btp.fr'; // Adresse email de contact

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contact'),
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Nous contacter',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.blueGrey,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Nous sommes toujours heureux d\'entendre de vous. Si vous avez des questions ou des commentaires, n\'hésitez pas à nous contacter. Vous pouvez nous appeler ou nous envoyer un e-mail à tout moment.',
              textAlign: TextAlign.justify,
              style: TextStyle(
                fontSize: 18,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 32),
            ElevatedButton.icon(
              onPressed: () {
                launch(
                    'tel:$_phoneNumber'); // Ouvre l'application téléphone pour appeler le numéro
              },
              icon: const Icon(Icons.phone),
              label: const Text(
                'Appeler',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              style: ElevatedButton.styleFrom(
                primary: Colors.green,
                onPrimary: Colors.white,
                padding: const EdgeInsets.symmetric(
                  vertical: 12,
                  horizontal: 16,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () {
                launch(
                    'mailto:$_email'); // Ouvre l'application email avec l'adresse email de contact pré-remplie
              },
              icon: const Icon(Icons.mail),
              label: const Text(
                'E-mail',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              style: ElevatedButton.styleFrom(
                primary: Colors.orange,
                onPrimary: Colors.white,
                padding: const EdgeInsets.symmetric(
                  vertical: 12,
                  horizontal: 16,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

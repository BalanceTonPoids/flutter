import 'package:balancetonpoids/utils/widgets.dart';
import 'package:flutter/material.dart';
import 'auth.dart';

class TermsAndPoliciesPage extends StatefulWidget {
  const TermsAndPoliciesPage({super.key});

  @override
  _TermsAndPoliciesPageState createState() => _TermsAndPoliciesPageState();
}

class _TermsAndPoliciesPageState extends State<TermsAndPoliciesPage> {
  bool _acceptTerms = false;

  void _handleNextButtonPress() {
    if (_acceptTerms) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const SignupPage()),
      );
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Erreur'),
            content: const Text(
                'Vous devez accepter les termes et politiques pour poursuivre l\'inscription.'),
            actions: <Widget>[
              ElevatedButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar('Conditions', false, context),
      body: Container(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Termes et conditions générales d\'utilisation',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24.0),
            ),
            const Text(
                'En utilisant notre application, vous acceptez les conditions suivantes. Veuillez les lire attentivement avant de continuer.Notre application collecte certaines informations de base, telles que votre nom et votre adresse e-mail, uniquement à des fins internes pour améliorer votre expérience utilisateur. Nous ne partagerons jamais vos informations personnelles avec des tiers sans votre consentement explicite.Nous nous efforçons de maintenir la disponibilité de notre application en tout temps, mais nous ne pouvons pas garantir une disponibilité ininterrompue. Nous ne serons pas tenus responsables des dommages indirects ou consécutifs découlant de l\'utilisation de notre application. En utilisant notre application, vous acceptez d\'être lié par les présentes conditions et de les respecter sans réserve.',
                style: TextStyle(fontSize: 16.0),
                textAlign: TextAlign.justify),
            CheckboxListTile(
              value: _acceptTerms,
              onChanged: (value) {
                setState(() {
                  _acceptTerms = value!;
                });
              },
              title: const Text(
                  'J\'accepte les termes et conditions générales d\'utilisation',
                  style:
                      TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
            ),
            ElevatedButton(
              onPressed: _handleNextButtonPress,
              child: const Text('Suivant'),
            ),
          ],
        ),
      ),
    );
  }
}

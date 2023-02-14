import 'package:flutter/material.dart';
import 'inscription-connexion.dart';

class TermsAndPoliciesPage extends StatefulWidget {
  @override
  _TermsAndPoliciesPageState createState() => _TermsAndPoliciesPageState();
}

class _TermsAndPoliciesPageState extends State<TermsAndPoliciesPage> {
  bool _acceptTerms = false;

  void _handleNextButtonPress() {
    if (_acceptTerms) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) =>  SignUp1()),
      );
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Erreur"),
            content: Text("Vous devez accepter les termes et politiques pour poursuivre l'inscription."),
            actions: <Widget>[
              ElevatedButton(
                child: Text("OK"),
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
      appBar: AppBar(
        title: Text('Termes et politiques'),
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
          Text(
          "Termes et politiques",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24.0),
        ),
        SizedBox(height: 20.0),
        Text(
            "En utilisant notre application, vous acceptez les conditions suivantes. Veuillez les lire attentivement avant de continuer.Notre application collecte certaines informations de base, telles que votre nom et votre adresse e-mail, uniquement à des fins internes pour améliorer votre expérience utilisateur. Nous ne partagerons jamais vos informations personnelles avec des tiers sans votre consentement explicite.Nous nous efforçons de maintenir la disponibilité de notre application en tout temps, mais nous ne pouvons pas garantir une disponibilité ininterrompue. Nous ne serons pas tenus responsables des dommages indirects ou consécutifs découlant de l'utilisation de notre application.En utilisant notre application, vous acceptez d'être lié par les présentes conditions et de les respecter sans réserve.",
        style: TextStyle(fontSize: 16.0),textAlign: TextAlign.justify

      ),
      SizedBox(height: 20.0),
      CheckboxListTile(
        value: _acceptTerms,
        onChanged: (value) {
          setState(() {
            _acceptTerms = value!;
          });
        },
        title: Text("J'accepte les termes et politiques"),
      ),
      SizedBox(height: 20.0),
      ElevatedButton(
        child: Text("Suivant"),
        onPressed: _handleNextButtonPress,
      ),
      ],
    ),
    ),

    );
  }
}
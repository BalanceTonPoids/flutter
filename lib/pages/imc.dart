import 'package:flutter/material.dart';

import '../utils/widgets.dart';

class IMCPage extends StatefulWidget {
  @override
  _IMCPageState createState() => _IMCPageState();
}

class _IMCPageState extends State<IMCPage> {
  double _height = 160.0;
  double _weight = 60.0;
  double _imc = 0.0;
  String _result = "";

  void calculateIMC() {
    double heightInMeters = _height / 100;
    _imc = _weight / (heightInMeters * heightInMeters);

    if (_imc < 18.5) {
      _result = "Poids insuffisant";
    } else if (_imc < 25) {
      _result = "Poids normal";
    } else if (_imc < 30) {
      _result = "Surpoids";
    } else {
      _result = "Obésité";
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar('IMC', true, context),
      body: ListView(
        children: [
          Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 407.3,
                  height: 222,
                  decoration: const BoxDecoration(
                    color: Colors.blue,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            "Calculez votre Indice de Masse Corporelle",
                            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.white),
                            textAlign: TextAlign.center,
                          )
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Column(
                              children: [
                                const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    "Taille (cm):",
                                    style: TextStyle(fontSize: 18.0, color: Colors.white),
                                  ),
                                ),
                                SizedBox(
                                  width: 130.0,
                                  child: TextField(
                                    keyboardType: TextInputType.number,
                                    textAlign: TextAlign.center,
                                    decoration: const InputDecoration(
                                      hintText: "cm",
                                      fillColor: Colors.white,
                                      filled: true,
                                    ),
                                    onChanged: (value) {
                                      _height = double.tryParse(value) ?? _height;
                                    },
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    "Poids (kg):",
                                    style: TextStyle(fontSize: 18.0, color: Colors.white),
                                  ),
                                ),
                                SizedBox(
                                  width: 130.0,
                                  child: TextField(
                                    keyboardType: TextInputType.number,
                                    textAlign: TextAlign.center,
                                    decoration: const InputDecoration(
                                      hintText: "kg",
                                      fillColor: Colors.white,
                                      filled: true,
                                    ),
                                    onChanged: (value) {
                                      _weight = double.tryParse(value) ?? _weight;
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: calculateIMC,
                    child: const Text("Calculer"),
                  ),
                ),
                Text(
                  "Votre IMC est : ${_imc.toStringAsFixed(2)}",
                  style: const TextStyle(fontSize: 18.0),
                ),
                Text(
                  _result,
                  style: TextStyle(
                    color: _imc < 18.5 ? Colors.grey :
                    _imc < 25 ? Colors.green :
                    _imc < 30 ? Colors.orange : Colors.red,
                    fontSize: 30,fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(20),
                  child: buttonCard("Besoin de conseils ?", "Retrouvez divers conseils d’experts", Colors.blue, false, context, const ConseilsPage(), true),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class ConseilsPage extends StatelessWidget {
  const ConseilsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Consensual d'experts"),
      ),
      body: ListView(
        children: [
          Container(
            color: Colors.grey[100],
            child: ListTile(
              title: const Text("Poids insuffisant"),
              trailing: const Icon(Icons.arrow_forward),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ConseilsPoidsInsuffisant()),
                );
              },
            ),
          ),
          Container(
            color: Colors.green[100],
            child: ListTile(
              title: Text("Poids normal", style: TextStyle(color: Colors.green[900])),
              trailing: const Icon(Icons.arrow_forward),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ConseilsPoidsNormal()),
                );
              },
            ),
          ),
          Container(
            color: Colors.orange[100],
            child: ListTile(
              title: Text("Surpoids", style: TextStyle(color: Colors.orange[900])),
              trailing: const Icon(Icons.arrow_forward),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ConseilsSurpoids()),
                );
              },
            ),
          ),
          Container(
            color: Colors.red[100],
            child: ListTile(
              title: Text("Obésité", style: TextStyle(color: Colors.red[900])),
              trailing: const Icon(Icons.arrow_forward),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ConseilsObesite()),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class ConseilsPoidsInsuffisant extends StatelessWidget {
  const ConseilsPoidsInsuffisant({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Conseils pour le Poids Insuffisant',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.grey[800],
      ),
      body: Container(
        color: Colors.grey[200],
        padding: const EdgeInsets.all(20),
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: const [
            Card(
              child: ListTile(
                title: Text(
                  'Mangez des aliments riches en calories',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
                subtitle: Text(
                  'Les aliments riches en calories peuvent vous aider à prendre du poids, mais assurez-vous qu\'ils sont sains et nutritifs.',
                  style: TextStyle(
                    fontSize: 14.0,
                  ),
                ),
              ),
            ),
            Card(
              child: ListTile(
                title: Text(
                  'Faites de l\'exercice régulièrement',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
                subtitle: Text(
                  'L\'exercice peut vous aider à prendre du poids en augmentant votre appétit et en construisant des muscles.',
                  style: TextStyle(
                    fontSize: 14.0,
                  ),
                ),
              ),
            ),
            Card(
              child: ListTile(
                title: Text(
                  'Consultez un professionnel de la santé',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
                subtitle: Text(
                  'Si vous êtes inquiet de votre poids insuffisant, consultez un médecin ou un nutritionniste pour obtenir des conseils.',
                  style: TextStyle(
                    fontSize: 14.0,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
class ConseilsPoidsNormal extends StatelessWidget {
  const ConseilsPoidsNormal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Conseils pour un Poids Normal',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.green[700],
      ),
      body: Container(
        color: Colors.green[200],
        padding: const EdgeInsets.all(20),
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: const [
            Card(
              elevation: 4.0,
              child: ListTile(
                title: Text(
                  'Mangez des aliments sains et variés',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
                subtitle: Text(
                  'Mangez une variété d\'aliments sains pour maintenir un poids sain.',
                  style: TextStyle(
                    fontSize: 14.0,
                  ),
                ),
              ),
            ),
            Card(
              elevation: 4.0,
              child: ListTile(
                title: Text(
                  'Faites de l\'exercice régulièrement',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
                subtitle: Text(
                  'L\'exercice régulier aide à maintenir un poids santé en brûlant des calories et en augmentant le métabolisme.',
                  style: TextStyle(
                    fontSize: 14.0,
                  ),
                ),
              ),
            ),
            Card(
              elevation: 4.0,
              child: ListTile(
                title: Text(
                  'Surveillez votre apport calorique',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
                subtitle: Text(
                  'Mangez suffisamment de calories pour maintenir votre poids, mais évitez de manger trop pour éviter la prise de poids.',
                  style: TextStyle(
                    fontSize: 14.0,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
class ConseilsSurpoids extends StatelessWidget {
  const ConseilsSurpoids({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: const Text('Conseils Surpoids'),
      ),
        body: Container(
          color: Colors.orange[200],
          padding: const EdgeInsets.all(20),
          child: ListView(
            padding: const EdgeInsets.all(16.0),
            children: const [
              Card(
                child: ListTile(
                  title: Text('Réduisez les portions'),
                  subtitle: Text('Mangez des portions plus petites pour aider à contrôler votre apport calorique.'),
                ),
              ),
              Card(
                child: ListTile(
                  title: Text('Mangez plus de légumes et de fruits'),
                  subtitle: Text('Les légumes et les fruits peuvent vous aider à vous sentir rassasié sans ajouter de calories supplémentaires.'),
                ),
              ),
              Card(
                child: ListTile(
                  title: Text('Faites de l\'exercice régulièrement'),
                  subtitle: Text('L\'exercice peut vous aider à brûler des calories et à perdre du poids.'),
                ),
              ),
              Card(
                child: ListTile(
                  title: Text('Limitez les aliments riches en matières grasses et en sucre'),
                  subtitle: Text('Les aliments riches en matières grasses et en sucre peuvent ajouter des calories sans vous rassasier.'),
                ),
              ),
              Card(
                child: ListTile(
                  title: Text('Consultez un professionnel de la santé'),
                  subtitle: Text('Si vous êtes inquiet de votre poids ou avez besoin d\'aide pour perdre du poids, consultez un médecin ou un nutritionniste pour obtenir des conseils.'),
                ),
              ),
            ],
          ),
        )


    );
  }
}
class ConseilsObesite extends StatelessWidget {
  const ConseilsObesite({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Conseils Obésité'),
        backgroundColor: Colors.red, // changement de la couleur de l'app bar en rouge
      ),
      body: Container(
        color: Colors.red[200],
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: const [
            Card(
              child: ListTile(
                title: Text('Mangez des aliments sains et nutritifs'),
                subtitle: Text(
                    'Choisissez des aliments riches en nutriments et faibles en calories, tels que des légumes, des fruits, des grains entiers et des protéines maigres.'),
              ),
            ),
            Card(
              child: ListTile(
                title: Text('Limitez votre consommation de sucre et de graisses saturées'),
                subtitle: Text(
                    'Limitez la quantité de sucre, de graisses saturées et de gras trans dans votre alimentation, car ils peuvent contribuer à l\'obésité.'),
              ),
            ),
            Card(
              child: ListTile(
                title: Text('Buvez beaucoup d\'eau'),
                subtitle: Text(
                    'Boire suffisamment d\'eau peut vous aider à vous sentir rassasié et à éviter de manger trop de calories.'),
              ),
            ),
            Card(
              child: ListTile(
                title: Text('Faites de l\'exercice régulièrement'),
                subtitle: Text(
                    'L\'exercice peut vous aider à perdre du poids et à maintenir un poids santé. Essayez de faire au moins 30 minutes d\'exercice modéré par jour.'),
              ),
            ),
            Card(
              child: ListTile(
                title: Text('Obtenez suffisamment de sommeil'),
                subtitle: Text(
                    'Le manque de sommeil peut perturber les hormones qui contrôlent la faim et la satiété, ce qui peut contribuer à l\'obésité.'),
              ),
            ),
            Card(
              child: ListTile(
                title: Text('Consultez un professionnel de la santé'),
                subtitle: Text(
                    'Si vous êtes préoccupé par votre poids, parlez à votre médecin ou à un diététicien pour obtenir des conseils et un plan de perte de poids sain.'),
              ),
            ),
          ],
        ),
      )
    );
  }
}




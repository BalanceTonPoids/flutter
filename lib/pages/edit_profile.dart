import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import '../utils/widgets.dart';

class EditProfilePage extends StatelessWidget {
  const EditProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: appBar('Modifier mon Profil', true, context),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Image.asset(
                'assets/Settings.png',height: 150,width: 150,
              ),
              _buildPersonalInfoForm(),
              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                child: ElevatedButton(
                  onPressed: () {
                    // Enregistrer les modifications
                  },
                  style: ElevatedButton.styleFrom(
                    side: const BorderSide(color: Colors.blue, width: 2),
                    fixedSize: const Size(300, 50),
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.blue,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                  ),
                  child: const Text('Enregistrer'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                child: ElevatedButton(
                  onPressed: () {
                    PersistentNavBarNavigator.pushNewScreen(context, screen: const EditProfileDetailsPage());
                  },
                  style: ElevatedButton.styleFrom(
                    side: const BorderSide(color: Colors.blue, width: 2),
                    fixedSize: const Size(300, 50),
                    foregroundColor: Colors.blue,
                    backgroundColor: Colors.white,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                  ),
                  child: const Text('Données personnelles'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPersonalInfoForm() {
    final _heightController = TextEditingController();
    final _weightFavoriteController = TextEditingController();
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: DropdownButtonFormField(
              key: const Key('metric'),
              isExpanded: true,
              value: 'kg',
              decoration: const InputDecoration(
                labelText: 'Unité de mesure',
                labelStyle: TextStyle(color: Colors.grey),
              ),
              items: const [
                DropdownMenuItem(
                  value: 'kg',
                  child: Text('Kg'),
                ),
                DropdownMenuItem(
                  value: 'lbs',
                  child: Text('Lbs'),
                )
              ],
              onChanged: (value) {
                // Enregistrer les modifications
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: DropdownButtonFormField(
              isExpanded: true,
              value: 'H',
              decoration: const InputDecoration(
                labelText: 'Sexe',
                labelStyle: TextStyle(color: Colors.grey),
              ),
              items: const [
                DropdownMenuItem(
                  value: 'H',
                  child: Text('Homme'),
                ),
                DropdownMenuItem(
                  value: 'F',
                  child: Text('Femme'),
                ),
                DropdownMenuItem(
                  value: 'O',
                  child: Text('Autre'),
                ),
              ],
              onChanged: (value) {
                // Enregistrer les modifications
              },
            ),
          ),
          inputForm(
              _heightController,
              false,
              false,
              true,
              true,
              'Poids souhaité',
              const Icon(
                Icons.monitor_weight,
                color: Colors.grey,
              )
          ),
          inputForm(
              _weightFavoriteController,
              false,
              false,
              true,
              true,
              'Ma taille',
              const Icon(
                Icons.height,
                color: Colors.grey,
              )
          ),
        ],
      ),
    );
  }
}

//page modifier mes Données Personnelles
class EditProfileDetailsPage extends StatefulWidget {
  const EditProfileDetailsPage({super.key});
  @override
  _EditProfileDetailsPageState createState() => _EditProfileDetailsPageState();
}
class _EditProfileDetailsPageState extends State<EditProfileDetailsPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  // late Future<User> _futureUser;
  //
  // Future<User> fetch_user() async {
  //   var response = await http.get(Uri.parse('http://balancetonpoids.alexisbriet.fr/v1/user'));
  //
  //   if (response.statusCode == 200) {
  //     // If the server did return a 200 OK response,
  //     // then parse the JSON.
  //     return User.fromJson(jsonDecode(response.body));
  //   } else {
  //     // If the server did not return a 200 OK response,
  //     // then throw an exception.
  //     throw Exception('Failed to load album');
  //   }
  // }
  String? _validateEmail( value) {
    if (value.isEmpty) {
      return 'Veuillez saisir une adresse email.';
    }
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,}$');
    if (!emailRegex.hasMatch(value)) {
      return 'Veuillez saisir une adresse email valide.';
    }
    return null;
  }

  String? _validatePassword( value) {
    final passwordRegex = RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
    if (!passwordRegex.hasMatch(value)) {
      return 'Le mot de passe doit contenir au moins une lettre majuscule, une lettre minuscule, un chiffre et un caractère spécial.';
    }
    if (value.isEmpty) {
      return 'Veuillez saisir un mot de passe.';
    }
    if (value.length < 8) {
      return 'Le mot de passe doit contenir au moins 8 caractères.';
    }
    return null;
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Enregistrer les modifications
      final email = _emailController.text;
      final password = _passwordController.text;
      print('Enregistrer les modifications avec email=$email, password=$password');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Les modifications ont été enregistrées avec succès!'),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    key: _scaffoldKey;
    return Scaffold(
      appBar: appBar('Données Personnelles', true, context),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Center(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Image.asset(
                    'assets/donnesPerso.png',height: 200,width: 150,
                  ),
                 
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: inputForm(
                      _emailController,
                      true,
                      false,
                      true,
                      true,
                      'Entrez votre e-mail',
                      const Icon(
                        Icons.alternate_email,
                        color: Colors.grey,
                      ),
                    )
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: inputForm(
                        _passwordController,
                        false,
                        true,
                        false,
                        false,
                        'Entrez votre mot de passe',
                        const Icon(
                          Icons.lock,
                          color: Colors.grey,
                        )
                    )
                  ),
                  ElevatedButton(
                    onPressed: _submitForm,
                    style: ElevatedButton.styleFrom(
                      side: const BorderSide(color: Colors.blue, width: 2),
                      fixedSize: const Size(300, 50),
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.blue,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                    ),
                    child: const Text('Enregistrer'),
                  )
                ]
            ),
          ),
        ),
      ),
    );
  }
}
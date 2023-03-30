import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/api_client.dart';
import '../utils/widgets.dart';
import 'package:http/http.dart' as http;

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late String gender = 'M';
  late int height = 0;
  late String metric = 'kg';
  late int age = 0;
  final _heightController = TextEditingController();
  final _ageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((prefs) {
      setState(() {
        gender = prefs.getString('gender') ?? 'M';
        height = prefs.getInt('height') ?? 0;
        metric = prefs.getString('metric') ?? 'kg';
        age = prefs.getInt('age') ?? 0;
        _heightController.text = height.toString();
        _ageController.text = age.toString();
      });
    });
  }

  Future<void> updateInfo() async {
    final g = gender;
    final h = int.parse(_heightController.text);
    final m = metric;
    final a = int.parse(_ageController.text);
    final returnMessage = await ApiClient(httpClient: http.Client())
        .updateUser('', '', g, m, a, h);
    if (!returnMessage) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Une erreur est survenue!'),
          backgroundColor: Colors.red,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Les modifications ont été enregistrées avec succès!'),
          backgroundColor: Colors.green,
        ),
      );
      SharedPreferences.getInstance().then((prefs) {
        setState(() {
          gender = prefs.getString('gender') ?? 'M';
          height = prefs.getInt('height') ?? 0;
          metric = prefs.getString('metric') ?? 'kg';
          age = prefs.getInt('age') ?? 0;
          _heightController.text = height.toString();
          _ageController.text = age.toString();
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: appBar('Modifier mon profil', true, context),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Image.asset(
                'assets/Settings.png',
                height: 150,
                width: 150,
              ),
              _buildPersonalInfoForm(),
              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                child: ElevatedButton(
                  onPressed: () {
                    updateInfo();
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
                    PersistentNavBarNavigator.pushNewScreen(context,
                        screen: const EditProfileDetailsPage());
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
    // final _weightFavoriteController = TextEditingController();

    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: DropdownButtonFormField(
              key: const Key('metric'),
              isExpanded: true,
              value: metric,
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
                metric = value.toString();
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: DropdownButtonFormField(
              isExpanded: true,
              value: gender,
              decoration: const InputDecoration(
                labelText: 'Sexe',
                labelStyle: TextStyle(color: Colors.grey),
              ),
              items: const [
                DropdownMenuItem(
                  value: 'M',
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
                gender = value.toString();
              },
            ),
          ),
          inputForm(
              _heightController,
              false,
              false,
              true,
              true,
              'Ma taille',
              const Icon(
                Icons.height,
                color: Colors.grey,
              )),
          inputForm(
              _ageController,
              false,
              false,
              true,
              true,
              'Age',
              const Icon(
                Icons.assignment_ind_rounded,
                color: Colors.grey,
              )),
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
  final _confirmPasswordController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final Future<SharedPreferences> prefs = SharedPreferences.getInstance();
  late Future<String?> email;

  @override
  void initState() {
    super.initState();
    email = prefs.then((value) => value.getString('email') ?? '');
    email.then((value) => _emailController.text = value ?? '');
  }

  Future<void> _submitForm() async {
    // Enregistrer les modifications
    final email = _emailController.text;
    final password = _passwordController.text;
    final confirmPassword = _confirmPasswordController.text;
    final returnMessage = await ApiClient(httpClient: http.Client())
        .updateSecurityUser(email, password, confirmPassword);
    if (returnMessage.keys.contains('erreur')) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(returnMessage.values.toString()),
          backgroundColor: Colors.red,
        ),
      );
    } else if (returnMessage.keys.contains('success')) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Les modifications ont été enregistrées avec succès!'),
          backgroundColor: Colors.green,
        ),
      );
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    _scaffoldKey;
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
                    'assets/donnesPerso.png',
                    height: 200,
                    width: 150,
                  ),
                  Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: inputForm(
                        _emailController,
                        true,
                        false,
                        true,
                        true,
                        'Adresse mail',
                        const Icon(
                          Icons.alternate_email,
                          color: Colors.grey,
                        ),
                      )),
                  Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: inputForm(
                          _passwordController,
                          false,
                          true,
                          false,
                          false,
                          'Mot de passe',
                          const Icon(
                            Icons.lock,
                            color: Colors.grey,
                          ))),
                  Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: inputForm(
                          _confirmPasswordController,
                          false,
                          true,
                          false,
                          false,
                          'Confirmer votre mot de passe',
                          const Icon(
                            Icons.lock,
                            color: Colors.grey,
                          ))),
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
                ]),
          ),
        ),
      ),
    );
  }
}

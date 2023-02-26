import 'package:flutter/material.dart';

import '../utils/widgets.dart';

class EditProfilePage extends StatelessWidget {
  const EditProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar('Modifier mon Profil', false, context),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,

          children: <Widget>[
            Image.asset(
            'assets/Settings.png',height: 150,width: 150,
              ),




            const SizedBox(height: 10.0),
            _buildPersonalInfoForm(),

            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                // Enregistrer les modifications
              },
              style: ButtonStyle(
                padding: MaterialStateProperty.all(const EdgeInsets.all(20)),
                textStyle: MaterialStateProperty.all(const TextStyle(fontSize: 20)),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
              ),
              child:  const Text('Enregistrer'),
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>  EditProfileDetailsPage()),
                );
              },
              style: ButtonStyle(
                padding: MaterialStateProperty.all(const EdgeInsets.all(20)),backgroundColor: const MaterialStatePropertyAll(Colors.green),
                textStyle: MaterialStateProperty.all(const TextStyle(fontSize: 20)),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
              ),
              child: const Text(
                'Modifier mes Données Personnelles',),


            ),

          ],
        ),
      ),
    );
  }

  Widget _buildPersonalInfoForm() {
    return Container(
      padding: const EdgeInsets.all(16.0),

      child: Column(
        children: <Widget>[

          const SizedBox(height: 16.0),
          Row(
            children: <Widget>[
              Expanded(
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Sexe',

                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.blue,width: 3),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.blue,width: 3),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Ma taille',
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.blue,width: 3),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.blue,width: 3),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: <Widget>[
              Expanded(
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Préférence du poids',
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.blue,width: 3),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.blue,width: 3),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Poids souhaité',
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.blue,width: 3),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.blue,width: 3),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
              ),
            ],
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

    const Text(
    'Données personnelles',
    textAlign: TextAlign.center,
    style: TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 18.0,
    color: Colors.white,
    ),
    ),
    const SizedBox(height: 16.0),
    TextFormField(
    controller: _emailController,
    style: const TextStyle(color: Colors.black),
    decoration: InputDecoration(
    labelText: 'Email',
    fillColor: Colors.white,
    filled: true,
    enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(8.0),
    borderSide: const BorderSide(color: Colors.blue,width: 3),
    ),
    focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(8.0),
    borderSide: const BorderSide(color: Colors.blue,width: 3),
    ),
    ),
    validator: _validateEmail,
    ),
    const SizedBox(height: 12),
    TextFormField(
    controller: _passwordController,
    style: const TextStyle(color: Colors.black),
    decoration: InputDecoration(
    labelText: 'Mot de passe',
    fillColor: Colors.white,
    filled: true,
    enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(8.0),
    borderSide: const BorderSide(color: Colors.blue,width: 3),
    ),
    focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(8.0),
    borderSide: const BorderSide(color: Colors.blue, width: 3),
    ),
    ),
    obscureText: true,
    validator: _validatePassword,),
      const SizedBox(height: 16.0),
      ElevatedButton(
        onPressed: _submitForm,
        style: ButtonStyle(
          padding: MaterialStateProperty.all(const EdgeInsets.all(20)),
          textStyle: MaterialStateProperty.all(const TextStyle(fontSize: 20)),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
          ),
        ),
        child: const Text('Enregistrer'),
      ),
]
    ),
    ),
    ),
        ),
    );
  }
}
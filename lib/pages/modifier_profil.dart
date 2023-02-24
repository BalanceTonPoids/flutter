import 'package:flutter/material.dart';

import '../utils/widgets.dart';

class EditProfilePage extends StatelessWidget {
  const EditProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar('Modifier mon Profil', false, context),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,

          children: <Widget>[
            Image.asset(
            'assets/Settings.png',height: 150,width: 150,
              ),




            SizedBox(height: 10.0),
            _buildPersonalInfoForm(),
            SizedBox(height: 40.0),
        ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => EditProfileDetailsPage()),
            );
          },
          style: ButtonStyle(
            padding: MaterialStateProperty.all(EdgeInsets.all(20)),backgroundColor: MaterialStatePropertyAll(Colors.green),
            textStyle: MaterialStateProperty.all(TextStyle(fontSize: 20)),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
            ),
          ),
          child: const Text(
            'Modifier mes Données Personnelles',),


        ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                // Enregistrer les modifications
              },
              child: Text('Enregistrer'),
              style: ButtonStyle(
                padding: MaterialStateProperty.all(EdgeInsets.all(20)),
                textStyle: MaterialStateProperty.all(TextStyle(fontSize: 20)),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
              ),
            )

          ],
        ),
      ),
    );
  }

  Widget _buildPersonalInfoForm() {
    return Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Column(
        children: <Widget>[

          SizedBox(height: 16.0),
          Row(
            children: <Widget>[
              Expanded(
                child: TextFormField(style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    labelText: 'Sexe',

                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue,width: 3),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue,width: 3),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: TextFormField(
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    labelText: 'Ma taille',
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue,width: 3),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue,width: 3),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Row(
            children: <Widget>[
              Expanded(
                child: TextFormField(
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    labelText: 'Préférence du poids',
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue,width: 3),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue,width: 3),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: TextFormField(
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    labelText: 'Poids souhaité',
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue,width: 3),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue,width: 3),
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


class EditProfileDetailsPage extends StatelessWidget {
  const EditProfileDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar('Données Personnelles', true, context),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Form(
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Image.asset(
                  'assets/donnesPerso.png',height: 200,width: 150,
                ),


                Text(
                  'Données personnelles',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    labelText: 'Email',
                    fillColor: Colors.white,
                    filled: true,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide(color: Colors.blue,width: 3),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide(color: Colors.blue,width: 3),
                    ),
                  ),
                ),
                SizedBox(height: 12),
                TextFormField(
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    labelText: 'Mot de passe',
                    fillColor: Colors.white,
                    filled: true,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide(color: Colors.blue,width: 3),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide(color: Colors.blue, width: 3),
                    ),
                  ),
                  obscureText: true,
                ),
                SizedBox(height: 20.0),

                ElevatedButton(
              onPressed: () {
                // Enregistrer les modifications
              },
              child: Text('Enregistrer'),
              style: ButtonStyle(
                padding: MaterialStateProperty.all(EdgeInsets.all(20)),
                textStyle: MaterialStateProperty.all(TextStyle(fontSize: 20)),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
              ),
            ),
              ],
            ),
          ),

        ),
      ),
    );
  }
}

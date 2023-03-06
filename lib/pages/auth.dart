import 'package:balancetonpoids/main.dart';
import 'package:balancetonpoids/utils/widgets.dart';
import 'package:flutter/material.dart';

import 'package:balancetonpoids/services/api_client.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController _emailController = TextEditingController();
    final TextEditingController _passwordController = TextEditingController();
    final TextEditingController _confirmPasswordController =
        TextEditingController();

    return SafeArea(
      child: Scaffold(
        appBar: appBar('Inscription', true, context),
        body: SingleChildScrollView(
          child: Stack(
            children: <Widget>[
              Column(
                children: <Widget>[
                  const Padding(padding: EdgeInsets.all(10)),
                  const SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    width: 100,
                    child: Image.asset(
                      'assets/sign-up.png',
                      fit: BoxFit.fill,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Column(
                      children: <Widget>[
                        inputForm(
                            _emailController,
                            'Entrez votre e-mail',
                            const Icon(
                              Icons.alternate_email,
                              color: Colors.grey,
                            )),
                        inputForm(
                            _passwordController,
                            'Entrez votre mot de passe',
                            const Icon(
                              Icons.lock,
                              color: Colors.grey,
                            )),
                        inputForm(
                            _confirmPasswordController,
                            'Confirmez votre mot de passe',
                            const Icon(
                              Icons.lock,
                              color: Colors.grey,
                            )),
                        Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: buttonForm(
                              context,
                              'Créer mon compte',
                              Colors.blue,
                              Colors.white,
                              Colors.white,
                              0,
                              () => {
                                ApiClient(httpClient: http.Client())
                                    .registerUser(
                                        _emailController.text,
                                        _passwordController.text,
                                        _confirmPasswordController.text)
                                    .then((value) => {
                                          if (value.keys.contains('success'))
                                            {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        const MainPage()),
                                              )
                                            }
                                          else
                                            {
                                              showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return AlertDialog(
                                                    title: const Text('Erreur'),
                                                    content: const Text(
                                                        'Une erreur est survenue'),
                                                    actions: <Widget>[
                                                      ElevatedButton(
                                                        child: const Text(
                                                            'Fermer'),
                                                        onPressed: () {
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                      ),
                                                    ],
                                                  );
                                                },
                                              )
                                            }
                                        })
                              },
                            )),
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: button(
                              context,
                              'Je possède déjà un compte',
                              Colors.white,
                              Colors.blue,
                              Colors.blue,
                              0,
                              const LoginPage()),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});
  @override
  Widget build(BuildContext context) {
    final TextEditingController _emailController = TextEditingController();
    final TextEditingController _passwordController = TextEditingController();

    return SafeArea(
      child: Scaffold(
        appBar: appBar('Connexion', true, context),
        body: SingleChildScrollView(
          child: Stack(
            children: <Widget>[
              Column(
                children: <Widget>[
                  const Padding(padding: EdgeInsets.all(10)),
                  SizedBox(
                    width: 100,
                    child: Image.asset(
                      'assets/log-in.png',
                      fit: BoxFit.fill,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Column(
                      children: <Widget>[
                        inputForm(
                            _emailController,
                            'Entrez un e-mail',
                            const Icon(
                              Icons.alternate_email,
                              color: Colors.grey,
                            )),
                        inputForm(
                            _passwordController,
                            'Entrez un mot de passe',
                            const Icon(
                              Icons.lock,
                              color: Colors.grey,
                            )),
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: buttonForm(
                              context,
                              'Se connecter',
                              Colors.blue,
                              Colors.white,
                              Colors.white,
                              0,
                              () => {
                                    ApiClient(httpClient: http.Client())
                                        .loginUser(_emailController.text,
                                            _passwordController.text)
                                        .then((value) => {
                                              if (value)
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            const MainPage()),
                                                  )
                                                }
                                              else
                                                {
                                                  showDialog(
                                                    context: context,
                                                    builder:
                                                        (BuildContext context) {
                                                      return AlertDialog(
                                                        title: const Text(
                                                            'Erreur'),
                                                        content: const Text(
                                                            'Une erreur est survenue'),
                                                        actions: <Widget>[
                                                          ElevatedButton(
                                                            child: const Text(
                                                                'Fermer'),
                                                            onPressed: () {
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                            },
                                                          ),
                                                        ],
                                                      );
                                                    },
                                                  )
                                                }
                                            })
                                  }),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: button(
                              context,
                              'Je n\'ai pas de compte',
                              Colors.white,
                              Colors.blue,
                              Colors.blue,
                              0,
                              const SignupPage()),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

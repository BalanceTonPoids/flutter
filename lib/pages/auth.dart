import 'package:balancetonpoids/main.dart';
import 'package:balancetonpoids/pages/terms_and_policies.dart';
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
          child: Column(
            children: <Widget>[
              const Padding(padding: EdgeInsets.all(10)),
              const SizedBox(
                height: 30,
              ),
              SizedBox(
                width: 150,
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
                      true,
                      false,
                      true,
                      true,
                      'Entrez votre e-mail',
                      const Icon(
                        Icons.alternate_email,
                        color: Colors.grey,
                      ),
                    ),
                    inputForm(
                        _passwordController,
                        false,
                        true,
                        false,
                        false,
                        'Entrez votre mot de passe',
                        const Icon(
                          Icons.lock,
                          color: Colors.grey,
                        )),
                    inputForm(
                        _confirmPasswordController,
                        false,
                        true,
                        false,
                        false,
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
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                title: const Text('Erreur'),
                                                content: Text(
                                                    value.values.toString()),
                                                actions: <Widget>[
                                                  ElevatedButton(
                                                    child: const Text('Fermer'),
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
                          const LoginPage(),
                          false),
                    ),
                  ],
                ),
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
          child: Column(
            children: <Widget>[
              const Padding(padding: EdgeInsets.all(10)),
              SizedBox(
                width: 150,
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
                        true,
                        false,
                        true,
                        true,
                        'Entrez un e-mail',
                        const Icon(
                          Icons.alternate_email,
                          color: Colors.grey,
                        )),
                    inputForm(
                        _passwordController,
                        false,
                        true,
                        false,
                        false,
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
                          const TermsAndPoliciesPage(),
                          false),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: button(
                          context,
                          'J\'ai oublié mon mot de passe',
                          Colors.white,
                          Colors.blue,
                          Colors.blue,
                          0,
                          const MdpOubliePage(),
                          false),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//mdp oublie
class MdpOubliePage extends StatefulWidget {
  const MdpOubliePage({super.key});

  @override
  _MdpOubliePageState createState() => _MdpOubliePageState();
}

class _MdpOubliePageState extends State<MdpOubliePage> {
  final TextEditingController _emailController = TextEditingController();

  void _sendResetLink() async {
    final response = await ApiClient(httpClient: http.Client())
        .resetPwd(_emailController.text);
    if (response.keys.contains('error')) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(response.values.toString()),
          backgroundColor: Colors.red,
        ),
      );
    }
    if (response.keys.contains('message')) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
              'Un e-mail contenant un lien de réinitialisation a été envoyé à l\'adresse e-mail spécifiée.'),
          backgroundColor: Colors.green,
        ),
      );
      await Future.delayed(const Duration(seconds: 2));
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: appBar('Mot de passe oublié', true, context),
        body: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    width: 100,
                    child: Image.asset(
                      'assets/mdp-oublie.png',
                      fit: BoxFit.fill,
                    ),
                  ),
                  const SizedBox(height: 40),
                  const Text(
                    'Entrez votre adresse e-mail pour réinitialiser votre mot de passe :',
                    style: TextStyle(fontSize: 18),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      labelText: 'Adresse e-mail',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      _sendResetLink();
                    },
                    child: const Text('Envoyer un lien de réinitialisation'),
                  ),
                  const SizedBox(height: 20),
                  const SizedBox(
                    height: 250,
                  ),
                  const Text(
                    'Contactez nous par mail pour tout renseignement : info@btp.fr',
                    style: TextStyle(fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

//réinitialiser le mdp
class ResetPasswordPage extends StatelessWidget {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  bool _isPasswordValid() {
    String password = _passwordController.text.trim();
    return password.isNotEmpty && password.length >= 8;
  }

  bool _doPasswordsMatch() {
    String password = _passwordController.text.trim();
    String confirmPassword = _confirmPasswordController.text.trim();
    return password == confirmPassword;
  }

  void _resetPassword(BuildContext context) {
    if (_isPasswordValid() && _doPasswordsMatch()) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              "Félicitation! votre mot de passe réinitialisé",
              style: TextStyle(
                color: Colors.green,
              ),
            ),
            content: Text("Vous allez être rédiger vers la page de connexion"),
            actions: <Widget>[
              TextButton(
                child: Text("OK"),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                  );
                },
              ),
            ],
          );
        },
      );
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              "Erreur de réinitialisation du mot de passe",
              style: TextStyle(
                color: Colors.red,
              ),
            ),
            content: Text(
                "Veuillez entrer un mot de passe valide et assurez-vous que les deux champs de mot de passe correspondent."),
            actions: <Widget>[
              TextButton(
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
      appBar: appBar("Réinitialiser le mot de passe", true, context),
      body: SingleChildScrollView(
          child: Center(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 100,
                height: 100,
                child: Image.asset(
                  'assets/R-mdp.png',
                  fit: BoxFit.fill,
                ),
              ),
              const SizedBox(height: 40),
              inputForm(
                _passwordController,
                false,
                true,
                false,
                false,
                "Nouveau mot de passe",
                const Icon(
                  Icons.lock,
                  color: Colors.grey,
                ),
              ),
              inputForm(
                _confirmPasswordController,
                false,
                true,
                false,
                false,
                "Confirmez le nouveau mot de passe",
                const Icon(
                  Icons.lock,
                  color: Colors.grey,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: ElevatedButton(
                  onPressed: () {
                    _resetPassword(context);
                  },
                  child: Text("Réinitialiser le mot de passe"),
                ),
              ),
              const SizedBox(
                height: 250,
              ),
              const Text(
                "Contactez nous par mail pour tout renseignement : info@btp.fr",
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      )),
    );
  }
}

import 'package:balancetonpoids/main.dart';
import 'package:balancetonpoids/utils/widgets.dart';
import 'package:flutter/material.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController _emailController = TextEditingController();
    final TextEditingController _passwordController = TextEditingController();
    final TextEditingController _confirmPasswordController = TextEditingController();

    return SafeArea(
      child: Scaffold(
        appBar: appBar("Inscription", true, context),
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
                        inputForm(_emailController, "Entrez votre e-mail", const Icon(
                          Icons.alternate_email,
                          color: Colors.grey,
                        )),
                        inputForm(_passwordController, "Entrez votre mot de passe", const Icon(
                          Icons.lock,
                          color: Colors.grey,
                        )),
                        inputForm(_confirmPasswordController, "Confirmez votre mot de passe", const Icon(
                          Icons.lock,
                          color: Colors.grey,
                        )),
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: button(context, "Créer mon compte", Colors.blue, Colors.white, Colors.white, 0, const MainPage()),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: button(context, "Je possède déjà un compte", Colors.white, Colors.blue, Colors.blue, 0, const LoginPage()),
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
        appBar: appBar("Connexion", true, context),
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
                        inputForm(_emailController, "Entrez un e-mail", const Icon(
                          Icons.alternate_email,
                          color: Colors.grey,
                        )),
                        inputForm(_passwordController, "Entrez un mot de passe", const Icon(
                          Icons.lock,
                          color: Colors.grey,
                        )),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => MdpOubliePage()),
                            );
                          },
                          child: Text("Mot de passe oublié ?"),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: button(context, "Se connecter", Colors.blue, Colors.white, Colors.white, 0, const MainPage()),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: button(context, "Je n'ai pas de compte", Colors.white, Colors.blue, Colors.blue, 0, const SignupPage()),
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


//mdp oublie
class MdpOubliePage extends StatefulWidget {
  const MdpOubliePage({super.key});

  @override
  _MdpOubliePageState createState() => _MdpOubliePageState();
}

class _MdpOubliePageState extends State<MdpOubliePage> {
  final TextEditingController _emailController = TextEditingController();
  bool _emailSent = false;

  void _sendResetLink() {
    // Code pour envoyer l'e-mail de réinitialisation de mot de passe
    // Cette fonction doit renvoyer true si l'e-mail a été envoyé avec succès ou false si l'adresse e-mail est introuvable.
    bool emailSent = true; // j'ai mis true pour afficher le message mais remplace ceci par ton propre code mon gaaars.

    setState(() {
      _emailSent = emailSent;
    });
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: appBar("Mot de passe oublié", true, context),
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
                  const SizedBox(height: 20),
                  const Text(
                    "Entrez votre adresse e-mail pour réinitialiser votre mot de passe :",
                    style: TextStyle(fontSize: 18),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      labelText: "Adresse e-mail",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      _sendResetLink();
                    },
                    child: const Text("Envoyer un lien de réinitialisation"),
                  ),
                  const SizedBox(height: 20),
                  if (_emailSent)
                    const Text(
                      "Un e-mail contenant un lien de réinitialisation a été envoyé à l'adresse e-mail spécifiée.",
                      style: TextStyle(color: Colors.green),
                      textAlign: TextAlign.center,
                    ),
                  if (_emailController.text.isNotEmpty && !_emailSent)
                    const Text(
                      "L'adresse e-mail spécifiée est introuvable. Veuillez vérifier votre adresse e-mail et réessayer.",
                      style: TextStyle(color: Colors.red),
                      textAlign: TextAlign.center,
                    ),
                  const SizedBox(height: 250,),
                  const Text(
                    "Contactez nous par mail pour tout renseignement : info@btp.fr",
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
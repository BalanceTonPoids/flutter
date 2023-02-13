import 'package:balancetonpoids/theme/theme_constants.dart';
import 'package:flutter/material.dart';



class SignUp1 extends StatelessWidget {
  const SignUp1({super.key});




  @override
  Widget build(BuildContext context) {
    return SafeArea(

      child: Scaffold(
        body: SingleChildScrollView(
          child: Stack(
            children: <Widget>[
              Container(
                child: Column(
                  children: <Widget>[

                    const Padding(padding: EdgeInsets.all(30)),
                    const SizedBox(
                      height: 30,
                    ),
                    Container(

                      width: 200,
                      child: Image.asset(
                        'assets/sign-up.png',
                        fit: BoxFit.fill,
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: Column(
                        children: <Widget>[

                          Container(
                            width: 300,
                            height: 60,
                            child: const TextField(

                              autofocus: true,
                              decoration: InputDecoration(

                                labelText: 'Enter Your Email',
                                suffix: Icon(
                                  Icons.alternate_email,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                            width: 300,
                            height: 60,
                            child: const TextField(
                              autofocus: true,
                              obscureText: true,
                              decoration: InputDecoration(

                                labelText: 'Enter Your Password',
                                suffix: Icon(
                                  Icons.lock,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                            width: 300,
                            height: 60,
                            child: const TextField(
                              autofocus: true,
                              obscureText: true,
                              decoration: InputDecoration(

                                labelText: 'Confirm Your Password',
                                suffix: Icon(
                                  Icons.lock,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: Row(
                              children: const <Widget>[
                                Checkbox(
                                  value: false,
                                  onChanged: null,
                                ),
                                Text('I accept the policy and terms'),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20,),
                          TextButton(
                            onPressed: () {},
                            child: Container(
                              width: 200,
                              height: 35,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                gradient: const LinearGradient(
                                    begin: Alignment.topRight,
                                    end: Alignment.bottomLeft,
                                    colors: [
                                      Color(0xff5165ea),
                                      blue,
                                    ]),
                              ),
                              child: const Center(
                                child: Text(
                                  'Sign Up',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10,),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const ConnexionPage()),
                              );
                            },
                            child: Container(
                              width: 200,
                              height: 35,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  border: Border.all(color: blue)
                              ),
                              child: const Center(
                                child: Text(
                                  'Déja inscrit ? Sign in',
                                  style: TextStyle(color: white1),
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 20,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const <Widget>[
                               Image(
                                image: AssetImage('assets/icons8_Twitter_Circled_48px.png'),
                                width: 35,
                                height: 35,
                              ),
                               Image(
                                image: AssetImage('assets/google.png'),
                                width: 35,
                                height: 35,
                              ),
                               Image(
                                image: AssetImage('assets/icons8_LinkedIn_Circled_48px.png'),
                                width: 35,
                                height: 35,
                              ),
                            ],
                          ),
                        ],
                      ),
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





class ConnexionPage extends StatelessWidget {
  const ConnexionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(

      child: Scaffold(
        body: SingleChildScrollView(
          child: Stack(
            children: <Widget>[
              Container(
                child: Column(
                  children: <Widget>[
                    const Padding(padding: EdgeInsets.all(30)),
                    const SizedBox(
                      height: 30,
                    ),
                    Container(

                      width: 200,
                      child: Image.asset(
                        'assets/log-in.png',
                        fit: BoxFit.fill,
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: Column(
                        children: <Widget>[

                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                            width: 300,
                            height: 60,
                            child: const TextField(
                              autofocus: true,
                              decoration: InputDecoration(

                                labelText: 'Enter Your Email',
                                suffix: Icon(
                                  Icons.alternate_email,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                            width: 300,
                            height: 60,
                            child: const TextField(
                              autofocus: true,
                              obscureText: true,
                              decoration: InputDecoration(

                                labelText: 'Enter Your Password',
                                suffix: Icon(
                                  Icons.lock,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 20,),
                          TextButton(
                            onPressed: () {},
                            child: Container(
                              width: 200,
                              height: 35,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                gradient: const LinearGradient(
                                    begin: Alignment.topRight,
                                    end: Alignment.bottomLeft,
                                    colors: [
                                      Color(0xff5165ea),
                                      Color(0xff2827e9)
                                    ]),
                              ),
                              child: const Center(
                                child: Text(
                                  'Log in',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10,),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => SignUp1()),
                              );
                            },
                            child: Container(
                              width: 200,
                              height: 35,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  border: Border.all(color: const Color(0xff2827e9))
                              ),
                              child: const Center(
                                child: Text(
                                  'Pas de compte ? S\'inscrire',
                                  style: TextStyle(color: Color(0xff2827e9)),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const <Widget>[
                              Image(
                                image: AssetImage('assets/icons8_Twitter_Circled_48px.png'),
                                width: 35,
                                height: 35,
                              ),
                              Image(
                                image: AssetImage('assets/google.png'),
                                width: 35,
                                height: 35,
                              ),
                              Image(
                                image: AssetImage('assets/icons8_LinkedIn_Circled_48px.png'),
                                width: 35,
                                height: 35,
                              ),
                            ],
                          ),
                        ],
                      ),
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





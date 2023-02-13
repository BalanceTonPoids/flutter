import 'package:flutter/material.dart';
import './inscriptionPage.dart';
class ConnexionPage extends StatelessWidget {
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
                    Padding(padding: EdgeInsets.all(30)),
                    Container(

                      width: 200,
                      child: Image.asset(
                        'assets/log-in.png',
                        fit: BoxFit.fill,
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: Column(
                        children: <Widget>[

                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            width: 300,
                            height: 60,
                            child: TextField(
                              autofocus: true,
                              decoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0xff2827e9),
                                    width: 3.0,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.grey,
                                    width: 3.0,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                labelText: 'Enter Your Email',
                                suffix: Icon(
                                  Icons.alternate_email,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            width: 300,
                            height: 60,
                            child: TextField(
                              autofocus: true,
                              obscureText: true,
                              decoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0xff2827e9),
                                    width: 3.0,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.grey,
                                    width: 3.0,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                labelText: 'Enter Your Password',
                                suffix: Icon(
                                  Icons.lock,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                          ),

                          SizedBox(height: 20,),
                          TextButton(
                            onPressed: () {},
                            child: Container(
                              width: 200,
                              height: 35,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                gradient: LinearGradient(
                                    begin: Alignment.topRight,
                                    end: Alignment.bottomLeft,
                                    colors: [
                                      Color(0xff5165ea),
                                      Color(0xff2827e9)
                                    ]),
                              ),
                              child: Center(
                                child: Text(
                                  'Log in',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 10,),
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
                                  border: Border.all(color: Color(0xff2827e9))
                              ),
                              child: Center(
                                child: Text(
                                  'Pas de compte ? S\'inscrire',
                                  style: TextStyle(color: Color(0xff2827e9)),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 20,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
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
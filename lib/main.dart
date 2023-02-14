import 'package:flutter/material.dart';
import 'package:flutter_floating_bottom_bar/flutter_floating_bottom_bar.dart';
import 'package:balancetonpoids/theme/theme_constants.dart';
import 'package:balancetonpoids/pages/terms_and_policies.dart';
import './theme/theme_manager.dart';
import './utils/helper_widgets.dart';
import 'pages/inscription-connexion.dart';

import './pages/welcome.dart';



void main() => runApp(MyApp());

ThemeManager _themeManager = ThemeManager();
class MyApp extends StatelessWidget {

  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BalanceTonPoids',
      theme: darkTheme,
      home:  Welcome(),
    );
  }
}


class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});



  @override
  _MyHomePageState createState() => _MyHomePageState();
}




class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();


  @override
  void dispose() {
    _themeManager.removeListener(themeListener);
    super.dispose();
  }

  @override
  void initState() {
    _themeManager.addListener(themeListener);
    super.initState();
  }

  themeListener(){
    if(mounted){
      setState(() {

      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(length: 3,
        child: Scaffold(
          appBar: AppBar(
            title: Text('BalanceTonPoids'),
          ),
          body: Center(
            child: BottomBar(
                child: const TabBar(
                  tabs: [
                    Tab(icon: Icon(Icons.query_stats, color: Colors.white)),
                    Tab(icon: Icon(Icons.monitor_weight, color: Colors.white)),
                    Tab(icon: Icon(Icons.supervised_user_circle, color: Colors.white)),
                  ],
                  controller: null,
                ),
                body: (context, controller) =>
                    TabBarView(
                        controller: null,
                        children: [
                          Container(
                            color: Colors.red,
                          ),
                          Container(
                            color: Colors.green,
                          ),
                          Container(
                            color: Colors.yellow,
                          ),
                        ])
            ),
          ),
        ));

  }
}

class MyHomeScreen extends StatefulWidget {
  const MyHomeScreen({Key? key}) : super(key: key);

  @override
  _MyHomeScreenState createState() => _MyHomeScreenState();
}

class _MyHomeScreenState extends State<MyHomeScreen> {
  @override
  Widget build(BuildContext context) {
    TextTheme _textTheme = Theme.of(context).textTheme;
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(

    );
  }
}


import 'package:balancetonpoids/pages/profile.dart';
import 'package:balancetonpoids/pages/weight.dart';
import 'package:flutter/material.dart';
import 'package:flutter_floating_bottom_bar/flutter_floating_bottom_bar.dart';
import './pages/welcome.dart';
import 'pages/home.dart';

import './theme/theme_constants.dart';
import './theme/theme_manager.dart';
import './utils/helper_widgets.dart';
import './inscriptionPage.dart';


void main() => runApp(MyApp());

ThemeManager _themeManager = ThemeManager();
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: lightTheme,
      home: SignUp1(),
    );
  }
}
class MyApp1 extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp1> {

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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: _themeManager.themeMode,
      home: MyHomeScreen(),
    );
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
      appBar: AppBar(
        title: Text('Flutter Floating Bottom Bar'),
        actions: [
          IconButton(
            icon: Icon(isDark ? Icons.light_mode : Icons.dark_mode),
            onPressed: (){
              _themeManager.toggleTheme(true);
            },
          )
        ],
      ),
      body: Center(
        child: BottomBar(
            child: const TabBar(
              tabs: [
                Tab(icon: Icon(Icons.query_stats, color: Colors.white)),
                Tab(icon: Icon(Icons.monitor_weight, color: Colors.white)),
                Tab(icon: Icon(Icons.supervised_user_circle, color: Colors.white)),
                Tab(icon: Icon(Icons.stacked_bar_chart, color: Colors.white)),
              ],
              controller: null,
            ),
            body: (context, controller) =>
                TabBarView(
                    controller: null,
                    children: [
                      const Home(),
                      const Weight(),
                      const Profile(),
                      Container(
                        color: Colors.orange,
                      )
                    ])
        ),
      ),
    );
  }
}


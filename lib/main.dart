import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:balancetonpoids/pages/profile.dart';
import 'package:balancetonpoids/pages/weight.dart';
import 'package:flutter/material.dart';
import 'package:flutter_floating_bottom_bar/flutter_floating_bottom_bar.dart';
import './pages/welcome.dart';
import 'pages/home.dart';
import './theme/theme_manager.dart';

void main() => runApp(const MyApp());

ThemeManager _themeManager = ThemeManager();
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

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
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return AdaptiveTheme(
      light: ThemeData(),
      dark: ThemeData.dark(),
      initial: AdaptiveThemeMode.system,
      builder: (theme, darkTheme) => MaterialApp(
        title: 'BalanceTonPoids',
        theme: theme,
        darkTheme: darkTheme,
        themeMode: ThemeMode.system,
        home: const Welcome(),
      ),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(length: 4,
    child: Scaffold(
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
    ));
  }
}
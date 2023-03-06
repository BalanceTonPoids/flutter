import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:balancetonpoids/pages/profile.dart';
import 'package:balancetonpoids/pages/weight.dart';
import 'package:flutter/material.dart';
import './pages/welcome.dart';
import 'pages/home.dart';
import './theme/theme_manager.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:balancetonpoids/pages/modifier_profil.dart';
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
        home: const Home(),
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
    return PersistentTabView(context,
        backgroundColor: Theme.of(context).brightness == Brightness.dark ? Colors.black : Colors.white,
        items: [
          PersistentBottomNavBarItem(
            icon: const Icon(Icons.home),
            title: ("Accueil"),
            activeColorPrimary: Colors.blue,
            inactiveColorPrimary: Theme.of(context).brightness == Brightness.dark ? Colors.grey : Colors.black,
          ),
          PersistentBottomNavBarItem(
            icon: const Icon(Icons.monitor_weight),
            title: ("Poids"),
            activeColorPrimary: Colors.blue,
            inactiveColorPrimary: Theme.of(context).brightness == Brightness.dark ? Colors.grey : Colors.black,
          ),
          PersistentBottomNavBarItem(
            icon: const Icon(Icons.person),
            title: ("Profile"),
            activeColorPrimary: Colors.blue,
            inactiveColorPrimary: Theme.of(context).brightness == Brightness.dark ? Colors.grey : Colors.black,
          ),
          PersistentBottomNavBarItem(
            icon: const Icon(Icons.query_stats),
            title: ("Statistiques"),
            activeColorPrimary: Colors.blue,
            inactiveColorPrimary: Theme.of(context).brightness == Brightness.dark ? Colors.grey : Colors.black,
          ),
        ],
        screens: const [
          Home(),
          Weight(),
          Profile(),
          Center(
            child: Text("Statistiques"),
          )
        ],
    );
  }
}
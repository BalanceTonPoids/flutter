import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:balancetonpoids/pages/profile.dart';
import 'package:balancetonpoids/pages/stats.dart';
import 'package:balancetonpoids/pages/weight.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
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
  final storage = const FlutterSecureStorage();
  late Future<String?> token;

  @override
  void dispose() {
    _themeManager.removeListener(themeListener);
    super.dispose();
  }

  @override
  void initState() {
    _themeManager.addListener(themeListener);
    super.initState();
    token = storage.read(key: 'token');
  }

  themeListener() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
      future: token,
      builder: (context, snapshot) {
        return AdaptiveTheme(
          light: ThemeData(),
          dark: ThemeData.dark(),
          initial: AdaptiveThemeMode.system,
          builder: (theme, darkTheme) => MaterialApp(
            title: 'BalanceTonPoids',
            theme: theme,
            darkTheme: darkTheme,
            themeMode: ThemeMode.system,
            home: snapshot.data != null ? const MainPage() : const Welcome(),
          ),
        );
      },
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late PersistentTabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = PersistentTabController();
  }

  List<Widget> _buildScreens() {
    return [
      Home(),
      Weight(),
      Profile(),
      Stats()
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Icon(Icons.home),
        title: ("Accueil"),
        activeColorPrimary: Colors.blue,
        inactiveColorPrimary: Colors.black12,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.monitor_weight),
        title: ("Poids"),
        activeColorPrimary: Colors.blue,
        inactiveColorPrimary: Colors.black12,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.person),
        title: ("Profil"),
        activeColorPrimary: Colors.blue,
        inactiveColorPrimary: Colors.black12,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.query_stats),
        title: ("Statistiques"),
        activeColorPrimary: Colors.blue,
        inactiveColorPrimary: Colors.black12,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: _controller,
      backgroundColor: Theme.of(context).brightness == Brightness.dark
          ? Colors.black
          : Colors.white,
      items: _navBarsItems(),
      screens: _buildScreens(),
      stateManagement: true,
      onItemSelected: (index) {
        setState(() {
          _controller.index = index;
        });
      },
    );
  }
}

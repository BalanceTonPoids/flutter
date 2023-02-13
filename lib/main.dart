import 'package:flutter/material.dart';
import 'package:flutter_floating_bottom_bar/flutter_floating_bottom_bar.dart';
import './pages/welcome.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BalanceTonPoids',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Welcome(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(length: 3,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('BalanceTonPoids'),
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
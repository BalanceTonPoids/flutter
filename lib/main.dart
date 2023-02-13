import 'package:flutter/material.dart';
import 'package:flutter_floating_bottom_bar/flutter_floating_bottom_bar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(length: 3,
        child: Scaffold(
          appBar: AppBar(
            title: Text(widget.title),
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

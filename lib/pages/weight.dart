import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../utils/widgets.dart';

class Weight extends StatefulWidget {
  const Weight({Key? key}) : super(key: key);

  @override
  State<Weight> createState() => _WeightState();
}

class _WeightState extends State<Weight> {
  final Future<SharedPreferences> prefs = SharedPreferences.getInstance();
  late Future<double?> weight;

  @override
  void initState() {
    super.initState();
    weight = prefs.then((value) => value.getDouble('weight'));
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<double?>(
        future: weight,
        builder: (context, snapshot) {
          double showWeight = snapshot.data != null ? snapshot.data! : 0.0;
          return Scaffold(
              appBar: appBar('Mesure du poids', false, context),
              body: Column(children: [
                Container(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20, bottom: 20),
                    child: weightStack(showWeight, 'kg', Colors.blue, 200, 200),
                  ),
                ),
                loadingSpinner()
              ]));
        });
  }
}

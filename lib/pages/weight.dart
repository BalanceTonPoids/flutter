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
  late Future<String?> metric;

  @override
  void initState() {
    super.initState();
    weight = prefs.then((value) => value.getDouble('weight') ?? 0.0);
    metric = prefs.then((value) => value.getString('metric') ?? 'kg');
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Future.wait([weight, metric]),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            double showWeight = snapshot.data![0] as double;
            String showMetric = snapshot.data![1] as String;
            return Scaffold(
                appBar: appBar('Mesure du poids', true, context),
                body: Column(children: [
                  Container(
                    alignment: Alignment.topCenter,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20, bottom: 20),
                      child: weightStack(
                          showWeight, showMetric, Colors.blue, 200, 200),
                    ),
                  ),
                  loadingSpinner()
                ]));
          } else {
            return const CircularProgressIndicator();
          }
        });
  }
}

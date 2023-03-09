import 'dart:math';

import 'package:balancetonpoids/models/scale_data.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../utils/widgets.dart';

class Stats extends StatefulWidget {
  const Stats({Key? key}) : super(key: key);

  @override
  State<Stats> createState() => _StatsState();
}

class _StatsState extends State<Stats> {
  final Future<SharedPreferences> prefs = SharedPreferences.getInstance();
  late List<ScaleData> scaleData;
  List<double> yValuesWeights = generateDataWeights();
  List<double> yValuesHeights = generateDataHeights();
  List<double> yValuesIMC = generateDataIMC();
  List<double> yValuesMuscularMass = generateMuscularMass();

  @override
  void initState() {
    super.initState();
    prefs.then((value) {
      final List<String>? scaleDataString = value.getStringList('scale');
      scaleData =
          scaleDataString != null ? ScaleData.decode(scaleDataString) : [];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBar('Statistiques', false, context),
        body: FutureBuilder(
            future: Future.value(scaleData),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final List<double> weightsList =
                    snapshot.data!.map((e) => e.weight).toList();
                print(weightsList);
              }
              return PageView(
                children: [
                  Column(
                    children: [
                      headerPolygon(yValuesWeights.last, 'kg', 'Mon poids',
                          'Dernier poids enregistré', Colors.blue),
                      const Padding(
                        padding: EdgeInsets.only(
                            top: 20, bottom: 20, left: 10, right: 10),
                        child: Text('Évolution de mon poids',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                      ),
                      AspectRatio(
                        aspectRatio: 1.7,
                        child: chartSample(yValuesWeights),
                      ),
                      ElevatedButton(
                          onPressed: () => setState(
                              () => yValuesWeights = generateDataWeights()),
                          child: const Text('Rafraichir')),
                      Padding(
                          padding: const EdgeInsets.only(
                              top: 20, bottom: 20, left: 10, right: 10),
                          child: Text(
                            'Poids actuel: ${yValuesWeights.last} kg',
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          )),
                      const Padding(
                          padding: EdgeInsets.only(left: 20, right: 20),
                          child: Text(
                              'Retrouvez ci-dessus votre poids actuel ainsi que l\'évolution de votre poids au cours des 7 derniers jours.',
                              style: TextStyle(fontSize: 14),
                              textAlign: TextAlign.center))
                    ],
                  ),
                  Column(
                    children: [
                      headerPolygon(
                          yValuesHeights.last.roundToDouble() / 100,
                          'm',
                          'Ma taille',
                          'Dernière taille enregistrée',
                          Colors.blue),
                      const Padding(
                        padding: EdgeInsets.only(
                            top: 20, bottom: 20, left: 10, right: 10),
                        child: Text('Évolution de ma taille',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                      ),
                      AspectRatio(
                        aspectRatio: 1.7,
                        child: chartSample(yValuesHeights),
                      ),
                      ElevatedButton(
                          onPressed: () => setState(
                              () => yValuesHeights = generateDataHeights()),
                          child: const Text('Rafraichir')),
                      Padding(
                          padding: const EdgeInsets.only(
                              top: 20, bottom: 20, left: 10, right: 10),
                          child: Text(
                            'Taille actuelle: ${yValuesHeights.last.roundToDouble() / 100} m',
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          )),
                      const Padding(
                          padding: EdgeInsets.only(left: 20, right: 20),
                          child: Text(
                              'Retrouvez ci-dessus votre taille actuelle ainsi que l\'évolution de votre taille au cours des 7 derniers jours.',
                              style: TextStyle(fontSize: 14),
                              textAlign: TextAlign.center))
                    ],
                  ),
                  Column(
                    children: [
                      headerPolygon(
                          yValuesIMC.last, '', 'Mon IMC', '', Colors.blue),
                      const Padding(
                        padding: EdgeInsets.only(
                            top: 20, bottom: 20, left: 10, right: 10),
                        child: Text('Évolution de mon IMC',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                      ),
                      AspectRatio(
                        aspectRatio: 1.7,
                        child: chartSample(yValuesIMC),
                      ),
                      ElevatedButton(
                          onPressed: () =>
                              setState(() => yValuesIMC = generateDataIMC()),
                          child: const Text('Rafraichir')),
                      Padding(
                          padding: const EdgeInsets.only(
                              top: 20, bottom: 20, left: 10, right: 10),
                          child: Text(
                            'IMC actuel: ${yValuesIMC.last}',
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          )),
                      const Padding(
                          padding: EdgeInsets.only(left: 20, right: 20),
                          child: Text(
                              'Retrouvez ci-dessus votre IMC actuel ainsi que l\'évolution de votre IMC au cours des 7 derniers jours.',
                              style: TextStyle(fontSize: 14),
                              textAlign: TextAlign.center))
                    ],
                  ),
                  Column(
                    children: [
                      headerPolygon(yValuesMuscularMass.last, '',
                          'Masse musculaire', '', Colors.blue),
                      const Padding(
                        padding: EdgeInsets.only(
                            top: 20, bottom: 20, left: 10, right: 10),
                        child: Text('Évolution de ma masse musculaire',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                      ),
                      AspectRatio(
                        aspectRatio: 1.7,
                        child: chartSample(yValuesMuscularMass),
                      ),
                      ElevatedButton(
                          onPressed: () => setState(() =>
                              yValuesMuscularMass = generateMuscularMass()),
                          child: const Text('Rafraichir')),
                      Padding(
                          padding: const EdgeInsets.only(
                              top: 20, bottom: 20, left: 10, right: 10),
                          child: Text(
                            'Masse musculaire actuelle: ${yValuesMuscularMass.last}',
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          )),
                      const Padding(
                          padding: EdgeInsets.only(left: 20, right: 20),
                          child: Text(
                              'Retrouvez ci-dessus votre masse musculaire actuelle ainsi que l\'évolution de votre masse musculaire au cours des 7 derniers jours.',
                              style: TextStyle(fontSize: 14),
                              textAlign: TextAlign.center))
                    ],
                  )
                ],
              );
            }));
  }
}

// Generate data
List<double> generateMuscularMass() {
  // Weights
  List<double> weights = generateDataWeights();
  print('weights: $weights');
  // Heights
  List<double> heights = generateDataHeights();
  print('heights: $heights');
  // Genre H : 0,407 x poids (kg) + 0,267 x taille (cm) - 19,2
  // Genre F : 0,252 x poids (kg) + 0,473 x taille (cm) - 48,3
  double firstDouble = 0;
  double secondDouble = 0;
  double thirdDouble = 0;
  String genre = 'M'; // M F O NULL
  if (genre == 'F') {
    print('A');
    firstDouble = 0.252;
    secondDouble = 0.473;
    thirdDouble = 48.3;
  } else {
    print('B');
    firstDouble = 0.407;
    secondDouble = 0.267;
    thirdDouble = 19.2;
  }
  List<double> data = List.generate(
      7,
      (index) => double.parse((firstDouble * weights[index] +
              secondDouble * heights[index] -
              thirdDouble)
          .toStringAsFixed(1)));
  print('data: $data');
  return data;
}

List<double> generateDataIMC() {
  // Weights
  List<double> weights = generateDataWeights();
  print('weights: $weights');
  // Heights
  List<double> heights = generateDataHeights();
  print('heights: $heights');
  // IMC = poid (kg) / taille (m)
  List<double> data = List.generate(
      7,
      (index) => double.parse(
          (weights[index] / (heights[index] / 100) / (heights[index] / 100))
              .toStringAsFixed(1)));
  print('data: $data');
  return data;
}

List<double> generateDataHeights() {
  // en cm
  int startHeight = Random().nextInt(100) + 100;
  List<double> data = List.generate(
      7,
      (index) =>
          startHeight +
          double.parse((Random().nextDouble()).toStringAsFixed(1)));
  return data.map((e) => e.toDouble()).toList();
}

List<double> generateDataWeights() {
  double startWeight =
      Random().nextDouble() * 100 > 0 ? Random().nextDouble() * 100 : 3;
  startWeight = double.parse(startWeight.toStringAsFixed(1));
  print('startWeight: $startWeight');
  List<double> data = List.generate(
      7,
      (index) => double.parse(
          (startWeight + Random().nextDouble() * 10).toStringAsFixed(1)));
  print('data: $data');
  print('min: ${data.reduce(min)}');
  print('max: ${data.reduce(max)}');
  print(
      'minLine: ${(data.reduce(min) - 5) < 0 ? 0 : (data.reduce(min) - 5).toStringAsFixed(0)}');
  print('moyLine: ${data.map}');
  print(
      'maxLine: ${(data.reduce(max) + 5) < 0 ? 0 : (data.reduce(max) + 5).toStringAsFixed(0)}');
  calculMoy(data);
  return data;
}

calculMoy(List<double> values) {
  List<double> data = values;
  double moy = data.reduce((value, element) => value + element) / data.length;
  print('Moyenne : $moy');
  return moy;
}

LineChart chartSample(List<double> yValues) {
  return LineChart(LineChartData(
      minY:
          yValues.reduce(min) - 5 < 0 ? 0.toDouble() : yValues.reduce(min) - 5,
      maxY:
          yValues.reduce(max) + 5 < 0 ? 0.toDouble() : yValues.reduce(max) + 5,
      extraLinesData: ExtraLinesData(horizontalLines: [
        horizontalLine(
            (yValues.reduce(min) < 0 ? 0.toDouble() : yValues.reduce(min)),
            Colors.green,
            'Min'),
        horizontalLine(calculMoy(yValues), Colors.orange, 'Moy'),
        horizontalLine(
            (yValues.reduce(max) < 0 ? 0.toDouble() : yValues.reduce(max)),
            Colors.red,
            'Max')
      ]),
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
      ),
      lineBarsData: [
        LineChartBarData(
          spots: yValues
              .asMap()
              .entries
              .map((e) => FlSpot(e.key.toDouble(), e.value))
              .toList(),
          isCurved: true,
          belowBarData: BarAreaData(
            show: true,
            gradient: const LinearGradient(
              colors: [
                Color(0x5923b6dc),
                Color(0x5902c99a),
              ],
            ),
          ),
          barWidth: 3,
          gradient: const LinearGradient(
            colors: [
              Color(0xff23b6e6),
              Color(0xff02d39a),
            ],
          ),
        ),
      ],
      titlesData: FlTitlesData(
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
      )));
}

TextStyle labelStyle(Color color) {
  return TextStyle(
      color: color,
      height: 1.5,
      fontStyle: FontStyle.italic,
      fontWeight: FontWeight.bold,
      shadows: const [
        Shadow(blurRadius: 2, color: Colors.black, offset: Offset(0.5, 0.5))
      ]);
}

HorizontalLine horizontalLine(double y, Color color, String label) {
  return HorizontalLine(
    y: y,
    color: color,
    strokeWidth: 2,
    label: HorizontalLineLabel(
      labelResolver: (value) => label,
      show: true,
      style: labelStyle(color),
      alignment: Alignment.topRight,
    ),
  );
}

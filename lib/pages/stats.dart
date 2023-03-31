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
  late Future<List<String>?> scaleData;
  late Future<List<ScaleData>?> scaleDataList;
  late Future<List<double>?> weightsList;
  late Future<List<double>?> fatList;
  late Future<List<double>?> waterList;
  late Future<List<double>?> imcList;
  late Future<List<double>?> muscleList;

  @override
  void initState() {
    super.initState();
    scaleData = prefs.then((value) => value.getStringList('scale'));
    scaleDataList = scaleData.then((value) => ScaleData.decode(value!));
    weightsList =
        scaleDataList.then((value) => value!.map((e) => e.weight).toList());
    fatList = scaleDataList.then((value) => value?.map((e) => e.fat).toList());
    waterList =
        scaleDataList.then((value) => value?.map((e) => e.water).toList());
    imcList = scaleDataList.then((value) => value?.map((e) => e.imc).toList());
    muscleList =
        scaleDataList.then((value) => value?.map((e) => e.muscle).toList());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBar('Statistiques', false, context),
        body: FutureBuilder(
            future: Future.wait(
                [weightsList, fatList, waterList, imcList, muscleList]),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                print(snapshot.data);
                List<double> wList = snapshot.data![0] as List<double>;
                List<double> fList = snapshot.data![1] as List<double>;
                List<double> waList = snapshot.data![2] as List<double>;
                List<double> iList = snapshot.data![3] as List<double>;
                List<double> mList = snapshot.data![4] as List<double>;
                return PageView(
                  children: [
                    Column(
                      children: [
                        headerPolygon(
                            wList.isNotEmpty ? wList.last : 0,
                            'kg',
                            'Mon poids',
                            'Dernier poids enregistré',
                            Colors.blue),
                        const Padding(
                          padding: EdgeInsets.only(
                              top: 20, bottom: 20, left: 10, right: 10),
                          child: Text('Évolution de mon poids',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold)),
                        ),
                        AspectRatio(
                          aspectRatio: 1.7,
                          child: wList.isNotEmpty
                              ? chartSample(wList)
                              : const Text('Aucune donnée',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20)),
                        ),
                        Padding(
                            padding: const EdgeInsets.only(
                                top: 0, bottom: 20, left: 10, right: 10),
                            child: Text(
                              'Poids actuel: ${wList.isNotEmpty ? wList.last : 0} kg',
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            )),
                        const Padding(
                            padding: EdgeInsets.only(left: 20, right: 20),
                            child: Text(
                                'Retrouvez ci-dessus votre poids actuel ainsi que l\'évolution de votre poids au cours des 7 derniers relevés.',
                                style: TextStyle(fontSize: 14),
                                textAlign: TextAlign.center))
                      ],
                    ),
                    Column(
                      children: [
                        headerPolygon(fList.isNotEmpty ? fList.last : 0, '%',
                            'Taux de graisse', 'Dernière donnée', Colors.blue),
                        const Padding(
                          padding: EdgeInsets.only(
                              top: 0, bottom: 20, left: 10, right: 10),
                          child: Text('Évolution de mon taux de graisse',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold)),
                        ),
                        AspectRatio(
                          aspectRatio: 1.7,
                          child: fList.isNotEmpty
                              ? chartSample(fList)
                              : const Text('Aucune donnée',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20)),
                        ),
                        Padding(
                            padding: const EdgeInsets.only(
                                top: 0, bottom: 20, left: 10, right: 10),
                            child: Text(
                              'Taux actuel: ${fList.isNotEmpty ? fList.last : 0} %',
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            )),
                        const Padding(
                            padding: EdgeInsets.only(left: 20, right: 20),
                            child: Text(
                                'Retrouvez ci-dessus votre taux actuelle ainsi que l\'évolution de votre taux au cours des 7 derniers relevés.',
                                style: TextStyle(fontSize: 14),
                                textAlign: TextAlign.center))
                      ],
                    ),
                    Column(
                      children: [
                        headerPolygon(waList.isNotEmpty ? waList.last : 0, '%',
                            'Taux d\'eau', 'Dernière donnée', Colors.blue),
                        const Padding(
                          padding: EdgeInsets.only(
                              top: 0, bottom: 20, left: 10, right: 10),
                          child: Text('Évolution de mon taux d\'eau',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold)),
                        ),
                        AspectRatio(
                          aspectRatio: 1.7,
                          child: waList.isNotEmpty
                              ? chartSample(waList)
                              : const Text('Aucune donnée',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20)),
                        ),
                        Padding(
                            padding: const EdgeInsets.only(
                                top: 0, bottom: 20, left: 10, right: 10),
                            child: Text(
                              'Taux actuelle: ${waList.isNotEmpty ? waList.last : 0} %',
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            )),
                        const Padding(
                            padding: EdgeInsets.only(left: 20, right: 20),
                            child: Text(
                                'Retrouvez ci-dessus votre taux actuelle ainsi que l\'évolution de votre taux au cours des 7 derniers relevés.',
                                style: TextStyle(fontSize: 14),
                                textAlign: TextAlign.center))
                      ],
                    ),
                    Column(
                      children: [
                        headerPolygon(iList.isNotEmpty ? iList.last : 0, '',
                            'Mon IMC', '', Colors.blue),
                        const Padding(
                          padding: EdgeInsets.only(
                              top: 0, bottom: 20, left: 10, right: 10),
                          child: Text('Évolution de mon IMC',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold)),
                        ),
                        AspectRatio(
                          aspectRatio: 1.7,
                          child: iList.isNotEmpty
                              ? chartSample(iList)
                              : const Text('Aucune donnée',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20)),
                        ),
                        Padding(
                            padding: const EdgeInsets.only(
                                top: 20, bottom: 20, left: 10, right: 10),
                            child: Text(
                              'IMC actuel: ${iList.isNotEmpty ? iList.last : 0}',
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
                        headerPolygon(mList.isNotEmpty ? mList.last : 0, '%',
                            'Masse musculaire', '', Colors.blue),
                        const Padding(
                          padding: EdgeInsets.only(
                              top: 0, bottom: 20, left: 10, right: 10),
                          child: Text('Évolution de ma masse musculaire',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold)),
                        ),
                        AspectRatio(
                          aspectRatio: 1.7,
                          child: mList.isNotEmpty
                              ? chartSample(mList)
                              : const Text('Aucune donnée',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20)),
                        ),
                        Padding(
                            padding: const EdgeInsets.only(
                                top: 0, bottom: 20, left: 10, right: 10),
                            child: Text(
                              'Masse musculaire actuelle: ${mList.isNotEmpty ? mList.last : 0}%',
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            )),
                        const Padding(
                            padding: EdgeInsets.only(left: 20, right: 20),
                            child: Text(
                                'Retrouvez ci-dessus votre masse musculaire actuelle ainsi que l\'évolution de votre masse musculaire au cours des 7 derniers relevés.',
                                style: TextStyle(fontSize: 14),
                                textAlign: TextAlign.center))
                      ],
                    )
                  ],
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            }));
  }
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

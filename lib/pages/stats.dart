import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../utils/widgets.dart';

class Stats extends StatefulWidget {
  const Stats({Key? key}) : super(key: key);

  @override
  State<Stats> createState() => _StatsState();
}

class _StatsState extends State<Stats> {

  List<double> yValuesWeights = generateDataWeights();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar("Statistiques", false, context),
      body: PageView(
        children: [
          Column(
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 20, bottom: 20, left: 10, right: 10),
                child: Text("Évolution de mon poids", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              ),
              AspectRatio(
                aspectRatio: 1.7,
                child: chartWeights(yValuesWeights),
              ),
              ElevatedButton(
                  onPressed: () => setState(() => yValuesWeights = generateDataWeights()),
                  child: const Text("Rafraichir")
              )
            ],
          ),
          Column(
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 20, bottom: 20, left: 10, right: 10),
                child: Text("Évolution de mon IMC", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              ),
              AspectRatio(
                aspectRatio: 1.7,
                child: chartWeights(yValuesWeights),
              ),
              ElevatedButton(
                  onPressed: () => setState(() => yValuesWeights = generateDataWeights()),
                  child: const Text("Rafraichir")
              )
            ],
          )
        ],
      )
    );
  }
}

// Chart Weights
LineChart chartWeights(List<double> yValues) {
  return LineChart(
      LineChartData(
          minY: yValues.reduce(min) - 5 < 0 ? 0.toDouble() : yValues.reduce(min) - 5,
          maxY: yValues.reduce(max) + 5 < 0 ? 0.toDouble() : yValues.reduce(max) + 5,
          extraLinesData: ExtraLinesData(horizontalLines: [
            horizontalLine((yValues.reduce(min) < 0 ? 0.toDouble() : yValues.reduce(min)), Colors.green, "Min"),
            horizontalLine(calculMoy(yValues), Colors.orange, "Moy"),
            horizontalLine((yValues.reduce(max) < 0 ? 0.toDouble() : yValues.reduce(max)), Colors.red, "Max")
          ]),
          gridData: FlGridData(
            show: true,
            drawVerticalLine: true,
          ),
          lineBarsData: [
            LineChartBarData(
              spots: yValues.asMap().entries.map((e) => FlSpot(e.key.toDouble(), e.value)).toList(),
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
              sideTitles: SideTitles(
                  showTitles: false
              ),
            ),
            topTitles: AxisTitles(
              sideTitles: SideTitles(
                  showTitles: false
              ),
            ),
          )
      )
  );
}

// Chart IMC
LineChart chartIMC(List<double> yValues) {
  return LineChart(
      LineChartData(
          minY: yValues.reduce(min) - 5 < 0 ? 0.toDouble() : yValues.reduce(min) - 5,
          maxY: yValues.reduce(max) + 5 < 0 ? 0.toDouble() : yValues.reduce(max) + 5,
          extraLinesData: ExtraLinesData(horizontalLines: [
            horizontalLine((yValues.reduce(min) < 0 ? 0.toDouble() : yValues.reduce(min)), Colors.green, "Min"),
            horizontalLine(calculMoy(yValues), Colors.orange, "Moy"),
            horizontalLine((yValues.reduce(max) < 0 ? 0.toDouble() : yValues.reduce(max)), Colors.red, "Max")
          ]),
          gridData: FlGridData(
            show: true,
            drawVerticalLine: true,
          ),
          lineBarsData: [
            LineChartBarData(
              spots: yValues.asMap().entries.map((e) => FlSpot(e.key.toDouble(), e.value)).toList(),
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
              sideTitles: SideTitles(
                  showTitles: false
              ),
            ),
            topTitles: AxisTitles(
              sideTitles: SideTitles(
                  showTitles: false
              ),
            ),
          )
      )
  );
}

List<double> generateDataIMC() {
  // Weights
  List<double> weights = generateDataWeights();
  // Heights
  List<double> heights = generateDataHeights();
  return data;
}

List<double> generateDataHeights() {
  // en cm
  int startHeight = Random().nextInt(250) * 100 > 0 ? Random().nextInt(250) * 100 : 3;
  List<int> data = List.generate(7, (index) => startHeight + Random().nextInt(1));
  return data.map((e) => e.toDouble()).toList();
}

List<double> generateDataWeights() {
  double startWeight = Random().nextDouble() * 100 > 0 ? Random().nextDouble() * 100 : 3;
  startWeight = double.parse(startWeight.toStringAsFixed(1));
  print("startWeight: $startWeight");
  List<double> data = List.generate(7, (index) => double.parse((startWeight + Random().nextDouble() * 10).toStringAsFixed(1)));
  print("data: $data");
  print("min: ${data.reduce(min)}");
  print("max: ${data.reduce(max)}");
  print("minLine: ${(data.reduce(min) - 5) < 0 ? 0 : (data.reduce(min) - 5).toStringAsFixed(0)}");
  print("moyLine: ${data.map}");
  print("maxLine: ${(data.reduce(max) + 5) < 0 ? 0 : (data.reduce(max) + 5).toStringAsFixed(0)}");
  calculMoy(data);
  return data;
}

calculMoy(List<double> values) {
  List<double> data = values;
  double moy = data.reduce((value, element) => value + element) / data.length;
  print("Moyenne : ${moy}");
  return moy;
}

TextStyle labelStyle(Color color) {
  return TextStyle(
    color: color,
    height: 1.5,
    fontStyle: FontStyle.italic,
    fontWeight: FontWeight.bold,
    shadows: const [
      Shadow(
        blurRadius: 2,
        color: Colors.black,
        offset: Offset(0.5, 0.5)
      )
    ]
  );
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
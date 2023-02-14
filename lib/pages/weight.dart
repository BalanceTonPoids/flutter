import 'dart:ui';
import 'package:flutter/material.dart';
import '../utils/widgets.dart';

class Weight extends StatefulWidget {
  const Weight({Key? key}) : super(key: key);

  @override
  State<Weight> createState() => _WeightState();
}

class _WeightState extends State<Weight> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar("Mesure du poids"),
      body: Column(
        children: [
          Container(
            alignment: Alignment.topCenter,
            child: weightStack(),
          ),
          loadingSpinner()
        ]
      )
    );
  }
}
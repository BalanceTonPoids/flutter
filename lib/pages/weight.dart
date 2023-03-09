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
      appBar: appBar("Mesure du poids", false, context),
      body: Column(
        children: [
          Container(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 20),
              child: weightStack(55.0, 'kg', Colors.blue, 200, 200),
            ),
          ),
          loadingSpinner()
        ]
      )
    );
  }
}
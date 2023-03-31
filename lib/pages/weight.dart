import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../models/scale_data.dart';
import '../services/api_client.dart';
import '../services/bluetooth.dart';
import '../services/generateData.dart';
import '../utils/bluetooth.widget.dart';
import '../utils/widgets.dart';

class Weight extends StatefulWidget {
  const Weight({Key? key}) : super(key: key);

  @override
  State<Weight> createState() => _WeightState();
}

class _WeightState extends State<Weight> {
  final Future<SharedPreferences> prefs = SharedPreferences.getInstance();
  final storage = const FlutterSecureStorage();
  late Future<double?> weight;
  late Future<String?> metric;
  late Future<String?> scaleId;
  late Future<String?> scaleName;
  bool isLoading = false;
  late Map<String, double> generatedData;

  @override
  void initState() {
    super.initState();
    Bluetooth().checkAndRequestBluetoothPermission();
    weight = prefs.then((value) => value.getDouble('weight') ?? 0.0);
    metric = prefs.then((value) => value.getString('metric') ?? 'kg');
    scaleId = storage.read(key: 'scaleId');
    scaleName = storage.read(key: 'scaleName');
    generatedData = {
      'weight': 0.0,
      'imc': 0.0,
      'fat': 0.0,
      'water': 0.0,
      'muscle': 0.0
    };
  }

  Future<void> fetchData(double val) async {
    setState(() {
      isLoading = true;
    });
    Bluetooth().connectToScale();
    // Simulate fetching data from scale
    await Future.delayed(const Duration(seconds: 3));
    // add generate data here
    generatedData = GenerateData.generate(weight: val);
    final ScaleData dataToSend = ScaleData(
      weight: generatedData['weight'] as double,
      imc: generatedData['imc'] as double,
      fat: generatedData['fat'] as double,
      water: generatedData['water'] as double,
      muscle: generatedData['muscle'] as double,
      date: DateTime.now().toIso8601String(),
    );
    ApiClient(httpClient: http.Client()).sendScaleData(dataToSend);
    setState(() {
      weight = prefs.then((value) => value.getDouble('weight'));
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Future.wait([weight, metric, scaleId, scaleName]),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            double showWeight = snapshot.data![0] as double;
            String showMetric = snapshot.data![1] as String;
            String? showScaleId = snapshot.data![2] as String?;
            String? showScaleName = snapshot.data![3] as String?;

            if (showScaleId != null && showScaleName != null) {
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
                  const Text('Balance connectée'),
                  Expanded(
                    child: ListView.builder(
                      itemCount: generatedData.length,
                      itemBuilder: (BuildContext context, int index) {
                        String key = generatedData.keys.toList()[index];
                        double value = generatedData[key] ?? 0.0;
                        return ListTile(
                          title: Text(key),
                          trailing: Text(value.toStringAsFixed(2)),
                        );
                      },
                    ),
                  ),
                ]),
                floatingActionButton: FloatingActionButton(
                    onPressed: () => {
                          if (!isLoading)
                            {fetchData(showWeight > 0.0 ? showWeight : 70.0)}
                        },
                    child: isLoading
                        ? const CircularProgressIndicator(
                            strokeWidth: 4,
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.white),
                          )
                        : const Icon(Icons.spatial_tracking)),
              );
            } else {
              return Scaffold(
                  appBar: appBar('Connecter ma balance', true, context),
                  body: Column(children: [
                    Container(
                      alignment: Alignment.topCenter,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 20, bottom: 20),
                        child: weightStack(
                            showWeight, showMetric, Colors.blue, 200, 200),
                      ),
                    ),
                    buttonCard('Aucune balance trouvée', 'Lancer un scan ',
                        Colors.blue, false, context, bluetoothWidget(
                      onDeviceSelected: () {
                        setState(() {
                          scaleId = storage.read(key: 'scaleId');
                          scaleName = storage.read(key: 'scaleName');
                        });
                      },
                    ), true)
                  ]));
            }
          } else {
            return const CircularProgressIndicator();
          }
        });
  }
}

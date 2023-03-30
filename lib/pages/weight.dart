import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../models/scale_data.dart';
import '../services/api_client.dart';
import '../services/bluetooth.dart';
import '../services/generateData.dart';
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
  late bool scaleAvailable;
  bool isLoading = false;
  late Map<String, double> generatedData;

  @override
  void initState() {
    super.initState();
    Bluetooth().startScan();
    weight = prefs.then((value) => value.getDouble('weight') ?? 0.0);
    metric = prefs.then((value) => value.getString('metric') ?? 'kg');
    scaleId = storage.read(key: 'scaleId');
    scaleName = storage.read(key: 'scaleName');
    scaleAvailable = false;
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
            String? showScaleName = snapshot.data![2] as String?;

            if (showScaleId != null && showScaleName != null) {
              Bluetooth().stopScan();
              scaleAvailable = true;
            }
            if (scaleAvailable) {
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
                    const Text('Aucune balance trouvée'),
                    ElevatedButton(
                      child: const Text('Rechercher'),
                      onPressed: () async {
                        Bluetooth().startScan();
                        final scanResults =
                            await FlutterBlue.instance.scanResults.first;
                        // ignore: use_build_context_synchronously
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DeviceList(
                              scanResults: scanResults,
                              onDeviceConnected: () {
                                setState(() {
                                  scaleAvailable = true;
                                });
                              },
                            ),
                          ),
                        );
                      },
                    ),
                  ]));
            }
          } else {
            return const CircularProgressIndicator();
          }
        });
  }
}

class DeviceList extends StatelessWidget {
  const DeviceList(
      {Key? key, required this.scanResults, required this.onDeviceConnected})
      : super(key: key);

  final List<ScanResult> scanResults;
  final Function() onDeviceConnected;
  final storage = const FlutterSecureStorage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Available Devices'),
      ),
      body: Column(
        children: [
          StreamBuilder<bool>(
            stream: FlutterBlue.instance.isScanning,
            initialData: false,
            builder: (c, snapshot) {
              if (snapshot.data!) {
                return const LinearProgressIndicator();
              } else {
                return Container();
              }
            },
          ),
          Expanded(
            child: ListView(
              children: scanResults
                  .where((r) => r.device.name.isNotEmpty)
                  .map((r) => Column(
                        children: [
                          Text(r.device.name),
                          ElevatedButton(
                              child: const Text('Connect'),
                              onPressed: () async {
                                await r.device.connect();
                                await storage.write(
                                    key: 'scaleName',
                                    value: r.device.name.toString());
                                await storage.write(
                                    key: 'scaleId',
                                    value: r.device.id.toString());
                                onDeviceConnected();
                                Bluetooth().stopScan();
                                // ignore: use_build_context_synchronously
                                Navigator.of(context).pop();
                              }),
                        ],
                      ))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}

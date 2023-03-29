import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:permission_handler/permission_handler.dart';

import '../services/bluetooth.dart';

checkPerm() async {
  BuildContext context;
  var status = await Permission.bluetooth.status;
  if (status.isDenied) {
    await [
      Permission.bluetooth,
      Permission.bluetoothConnect,
      Permission.bluetoothScan,
      Permission.bluetoothAdvertise,
      Permission.location
    ].request();
  }
  if (await Permission.bluetooth.status.isPermanentlyDenied) {
    openAppSettings();
  }
  Bluetooth().startScan();
}
class connecterMaBalance extends StatefulWidget {
  const connecterMaBalance({Key? key}) : super(key: key);

  @override
  State<connecterMaBalance> createState() => _connecterMaBalanceState();
}

class _connecterMaBalanceState extends State<connecterMaBalance> {
  final storage = const FlutterSecureStorage();
  late String _connectionStatus;
  @override
  void initState() {
    super.initState();
    checkPerm();
    _connectionStatus = '';
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          title: Text('Connecter ma balance'),
        ),
      body:   Column(

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
      StreamBuilder<List<ScanResult>>(
        stream: FlutterBlue.instance.scanResults,
        initialData: const [],
        builder: (c, snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }
          if (_connectionStatus.isNotEmpty) {
            return  Text(_connectionStatus , style: TextStyle(
                color: Colors.green,
              fontSize: 18,height: 20

            ), );
          }
          if (snapshot.data!.isEmpty) {
            return const Text('No devices found');
          }
          return Column(
            children: (snapshot.data ?? [])
                .map((r) => r.device.name != ''
                ? Column(children: [Padding(padding: EdgeInsets.only(top: 20)),
              Text(r.device.name),
              ElevatedButton(
                  child: const Text('Connect'),
                  onPressed: () async => {
                    await r.device.connect(),
                    await storage.write(
                        key: 'scaleName',
                        value: r.device.name.toString()),
                    await storage.write(
                        key: 'scaleId',
                        value: r.device.id.toString()),
                    Bluetooth().stopScan(),
                    setState(() {Padding(padding: EdgeInsets.only(top: 20));
                      _connectionStatus =
                      'Connected to ${r.device.name}';
                    }),
                  })
            ])
                : Container())
                .toList(),
          );
        },
      ),
    ]));

  }
}

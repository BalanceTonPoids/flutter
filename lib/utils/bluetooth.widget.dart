import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:permission_handler/permission_handler.dart';

import '../services/bluetooth.dart';

class bluetoothWidget extends StatefulWidget {
  final void Function() onDeviceSelected;
  const bluetoothWidget({Key? key, required this.onDeviceSelected})
      : super(key: key);

  @override
  State<bluetoothWidget> createState() => _bluetoothWidgetState();
}

class _bluetoothWidgetState extends State<bluetoothWidget> {
  final storage = const FlutterSecureStorage();
  late String _connectionStatus;

  @override
  void initState() {
    super.initState();
    Bluetooth().checkAndRequestBluetoothPermission();
    Bluetooth().startScan();
    _connectionStatus = '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Connecter ma balance'),
        ),
        body: Column(children: [
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
                return Text(
                  _connectionStatus,
                  style:
                      TextStyle(color: Colors.green, fontSize: 18, height: 20),
                );
              }
              if (snapshot.data!.isEmpty) {
                return const Padding(
                    padding: const EdgeInsets.all(20),
                    child: const Text('Pas d\'appareil disponible'));
              }
              return Column(
                children: (snapshot.data ?? [])
                    .map((r) => r.device.name != ''
                        ? Column(children: [
                            Padding(padding: EdgeInsets.only(top: 20)),
                            Text(r.device.name),
                            ElevatedButton(
                                child: const Text('Se connecter'),
                                onPressed: () async => {
                                      await r.device.connect(),
                                      await storage.write(
                                          key: 'scaleName',
                                          value: r.device.name.toString()),
                                      await storage.write(
                                          key: 'scaleId',
                                          value: r.device.id.toString()),
                                      setState(() {
                                        Padding(
                                            padding: EdgeInsets.only(top: 20));
                                        _connectionStatus =
                                            'Connecter à ${r.device.name}';
                                      }),
                                      await Future.delayed(
                                          const Duration(seconds: 2)),
                                      Bluetooth().stopScan(),
                                      widget.onDeviceSelected(),
                                      Navigator.of(context).pop(),
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

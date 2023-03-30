import 'package:flutter_blue/flutter_blue.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:permission_handler/permission_handler.dart';

class Bluetooth {
  final storage = const FlutterSecureStorage();

  Future<void> checkAndRequestBluetoothPermission() async {
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
    print(status);
    if (await Permission.bluetooth.status.isPermanentlyDenied) {
      openAppSettings();
    }
  }

  void startScan() {
    FlutterBlue.instance.startScan(
        timeout: const Duration(seconds: 4),
        scanMode: ScanMode.lowLatency,
        allowDuplicates: true);
  }

  void stopScan() {
    FlutterBlue.instance.stopScan();
  }

  void connectToScale() async {
    final scaleId = await storage.read(key: 'scaleId');
    print(scaleId);
    if (scaleId != null) {
      FlutterBlue.instance.startScan(
          timeout: const Duration(seconds: 4),
          scanMode: ScanMode.lowLatency,
          allowDuplicates: true);
      FlutterBlue.instance.scanResults.listen((results) {
        results
            .where((r) => r.device.id.toString() == scaleId)
            .toList()
            .first
            .device
            .connect(timeout: const Duration(seconds: 4), autoConnect: true)
            .then((value) {
          print('connected');
        });
      });
    }

    FlutterBlue.instance.connectedDevices.then((value) {
      print(value);
    });
  }
}

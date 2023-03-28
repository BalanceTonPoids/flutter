import 'package:balancetonpoids/pages/auth.dart';
import 'package:balancetonpoids/services/bluetooth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:permission_handler/permission_handler.dart';
import '../main.dart';
import '../utils/widgets.dart';

class Welcome extends StatefulWidget {
  const Welcome({Key? key}) : super(key: key);

  @override
  State<Welcome> createState() => _WelcomeState();
}

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

class _WelcomeState extends State<Welcome> {
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
        body: PageView(
      children: [
        Column(
          children: [
            const LogoSection(),
            titleText,
            const Padding(
                padding: EdgeInsets.only(top: 20),
                child: Text('Bienvenue sur l\'application de suivi de poids.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 15,
                      fontWeight: FontWeight.normal,
                    ))),
            Padding(
              padding: const EdgeInsets.only(top: 100),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text('Swipez vers la droite pour continuer.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 15,
                          fontWeight: FontWeight.w100,
                        )),
                    SizedBox(width: 10),
                    Icon(
                      Icons.swipe_left,
                      size: 40,
                    ),
                  ]),
            ),
          ],
        ),
        Column(children: [
          const Padding(
              padding: EdgeInsets.only(top: 50),
              child: Text('Connecter ma balance',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ))),
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
                return Text(_connectionStatus);
              }
              if (snapshot.data!.isEmpty) {
                return const Text('No devices found');
              }
              return Column(
                children: (snapshot.data ?? [])
                    .map((r) => r.device.name != ''
                        ? Column(children: [
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
                                      setState(() {
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
        ]),
        Center(
          child: Column(children: [
            const LogoSection(),
            titleText,
            const Padding(
                padding: EdgeInsets.only(top: 25, bottom: 50),
                child: Text.rich(
                    TextSpan(children: [
                      TextSpan(
                          text:
                              'Connectez-vous à votre compte pour retrouver votre progression ou '),
                      TextSpan(
                          text: 'continuez en tant qu\'invité.',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ))
                    ]),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 15,
                      fontWeight: FontWeight.normal,
                    ))),
            Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                child: button(context, 'Continuez avec un Email', Colors.blue,
                    Colors.white, Colors.blue, 2, const LoginPage(), false)),
            Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                child: button(
                    context,
                    'Continuez en tant qu\'invité',
                    Colors.white,
                    Colors.blue,
                    Colors.blue,
                    2,
                    const MainPage(),
                    true)),
          ]),
        ),
      ],
    ));
  }
}

class LogoSection extends StatefulWidget {
  const LogoSection({super.key});

  @override
  _LogoSectionState createState() => _LogoSectionState();
}

class _LogoSectionState extends State<LogoSection> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 100),
      child: Image.asset(
        Theme.of(context).brightness == Brightness.light
            ? 'assets/logo-light.png'
            : 'assets/logo-dark.png',
        width: 200,
        height: 200,
        fit: BoxFit.cover,
      ),
    );
  }
}

Widget titleText = const Padding(
    padding: EdgeInsets.only(top: 50),
    child: Text('BalanceTonPoids',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontFamily: 'Roboto',
          fontSize: 30,
          fontWeight: FontWeight.bold,
        )));

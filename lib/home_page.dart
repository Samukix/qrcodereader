import 'package:buscarcep2/resultado_cep.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner_plus/qr_code_scanner_plus.dart';
import 'dart:io';



void main() {
  runApp(const QRcode());
}

class QRcode extends StatelessWidget {
  const QRcode({super.key});

  //barra de cima
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'QR Code',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
      ),
      home: const MyHomePage(title: 'QR Code'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

//essa parte abre o scanner.
class _MyHomePageState extends State<MyHomePage> {
  void _openQRScanner() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const QRViewExample()
      ),
    );
  }

  // tela inicial e botao de iniciar o qr code
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
      ),
      body: const Center(
        child: Text('Clique no botão para escanear um QR Code', textAlign: TextAlign.center,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
        onPressed: _openQRScanner,
        tooltip: 'Escanear QR',
        child: const Icon(Icons.qr_code_scanner),
      ),
    );
  }
}

//quando ele lê, ele retorna essas informações.
class QRViewExample extends StatefulWidget {
  const QRViewExample({super.key});

  @override
  State<StatefulWidget> createState() => _QRViewExampleState();
}

class _QRViewExampleState extends State<QRViewExample> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  Barcode? result;

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller?.pauseCamera();
    } else if (Platform.isIOS) {
      controller?.resumeCamera();
    }
  }

  //tela de leitura do QR code
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        foregroundColor: Colors.white,
        title: Text('Escanei o QR Code'),
        centerTitle: true,
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: Icon(
              Icons.close,
              color: Colors.white,
              size: 28
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 5,
            child: Stack(
              alignment: Alignment.center,
              children: [ QRView(
                key: qrKey,
                onQRViewCreated: _onQRViewCreated,
                overlay: QrScannerOverlayShape(
                  borderColor: Colors.white,
                  borderRadius: 10,
                  borderLength: 30,
                  borderWidth: 10,
                  cutOutSize: 250,
                ),
              ),
                Positioned(
                  bottom: MediaQuery
                      .of(context)
                      .size
                      .height / 4.9,
                  child: const Text(
                    'Aponte sua câmera para o código QR e capture-o',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.black,
        child: SizedBox(
          height: 60,
          child: Center(
            child: IconButton(
              icon: Icon(
                  CupertinoIcons.camera_circle_fill,
                  color: Colors.white,
                  size: 50),
              onPressed: () {},
            ),
          ),
        ),
      ),
    );
  }

  //essa e a parte que ele le o que ta dentro do qr code, com condicional de link tbm
  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) async {
      controller.pauseCamera();
      setState(() {
        result = scanData;
      });

      if (result != null && result!.code != null) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ResultPage(qrData: result!.code!),
          ),
        );
      }
    });
  }
}

import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'dart:async';
import 'package:vibration/vibration.dart';

class Scanner extends StatefulWidget {
  const Scanner({Key? key}) : super(key: key);

  @override
  State<Scanner> createState() => _ScannerState();
}

class _ScannerState extends State<Scanner> {
  late QRViewController controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  String? scannedData = '';
  bool _isShowingPopup = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          QRView(
            key: qrKey,
            onQRViewCreated: _onQRViewCreated,
            overlay: QrScannerOverlayShape(
              borderColor: Colors.white,
              borderRadius: 10,
              borderLength: 30,
              borderWidth: 10,
              cutOutSize: 0.75 * MediaQuery.of(context).size.width,
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ElevatedButton.icon(
                  onPressed: _toggleFlash,
                  icon: Icon(Icons.flash_on, color: Colors.blue.shade400),
                  label: Text('Toggle Flash',style: TextStyle(color: Colors.blue.shade400),),
                ),
                SizedBox(height: 10),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) async {
      if (!_isShowingPopup) {
        setState(() {
          scannedData = scanData.code;
          _isShowingPopup = true;
        });
        _showScannedDataPopup(scannedData).then((_) {
          setState(() {
            _isShowingPopup = false;
          });
        });
        // Vibrate when QR code is successfully scanned
        Vibration.vibrate(duration: 500);
      }
    });
  }

  Future<void> _showScannedDataPopup(String? scannedData) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Scanned QR Data'),
          content: Text(scannedData ?? 'No data scanned'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }


  void _toggleFlash() {
    controller.toggleFlash();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}

import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
//import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:project_sih/main.dart';
import 'package:qr_code_scanner_plus/qr_code_scanner_plus.dart';

//import 'package:google_mlkit_barcode_scanning/google_mlkit_barcode_scanning.dart';

class Qr extends StatelessWidget {
  const Qr({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:QrScan(),
    );
  }
}

class QrScan extends StatefulWidget {
  const QrScan({super.key});
  @override
  State<QrScan> createState() => _MyHomePageState();
}
Future<void> getData(File imageFile) async{
  final request = await http.MultipartRequest('POST',Uri.parse(""));
  request.files.add(await http.MultipartFile.fromPath('qrcode', imageFile.path));

}
class _MyHomePageState extends State<QrScan> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
 Barcode? result;
  QRViewController? controller;
  XFile? pickedImage;
  late String myText;
  bool isScanning=false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          QRView(
            key: qrKey,
            onQRViewCreated: _onQRViewCreated,
          ),
          // Scanner overlay with animation
          Center(
            child: Stack(
              children: [
                // Border box
                Container(
                  width: 250,
                  height: 250,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.green, width: 4),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                // Moving red line
                Positioned.fill(
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: TweenAnimationBuilder(
                      tween: Tween<double>(begin: 0, end: 1),
                      duration: Duration(seconds: 2),
                      curve: Curves.easeInOut,
                      builder: (context, value, child) {
                        return Transform.translate(
                          offset: Offset(0, 250 * value),
                          child: Container(
                            width: 250,
                            height: 2,
                            color: Colors.red,
                          ),
                        );
                      },
                    ),
                  ),
                ),
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
      setState(() {
        result = scanData;
      });
      await controller.pauseCamera();
    });
  }
  }


import 'package:flutter/material.dart';

import 'QRImage.dart';


class GenerateQRCode extends StatefulWidget {
  const GenerateQRCode({super.key});

  @override
  State<GenerateQRCode> createState() => _GenerateQRCodeState();
}

class _GenerateQRCodeState extends State<GenerateQRCode> {

  TextEditingController controller = TextEditingController();
  late String data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('QR Code'),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 80,
          ),
          Container(
            margin: const EdgeInsets.all(20),
            child: TextField(
              controller: controller,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Enter Your URL.."
              ),
            ),
          ),
          ElevatedButton(onPressed: () async {
            Navigator.push(
                context,
              MaterialPageRoute(
                builder: ((context) {
                 return QRImage(controller);
                }),
              ),
            );
          },
              child: const Text('GENERATE QR CODE')),
        ],
      ),
    );
  }

}

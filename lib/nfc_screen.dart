// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class NFC_Screen extends StatefulWidget {
  const NFC_Screen({super.key});

  @override
  State<NFC_Screen> createState() => _NFC_ScreenState();
}

class _NFC_ScreenState extends State<NFC_Screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Activate Ahlan Device',
          style: TextStyle(color: Colors.black87),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 20, left: 20),
            child: const Text(
              'To Begin Activation:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(20),
            child: Text(
             "1. Press 'Begin Activation' Button. \n"
              '\n'
              '2. Hold your Ahlan device near your phone until you hear the beep or the vibration.',
            ),
          ),
          const SizedBox(
            height: 60,
          ),
          Center(
            child: Lottie.asset('assets/images/nfc_animation.json',
                width: 360, height: 260, fit: BoxFit.none),
          ),
          const SizedBox(
            height: 60,
          ),
          Center(
            child: Container(
              height: 48,
              width: 350,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
              ),
              child: ElevatedButton(
                onPressed: () {
                  _nfcValidation();
                },
                style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Colors.black87),
                ),
                child: const Text(
                  'Begin Activation',
                  style: TextStyle(fontSize: 15),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const Padding(
            padding: EdgeInsets.all(20),
            child: Row(
              children: <Widget>[
                Text(
                  "Don't have a device?",
                  textAlign: TextAlign.left,
                  style: TextStyle(fontWeight: FontWeight.normal),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 6.0),
                ),
                Text(
                  "Get yours today.",
                  textDirection: TextDirection.ltr,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _nfcValidation() {}
}

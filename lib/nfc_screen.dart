// ignore_for_file: camel_case_types

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_nfc_kit/flutter_nfc_kit.dart';
import 'package:lottie/lottie.dart';
import 'package:nfc_manager/nfc_manager.dart';
import 'package:ndef/ndef.dart' as ndef;
import 'package:ndialog/ndialog.dart';


class NFC_Screen extends StatefulWidget {
  const NFC_Screen({super.key});

  @override
  State<NFC_Screen> createState() => _NFC_ScreenState();
}

class _NFC_ScreenState extends State<NFC_Screen>  {
  var availability =  FlutterNfcKit.nfcAvailability;

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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 20),
              child: const Text(
                'To Begin Activation:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 20),
              child: Text(
                "1. Press 'Begin Activation' Button. \n"
                '\n'
                '2. Hold your Ahlan device near your phone until you hear the beep or the vibration.',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            const SizedBox(
              height: 60,
            ),
            Lottie.asset('assets/images/nfc_animation.json',
                width: 285,
                height: 285,
                fit: BoxFit.none,
                alignment: Alignment.center),
            const SizedBox(
              height: 60,
            ),
            SizedBox(
                height: 48,
                width: 350,
                child: ElevatedButton(
                  onPressed: () {
                    // this is static url for test write
                    String url = 'https://app.ahlan.digital/view/wgoyhelm';
                    _nfcValidationToWrite(url);
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

            // Change a SizeBox() => Divider() its doing a same job.
            const Divider(),
            const Row(
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
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _nfcValidationToWrite( String url) async {
    //Always run this for ios but only once for android
    String statusMessege = 'Approach your Ahlan device';
    bool listenerRunning = false;
    if (listenerRunning == false) {
        _alert(context, statusMessege);
        //Update button states
        setState(() {
          listenerRunning = true;
        });
      }

      NfcManager.instance.startSession(
        onDiscovered: (NfcTag tag) async {
          bool succses = false;
          //Try to convert the raw tag data to NDEF
          final ndefTag = Ndef.from(tag);
          //If the data could be converted we will get an object
          if (ndefTag != null) {
            final ndefRecord = NdefRecord.createUri(Uri.parse(url));
            //Create a new ndef message with a single record
            final ndefMessage = NdefMessage([ndefRecord]);
            Navigator.of(context, rootNavigator: true).pop();
            try {
              await ndefTag.write(ndefMessage).showProgressDialog(context, message: const Text("PLease keep your device near your phone"), dismissable: false, blur: 0.5, title: const Text("Activating..."));
              succses = true;
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Activation Successful")));
            } catch (e) {
              statusMessege = "Writing failed, press 'Begin Activation' again";
              Navigator.of(context, rootNavigator: true).pop();
              _alert(
                context,
                statusMessege,
              );
            }
            //The NDEF Message was already parsed, if any
          }

          if (succses == false) {
            statusMessege = "Writing failed, press 'Begin Activation' again";
            //make dialog written failed
            Future.delayed(const Duration(milliseconds: 200), () {
              _alert(
                context,
                statusMessege,
              );
            });
          }
        },
      );
    }
  }


_alert(BuildContext context, String s) {
  // remove any dialog that is already showing
  AlertDialog alert = AlertDialog(
    title: Text(s),
    content: SizedBox(
      child: Lottie.asset(
        'assets/images/activation.json',
        width: 200,
        height: 200,
      ),
    ),
  );
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );

}

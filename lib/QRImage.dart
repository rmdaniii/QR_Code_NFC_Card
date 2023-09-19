
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:share_plus/share_plus.dart';

import 'nfc_screen.dart';

class QRImage  extends StatelessWidget {
  const QRImage (this.controller,{super.key });

  final TextEditingController controller;


  @override
  Widget build(BuildContext context) {
    final String data = controller.text ;
    final GlobalKey _qrKey = GlobalKey(debugLabel: 'QR');

    return Scaffold(
      appBar: AppBar(
        title: const Text('QR code'),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
              child: QrImageView(
                key: _qrKey,
                data: controller.text,
                size: 280,
                embeddedImageStyle: const QrEmbeddedImageStyle(
                  size: Size(100,100),
                ),
              )
          ),
          const SizedBox(
            height: 60,
          ),

          ElevatedButton(
              onPressed: ()  {
                //_shareMyQrCode(context, data);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: ((context) {
                      return const NFC_Screen();
                    }),
                  ),
                );

              },
              child: const Text(
                'Using NFC Protocol'
              )),
        ],
      ),
    );
  }

  //  void _shareMyQrCode(BuildContext context, String _qrKey) async {
  //   await Share.share(_qrKey,subject: 'My QR Code');
  // }

}


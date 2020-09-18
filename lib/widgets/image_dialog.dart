import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class ImageDialog extends StatelessWidget {
  final String qrData;
  ImageDialog({this.qrData});
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        width: 300,
        height: 280,
        child: QrImage(
          data: qrData,
        ),
      ),
    );
  }
}

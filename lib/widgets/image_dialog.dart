import 'dart:io';
import 'package:bon_appetit/shared/toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:bon_appetit/widgets/bottom_button.dart';
import 'package:screenshot/screenshot.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';

class ImageDialog extends StatefulWidget {
  final String qrData;
  ImageDialog({this.qrData});

  @override
  _ImageDialogState createState() => _ImageDialogState();
}

class _ImageDialogState extends State<ImageDialog> {
  @override
  Widget build(BuildContext context) {
    ScreenshotController screenshotController = ScreenshotController();

    return Dialog(
      child: Container(
        width: 400,
        height: 410,
        child: Column(
          children: [
            Screenshot(
              controller: screenshotController,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  QrImage(
                    data: widget.qrData,
                    backgroundColor: Colors.white,
                  ),
                  Container(
                    padding: EdgeInsets.only(bottom: 10),
                    color: Colors.white,
                    alignment: Alignment.center,
                    child: Text(
                      'Bon Appetit',
                      style: GoogleFonts.patuaOne(
                        fontSize: 25,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            BottomButton(
              onPressed: () async {
                bool result = await Permission.storage.isGranted;
                if (result) {
                  screenshotController.capture().then((File image) async {
                    await ImageGallerySaver.saveImage(image.readAsBytesSync());
                    ToastClass.buildShowToast("File Saved to Gallery");
                  }).catchError((onError) {
                    print(onError);
                  });
                  Navigator.pop(context);
                } else {
                  await Permission.storage.request();
                }
              },
              buttonText: 'Download',
            ),
          ],
        ),
      ),
    );
  }
}

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
        width: MediaQuery.of(context).size.width * 0.60,
        height: MediaQuery.of(context).size.height * 0.47,
        child: Column(
          children: [
            Expanded(
              flex: 4,
              child: Screenshot(
                controller: screenshotController,
                child: Column(
                  children: [
                    QrImage(
                      data: widget.qrData + 'food',
                      backgroundColor: Colors.white,
                    ),
                    Container(
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
            ),
            Expanded(
              child: BottomButton(
                onPressed: () async {
                  bool result = await Permission.storage.isGranted;
                  if (result) {
                    screenshotController.capture().then((value) async {
                      await ImageGallerySaver.saveImage(value);
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
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:bon_appetit/shared/constants.dart';
import 'package:bon_appetit/shared/toast.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileTile extends StatelessWidget {
  final String name;
  final String assetImage;
  final String emailId;
  final String githubUrl;
  final String linkedinUrl;

  ProfileTile(
      {this.name,
      this.assetImage,
      this.emailId,
      this.githubUrl,
      this.linkedinUrl});

  Future<void> launchUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      ToastClass.buildShowToast('Cannot launch url.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.blue,
                  backgroundImage: AssetImage(assetImage),
                ),
                SizedBox(
                  width: 20,
                ),
                Text(
                  name,
                  style: kTileTextStyle,
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FlatButton.icon(
                icon: Icon(
                  Icons.mail,
                  color: Color(0xFFd93025),
                ),
                onPressed: () async {
                  await launchUrl('mailto:' + emailId);
                },
                label: Text(''),
              ),
              FlatButton.icon(
                icon: Icon(
                  FontAwesomeIcons.github,
                  color: Color(0xFF24292e),
                ),
                onPressed: () async {
                  await launchUrl(githubUrl);
                },
                label: Text(''),
              ),
              FlatButton.icon(
                icon: Icon(
                  FontAwesomeIcons.linkedin,
                  color: Color(0xFF0077b5),
                ),
                onPressed: () async {
                  await launchUrl(linkedinUrl);
                },
                label: Text(''),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

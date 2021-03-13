import 'package:bon_appetit/shared/constants.dart';
import 'package:bon_appetit/widgets/profile_tile.dart';
import 'package:bon_appetit/widgets/topbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AboutUsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: TopBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            decoration: kUpperBoxDecoration,
            child: Column(
              children: [
                SizedBox(
                  height: 25.0,
                ),
                Text(
                  "About us",
                  style: kScreenHeadingTextStyle,
                ),
                SizedBox(
                  height: 20.0,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 25.0,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 25),
              child: ListView(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                children: [
                  ProfileTile(
                    name: 'Denish Ranpariya',
                    assetImage: 'images/denish.jpg',
                    linkedinUrl:
                        'https://www.linkedin.com/in/denish-ranpariya-428478167/',
                    githubUrl: 'https://github.com/Denish-Ranpariya',
                    emailId: 'ranpariyadenish1512@gmail.com',
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ProfileTile(
                    name: 'Manoj Padia',
                    assetImage: 'images/manoj.jpg',
                    linkedinUrl:
                        'https://www.linkedin.com/in/manoj-padiya-9724451a2/',
                    githubUrl: 'https://github.com/ManojPadia',
                    emailId: 'padia.manoj@gmail.com',
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ProfileTile(
                    name: 'Jaimin Rana',
                    assetImage: 'images/jaimin.jpg',
                    linkedinUrl:
                        'https://www.linkedin.com/in/jaimin-rana-2bb531186/',
                    githubUrl: 'https://github.com/Jaiminrana',
                    emailId: 'jaiminrana8080@gmail.com',
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

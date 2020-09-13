import 'package:bon_appetit/services/auth_service.dart';
import 'package:bon_appetit/shared/loading.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

import 'add_category_screen.dart';

class CategoryScreen extends StatefulWidget {
  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  bool isLoading = false;

  bool _disposed = false;



  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }

  String qrData =
      "https://play.google.com/store/apps/details?id=com.whatsapp&hl=en";

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Loading()
        : Scaffold(
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: FloatingActionButton(
              elevation: 1,
              backgroundColor: Color(0xff5ab190),
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) => AddCategory(),
                );
              },
              child: Icon(Icons.add),
            ),
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Color(0xFFc9e3db),
              elevation: 0,
              title: Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  'Bon Appetit',
                  style: TextStyle(color: Colors.grey[800]),
                ),
              ),
              actions: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IconButton(
                      padding: EdgeInsets.all(0.0),
                      iconSize: 60.0,
                      icon: QrImage(
                        data: qrData,
                      ),
                      onPressed: () {},
                    ),
                    FlatButton.icon(
                      padding: const EdgeInsets.only(top: 8.0),
                      label: Text('logout'),
                      icon: Icon(
                        Icons.exit_to_app,
                        color: Colors.grey[800],
                      ),
                      onPressed: () async {
                        try {
                          setState(() {
                            isLoading = true;
                          });
                          await AuthService().logout();
                          if (!_disposed) {
                            setState(() {
                              isLoading = false;
                            });
                          }
                        } catch (e) {
                          print(e.toString());
                          setState(() {
                            isLoading = false;
                          });
                        }
                      },
                    ),
                  ],
                ),
              ],
            ),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Color(0xFFc9e3db),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(25.0),
                      bottomRight: Radius.circular(25.0),
                    ),
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 25.0,
                      ),
                      Text(
                        "Category",
                        style: TextStyle(
                          color: Colors.grey[800],
                          fontWeight: FontWeight.w500,
                          fontSize: 20.0,
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                ListTile(
                  leading: SizedBox(
                    height: 40.0,
                    width: 5.0,
                    child: Container(
                      color: Colors.teal,
                      child: Text(''),
                    ),
                  ),
                  title: Text(
                    'Manoj',
                    style: TextStyle(fontSize: 20.0),
                  ),
                ),
                // Container(
                //   padding: EdgeInsets.symmetric(horizontal: 25.0,vertical: 0.0),
                //   height: 60.0,
                //   child: Row(
                //     children: [
                //
                //       Container(
                //         padding: EdgeInsets.all(16.0),
                //
                //       ),
                //     ],
                //   ),
                // ),
              ],
            ),
          );
  }
}

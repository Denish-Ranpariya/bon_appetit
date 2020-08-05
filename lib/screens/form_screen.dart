import 'package:bon_appetit/services/auth_service.dart';
import 'package:bon_appetit/shared/loading.dart';
import 'package:flutter/material.dart';

class FormScreen extends StatefulWidget {
  @override
  _FormScreenState createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Loading()
        : Scaffold(
            appBar: AppBar(
              title: Text('Bon Appetit'),
              actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.person),
                  onPressed: () async {
                    try {
                      setState(() {
                        isLoading = true;
                      });
                      await AuthService().logout();
                      setState(() {
                        isLoading = false;
                      });
                    } catch (e) {
                      print(e.toString());
                    }
                  },
                ),
              ],
            ),
            body: Container(
              child: Text('this is form screen'),
            ),
          );
  }
}

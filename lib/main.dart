import 'package:bon_appetit/screens/wrapper.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(BonAppetit());
}

class BonAppetit extends StatelessWidget {
  const BonAppetit({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Wrapper(),
    );
  }
}

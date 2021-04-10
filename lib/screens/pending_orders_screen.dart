import 'package:bon_appetit/services/database_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PendingOrderScreen extends StatefulWidget {
  @override
  _PendingOrderScreenState createState() => _PendingOrderScreenState();
}

class _PendingOrderScreenState extends State<PendingOrderScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.grey[700]),
        backgroundColor: Color(0xFFc9e3db),
        elevation: 0,
        title: Text(
          'Pending orders',
          style: TextStyle(color: Colors.grey[800]),
        ),
      ),
      // body: Container(
      //   child: FutureBuilder(
      //     future: DatabaseService(uid: FirebaseAuth.instance.currentUser.uid).getPendingOrderCollectionDocuments(),
      //     builder: (context, snapshot){
      //       if(snapshot.hasData){
      //         List l = snapshot.data;
      //         return ListView.builder(
      //             itemCount: l.length,
      //             itemBuilder: (context, index){
      //               return Text(l[index]);
      //             }
      //         );
      //       }else{
      //         return Container(
      //           child: Text('no data'),
      //         );
      //       }
      //     },
      //   ),
      // ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await DatabaseService(uid: FirebaseAuth.instance.currentUser.uid).getPendingOrderCollectionDocuments();
        },
      ),
    );
  }
}

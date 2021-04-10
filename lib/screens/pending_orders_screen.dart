import 'package:bon_appetit/models/Order.dart';
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
      body: StreamBuilder<List<Order>>(
        stream: DatabaseService(uid: FirebaseAuth.instance.currentUser.uid).getPendingOrdersList,
        builder: (context, snapshot){
          if(snapshot.data != null){
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, outer_index){
                // return Text(
                //   snapshot.data[outer_index].name
                // );
                return Column(
                  children: [
                    Text(
                      snapshot.data[outer_index].name,
                    ),
                    // ListView.builder(
                    //   itemCount: snapshot.data[outer_index].orderedFoodItemList.length,
                    //   itemBuilder: ,
                    // ),
                  ],
                );
              },
            );
          }else{
            return Text('no data');
          }

        },
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () async {
      //     await DatabaseService(uid: FirebaseAuth.instance.currentUser.uid).getPendingOrderCollectionDocuments();
      //   },
      // ),
    );
  }
}

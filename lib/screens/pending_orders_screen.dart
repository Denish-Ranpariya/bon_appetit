import 'package:bon_appetit/models/Order.dart';
import 'package:bon_appetit/services/database_service.dart';
import 'package:bon_appetit/shared/constants.dart';
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
        stream: DatabaseService(uid: FirebaseAuth.instance.currentUser.uid)
            .getPendingOrdersList,
        builder: (context, snapshot) {
          if (snapshot.data != null) {
            List<Order> orders = snapshot.data;
            return ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 15.0,vertical: 10.0),
              itemCount: orders.length,
              itemBuilder: (context, outerIndex) {
                return Card(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18.0,vertical: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Ordered by : "+orders[outerIndex].name,
                          style: kTileTextStyle,
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        Center(
                          child: Text(
                            "(Order id : "+orders[outerIndex].orderId+")",
                            style: kTileTextStyle.copyWith(
                              fontSize: 14.0,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        Divider(
                          thickness: 2.0,
                        ),
                        Text(
                          "Items List :",
                          style: kTileTextStyle,
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection(FirebaseAuth.instance.currentUser.uid +
                                  'pendingorders')
                              .doc(orders[outerIndex].orderId)
                              .collection('ordered_fooditems_collection')
                              .snapshots(),
                          builder: (context, innerSnapshot) {
                            if (innerSnapshot.hasData) {
                              return ListView.builder(
                                shrinkWrap: true,
                                itemCount: innerSnapshot.data.docs.length,
                                itemBuilder: (context, index) {
                                  return Row(
                                    children: [
                                      Text(
                                        innerSnapshot.data.docs[index]
                                            .get('fooditem_name')
                                            .toString(),
                                        style: kTileTextStyle.copyWith(
                                          fontSize: 16.0
                                        ),
                                      ),
                                      Spacer(),
                                      Text(innerSnapshot.data.docs[index]
                                          .get('fooditem_quantity')
                                          .toString()),
                                      SizedBox(
                                        width: 5.0,
                                      ),
                                      Text("x"),
                                      SizedBox(
                                        width: 5.0,
                                      ),
                                      Text(innerSnapshot.data.docs[index]
                                          .get('fooditem_price')
                                          .toString()),


                                    ],
                                  );
                                },
                              );
                            } else {
                              return CircularProgressIndicator();
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          } else {
            return CircularProgressIndicator();
          }
        },
      ),
    );
  }
}

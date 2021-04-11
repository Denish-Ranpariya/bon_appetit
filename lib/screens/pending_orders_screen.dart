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
        stream: DatabaseService(uid: FirebaseAuth.instance.currentUser.uid)
            .getPendingOrdersList,
        builder: (context, snapshot) {
          if (snapshot.data != null) {
            List<Order> orders = snapshot.data;
            return ListView.builder(
              itemCount: orders.length,
              itemBuilder: (context, outerIndex) {
                // return Text(
                //   snapshot.data[outer_index].name
                // );
                return Column(
                  children: [
                    Text(
                      orders[outerIndex].name,
                    ),
                    Text(
                      orders[outerIndex].orderId,
                    ),
                    // StreamBuilder<List<OrderedFoodItem>>(
                    //   stream: orders[outerIndex].orderedFoodItemList,
                    //   builder: (context,innerSnapshot){
                    //     if(innerSnapshot.hasData){
                    //       List<OrderedFoodItem> foodItemList = innerSnapshot.data;
                    //       return ListView.builder(
                    //         shrinkWrap: true,
                    //         itemCount: foodItemList.length,
                    //         itemBuilder: (context, innerIndex) {
                    //           return Column(
                    //             children: [
                    //               Text(
                    //                   foodItemList[innerIndex].foodItemName
                    //               ),
                    //               Text(
                    //                   foodItemList[innerIndex].foodItemPrice
                    //               ),
                    //               Text(
                    //                   foodItemList[innerIndex].foodItemQuantity
                    //               ),
                    //             ],
                    //           );
                    //         },
                    //       );
                    //     } else {
                    //       return Text('no data');
                    //     }
                    //   },
                    // ),
                    StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection(FirebaseAuth.instance.currentUser.uid +
                              'pendingorders')
                          .doc(orders[outerIndex].orderId)
                          .collection('ordered_fooditems_collection')
                          .snapshots(),
                      builder: (context, innerSnapshot) {
                        if (innerSnapshot.hasData) {
                          // return Text(innerSnapshot.data.docs.map((document){
                          //   document.get['fooditem_name'].toString();
                          // }));
                          return ListView.builder(
                            shrinkWrap: true,
                            itemCount: innerSnapshot.data.docs.length,
                            itemBuilder: (context, index) {
                              return Column(
                                children: [
                                  Text(
                                    innerSnapshot.data.docs[index]
                                        .get('fooditem_name')
                                        .toString(),
                                    // style: TextStyle(
                                    //     fontSize: 20,
                                    //     fontWeight: FontWeight.bold),
                                  ),
                                  Text(innerSnapshot.data.docs[index]
                                      .get('fooditem_price')
                                      .toString()),
                                  Text(innerSnapshot.data.docs[index]
                                      .get('fooditem_quantity')
                                      .toString()),
                                ],
                              );
                            },
                          );
                        } else {
                          return Text('No data');
                        }
                      },
                    ),
                  ],
                );
              },
            );
          } else {
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

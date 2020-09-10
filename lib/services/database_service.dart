import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});
  final CollectionReference restaurantCollection =
      Firestore.instance.collection('restaurants');

  Future updateUserData(String restaurantName, String restaurantOwnerName,
      String phoneNumber, String restaurantAddress, String city) async {
    return await restaurantCollection.document(uid).setData({
      'restaurant_name': restaurantName,
      'restaurant_owner_name': restaurantOwnerName,
      'phone_number': phoneNumber,
      'restaurant_address': restaurantAddress,
      'city': city,
      'is_registered': 'true',
    });
  }

  Future<String> getRegisterStatus() async {
    return await restaurantCollection.document(uid).get().then((value) {
      return value.data['is_registered'];
    });
  }
}

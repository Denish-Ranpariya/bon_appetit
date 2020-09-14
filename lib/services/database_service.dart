import 'package:bon_appetit/models/category.dart';
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
      //'restaurant_category': uid.toString() + 'category'
    });
  }

  Future<String> getRegisterStatus() async {
    return await restaurantCollection.document(uid).get().then((value) {
      if (value.exists) {
        return value.data['is_registered'];
      }
      return 'false';
    });
  }

  Future<void> insertCategoryData(String id, String name) async {
    String categoryCollectionName = uid + 'category';
    final CollectionReference categoryCollection =
        Firestore.instance.collection(categoryCollectionName);
    return await categoryCollection.document(id).setData({
      'category_id': id,
      'category_name': name,
    });
  }

  //return list of category
  List<Category> _categoryListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      //print(doc.data);
      return Category(
          categoryId: doc.data['category_id'] ?? null,
          categoryName: doc.data['category_name'] ?? null);
    }).toList();
  }

  //stream of category
  Stream<List<Category>> get categories {
    String categoryCollectionName = uid + 'category';
    final CollectionReference categoryCollection =
        Firestore.instance.collection(categoryCollectionName);
    return categoryCollection.snapshots().map(_categoryListFromSnapshot);
  }
}

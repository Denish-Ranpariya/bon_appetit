import 'package:bon_appetit/models/category.dart';
import 'package:bon_appetit/models/food_item.dart';
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
          categoryId: doc.data['category_id'],
          categoryName: doc.data['category_name']);
    }).toList();
  }

  //stream of category
  Stream<List<Category>> get categories {
    String categoryCollectionName = uid + 'category';
    final CollectionReference categoryCollection =
        Firestore.instance.collection(categoryCollectionName);
    return categoryCollection.snapshots().map(_categoryListFromSnapshot);
  }

  // delete category
  //todo: also delete food items of particular category
  Future<void> deleteCategory(String documentId) async {
    String categoryCollectionName = uid + 'category';
    final CollectionReference categoryCollection =
        Firestore.instance.collection(categoryCollectionName);
    await categoryCollection.document(documentId).delete();
  }

  Future<void> insertFoodItemData(String id, String name, String price,
      String category, String description) async {
    String foodItemCollectionName = uid + 'food';
    final CollectionReference foodItemCollection =
        Firestore.instance.collection(foodItemCollectionName);
    return await foodItemCollection.document(id).setData({
      'fooditem_id': id,
      'fooditem_name': name,
      'fooditem_price': price,
      'fooditem_category': category,
      'fooditem_description': description
    });
  }

  //stream of food items
  Stream<List<FoodItem>> get foodItems {
    String foodItemCollectionName = uid + 'food';
    final CollectionReference foodItemCollection =
        Firestore.instance.collection(foodItemCollectionName);
    return foodItemCollection.snapshots().map(_foodItemsListFromSnapshot);
  }

  //mapping of food items
  List<FoodItem> _foodItemsListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      //print(doc.data);
      return FoodItem(
          foodItemId: doc.data['fooditem_id'],
          foodItemName: doc.data['fooditem_name'],
          foodItemPrice: doc.data['fooditem_price'],
          foodItemCategory: doc.data['fooditem_category'],
          foodItemDescription: doc.data['fooditem_description']);
    }).toList();
  }

  //delete food item
  Future<void> deleteFoodItem(String documentId) async {
    String foodItemCollectionName = uid + 'food';
    final CollectionReference foodItemCollection =
        Firestore.instance.collection(foodItemCollectionName);
    await foodItemCollection.document(documentId).delete();
  }
}

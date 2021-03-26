import 'dart:io';

import 'package:bon_appetit/models/category.dart';
import 'package:bon_appetit/models/food_item.dart';
import 'package:bon_appetit/models/restaurant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class DatabaseService {

  final String uid;

  DatabaseService({this.uid});

  final CollectionReference restaurantCollection =
      FirebaseFirestore.instance.collection('restaurants');

  //insert the data of restaurant
  Future updateUserData(String restaurantName, String restaurantOwnerName,
      String phoneNumber, String restaurantAddress, String city) async {
    return await restaurantCollection.doc(uid).set({
      'restaurant_name': restaurantName,
      'restaurant_owner_name': restaurantOwnerName,
      'phone_number': phoneNumber,
      'restaurant_address': restaurantAddress,
      'city': city,
      'is_registered': 'true',
    });
  }

  // to get the status of restaurant registered or not
  Future<String> get getRegisterStatus async {
    return await restaurantCollection.doc(uid).get().then((value) {
      if (value.exists) {
        return value.get('is_registered');
      }
      return null;
    });
  }

  // to insert and update the category info.
  Future<void> insertCategoryData(String id, String name) async {
    String categoryCollectionName = uid + 'category';
    final CollectionReference categoryCollection =
        FirebaseFirestore.instance.collection(categoryCollectionName);
    return await categoryCollection.doc(id).set({
      'category_id': id,
      'category_name': name,
    });
  }

  //mapping of data from firestore to category modal
  List<Category> _categoryListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Category(
          categoryId: doc.get('category_id'),
          categoryName: doc.get('category_name')
      );
    }).toList();
  }

  //stream of category
  Stream<List<Category>> get categories {
    String categoryCollectionName = uid + 'category';
    final CollectionReference categoryCollection =
        FirebaseFirestore.instance.collection(categoryCollectionName);
    return categoryCollection.snapshots().map(_categoryListFromSnapshot);
  }

  // delete category
  Future<void> deleteCategory(String documentId) async {
    String categoryCollectionName = uid + 'category';
    final CollectionReference categoryCollection =
        FirebaseFirestore.instance.collection(categoryCollectionName);
    await categoryCollection.doc(documentId).delete();
  }

  // to insert or update the data of food item to firestore
  Future<void> insertFoodItemData(String id, String name, String price,
      String category, String description, String type,String foodItemImageUrl) async {
    String foodItemCollectionName = uid + 'food';
    final CollectionReference foodItemCollection =
        FirebaseFirestore.instance.collection(foodItemCollectionName);
    return await foodItemCollection.doc(id).set({
      'fooditem_id': id,
      'fooditem_name': name,
      'fooditem_price': price,
      'fooditem_category': category,
      'fooditem_description': description,
      'fooditem_type': type,
      'fooditem_image' : foodItemImageUrl
    });
  }

  //stream of food items
  Stream<List<FoodItem>> get foodItems {
    String foodItemCollectionName = uid + 'food';
    final CollectionReference foodItemCollection =
        FirebaseFirestore.instance.collection(foodItemCollectionName);
    return foodItemCollection.snapshots().map(_foodItemsListFromSnapshot);
  }

  //to get the data form firestore to fooditem model by mapping
  List<FoodItem> _foodItemsListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return FoodItem(
        foodItemId: doc.get('fooditem_id'),
        foodItemName: doc.get('fooditem_name'),
        foodItemPrice: doc.get('fooditem_price'),
        foodItemCategory: doc.get('fooditem_category'),
        foodItemDescription: doc.get('fooditem_description'),
        foodItemType: doc.get('fooditem_type'),
        foodItemImageUrl: doc.get('fooditem_image')
      );
    }).toList();
  }

  //delete food item
  Future<void> deleteFoodItem(String documentId) async {
    String foodItemCollectionName = uid + 'food';
    final CollectionReference foodItemCollection =
        FirebaseFirestore.instance.collection(foodItemCollectionName);
    await foodItemCollection.doc(documentId).delete();
  }

  //Edit food item category in fooditem when category name is changed
  Future<void> editFoodItemCategory(
      String oldCategoryName, String newCategoryName) async {
    String foodItemCollectionName = uid + 'food';
    final CollectionReference foodItemCollection =
        FirebaseFirestore.instance.collection(foodItemCollectionName);
    foodItemCollection
        .where('fooditem_category', isEqualTo: oldCategoryName)
        .get()
        .then((value) async {
      value.docs.forEach((element) async {
        await foodItemCollection
            .doc(element.id)
            .update({'fooditem_category': newCategoryName});
      });
    });
  }

  //delete all the fooditem when food item category deleted
  Future<void> deleteFoodItemCategory(String categoryName) async {
    String foodItemCollectionName = uid + 'food';
    final CollectionReference foodItemCollection =
        FirebaseFirestore.instance.collection(foodItemCollectionName);
    foodItemCollection
        .where('fooditem_category', isEqualTo: categoryName)
        .get()
        .then((value) async {
      value.docs.forEach((element) async {
        await foodItemCollection.doc(element.id).delete();
      });
    });
  }

  // //get the name of restaurant
  // Future<String> get getRestaurantName async {
  //   return await restaurantCollection.document(uid).get().then((value) {
  //     if (value.exists) {
  //       return value.data['restaurant_name'];
  //     }
  //     return null;
  //   });
  // }
  //
  Stream<Restaurant> get restaurantData {
    return FirebaseFirestore.instance
        .collection('restaurants')
        .doc(uid)
        .snapshots()
        .map(_restaurantDataFromSnapshot);
  }

  Restaurant _restaurantDataFromSnapshot(DocumentSnapshot snapshot) {
    return Restaurant(
        restaurantName: snapshot.get('restaurant_name'),
        restaurantOwnerName: snapshot.get('restaurant_owner_name'),
        restaurantPhoneNumber: snapshot.get('phone_number'),
        restaurantAddress: snapshot.get('restaurant_address'),
        restaurantCity: snapshot.get('city')
    );
  }

  //upload image to firebase storage
  static Future<String> uploadImageToFirebaseStorage(String fileName, File filePath) async {
    final ref = FirebaseStorage.instance
        .ref('images/')
        .child(fileName);
    await ref.putFile(filePath);

    final fileUrl = await ref.getDownloadURL();
    print(fileUrl);
    return fileUrl;
  }


}

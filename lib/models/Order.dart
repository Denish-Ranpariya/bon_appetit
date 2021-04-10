import 'package:bon_appetit/models/ordered_food_item.dart';

class Order{
  Stream<List<OrderedFoodItem>> orderedFoodItemList;
  String name;

  Order({this.orderedFoodItemList, this.name});
}
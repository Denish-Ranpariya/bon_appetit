import 'package:bon_appetit/models/category.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'category_tile.dart';

class CategoryList extends StatefulWidget {
  @override
  _CategoryListState createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  @override
  Widget build(BuildContext context) {
    final categories = Provider.of<List<Category>>(context) ?? [];
    categories.sort((a, b) => a.categoryName.compareTo(b.categoryName));
    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: categories.length,
      itemBuilder: (context, index) {
        return CategoryTile(category: categories[index]);
      },
    );
  }
}

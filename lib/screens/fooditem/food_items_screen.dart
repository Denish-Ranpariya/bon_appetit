import 'package:bon_appetit/models/category.dart';
import 'package:bon_appetit/models/food_item.dart';
import 'package:bon_appetit/screens/fooditem/add_food_item.dart';
import 'package:bon_appetit/services/auth_service.dart';
import 'package:bon_appetit/services/database_service.dart';
import 'package:bon_appetit/shared/constants.dart';
import 'package:bon_appetit/shared/toast.dart';
import 'package:bon_appetit/widgets/alert_dialog_box.dart';
import 'package:bon_appetit/widgets/image_dialog.dart';
import 'package:bon_appetit/widgets/side_drawer.dart';
import 'package:bon_appetit/widgets/topbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'food_item_list.dart';

class FoodItemsScreen extends StatefulWidget {
  final Function toggleFunction;

  FoodItemsScreen({this.toggleFunction});

  @override
  _FoodItemsScreenState createState() => _FoodItemsScreenState();
}

class _FoodItemsScreenState extends State<FoodItemsScreen> {
  bool isLoading = false;

  bool _disposed = false;

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Future<bool> showAlertBox() {
      return showDialog(
        context: context,
        builder: (context) => AlertDialogBox(
          textMessage: 'Do you really want to logout?',
        ),
      );
    }

    String qrData = Provider.of<FirebaseUser>(context).uid.toString();
    final categories = Provider.of<List<Category>>(context) ?? [];
    return StreamProvider<List<FoodItem>>.value(
      value: DatabaseService(
              uid: Provider.of<FirebaseUser>(context, listen: false).uid)
          .foodItems,
      child: Scaffold(
        drawer: Container(
          width: MediaQuery.of(context).size.width * 0.60,
          child: SideDrawer(
            onLogout: () async {
              bool result = await showAlertBox();
              if (result ?? false) {
                try {
                  setState(() {
                    isLoading = true;
                  });
                  await AuthService().logout();
                  if (!_disposed) {
                    setState(() {
                      isLoading = false;
                    });
                  }
                  ToastClass.buildShowToast('Logged out');
                } catch (e) {
                  print(e.toString());
                  setState(() {
                    isLoading = false;
                  });
                }
              }
            },
            onPressedQrCode: () async {
              await showDialog(
                context: context,
                builder: (context) {
                  return ImageDialog(
                    qrData: qrData,
                  );
                },
              );
            },
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton(
          elevation: 1,
          backgroundColor: Color(0xff5ab190),
          onPressed: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              builder: (context) =>
                  AddFoodItem(categories: categories, isAdded: false),
            );
          },
          child: Icon(Icons.add),
        ),
        backgroundColor: Colors.white,
        appBar: TopBar(
          iconData: Icons.compare_arrows,
          iconTitle: 'Categories',
          onPressed: widget.toggleFunction,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              decoration: kUpperBoxDecoration,
              child: Column(
                children: [
                  SizedBox(
                    height: 25.0,
                  ),
                  Text(
                    "Food Items",
                    style: kScreenHeadingTextStyle,
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 6.0,
                        backgroundColor: Colors.green,
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      Text('Veg.'),
                      SizedBox(
                        width: 10.0,
                      ),
                      CircleAvatar(
                        radius: 6.0,
                        backgroundColor: Colors.red,
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      Text('Non Veg.'),
                    ],
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                ],
              ),
            ),
            Expanded(
              child: FoodItemList(),
            ),
          ],
        ),
      ),
    );
  }
}

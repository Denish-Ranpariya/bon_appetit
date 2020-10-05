import 'package:bon_appetit/models/category.dart';
import 'package:bon_appetit/services/auth_service.dart';
import 'package:bon_appetit/services/database_service.dart';
import 'package:bon_appetit/shared/constants.dart';
import 'package:bon_appetit/shared/loading.dart';
import 'package:bon_appetit/shared/toast.dart';
import 'package:bon_appetit/widgets/alert_dialog_box.dart';
import 'package:bon_appetit/widgets/image_dialog.dart';
import 'package:bon_appetit/widgets/side_drawer.dart';
import 'package:bon_appetit/widgets/topbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'add_category_screen.dart';
import 'category_list.dart';

class CategoryScreen extends StatefulWidget {
  final Function toggleFunction;

  CategoryScreen({this.toggleFunction});
  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  bool isLoading = false;

  bool _disposed = false;

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String qrData = Provider.of<FirebaseUser>(context).uid.toString();
    Future<bool> showAlertBox() {
      return showDialog(
        context: context,
        builder: (context) => AlertDialogBox(
          textMessage: 'Do you really want to logout?',
        ),
      );
    }

    return isLoading
        ? Loading()
        : StreamProvider<List<Category>>.value(
            value: DatabaseService(uid: Provider.of<FirebaseUser>(context).uid)
                .categories,
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
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerFloat,
              floatingActionButton: FloatingActionButton(
                elevation: 1,
                backgroundColor: Color(0xff5ab190),
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    builder: (context) => AddCategory(isAdded: false),
                  );
                },
                child: Icon(Icons.add),
              ),
              backgroundColor: Colors.white,
              appBar: TopBar(
                iconData: Icons.compare_arrows,
                iconTitle: 'Food Items',
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
                        Text(
                          "Food Category",
                          style: kScreenHeadingTextStyle,
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Expanded(child: CategoryList()),
                ],
              ),
            ),
          );
  }
}

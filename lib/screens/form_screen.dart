import 'package:bon_appetit/screens/toggle_wrapper.dart';
import 'package:bon_appetit/services/auth_service.dart';
import 'package:bon_appetit/services/database_service.dart';
import 'package:bon_appetit/shared/constants.dart';
import 'package:bon_appetit/shared/loading.dart';
import 'package:bon_appetit/shared/toast.dart';
import 'package:bon_appetit/widgets/alert_dialog_box.dart';
import 'package:bon_appetit/widgets/bottom_button.dart';
import 'package:bon_appetit/widgets/custom_text_field_widget.dart';
import 'package:bon_appetit/widgets/topbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class FormScreen extends StatefulWidget {
  @override
  _FormScreenState createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  String restaurantName = '',
      ownerName = '',
      phoneNumber = '',
      address = '',
      city = '';
  bool isLoading = false;
  final formKey = GlobalKey<FormState>();

  bool _disposed = false;

  bool isRegistered = false;

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

    final user = Provider.of<FirebaseUser>(context);
    return isLoading
        ? Loading()
        : isRegistered
            ? ToggleWrapper()
            : Scaffold(
                appBar: TopBar(
                  iconData: Icons.exit_to_app,
                  iconTitle: 'logout',
                  onPressed: () async {
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
                ),
                backgroundColor: Colors.white,
                body: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        flex: 2,
                        child: Container(
                          decoration: kUpperBoxDecoration,
                          child: Column(
                            children: [
                              SizedBox(
                                height: 25.0,
                              ),
                              Expanded(
                                child: SvgPicture.asset(
                                  "images/cafe.svg",
                                  height: 150.0,
                                ),
                              ),
                              SizedBox(
                                height: 20.0,
                              ),
                              Text("Register Your Restaurant",
                                  style: kScreenHeadingTextStyle),
                              SizedBox(
                                height: 20.0,
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Expanded(
                        flex: 3,
                        child: ListView(
                          children: [
                            CustomTextField(
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Enter the restaurant name.';
                                }
                                return null;
                              },
                              image: "storefront.svg",
                              hintText: "Restaurant Name",
                              maxLine: 1,
                              onChange: (value) {
                                setState(() {
                                  restaurantName = value;
                                });
                              },
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            CustomTextField(
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Enter the owner name.';
                                }
                                return null;
                              },
                              image: "person.svg",
                              hintText: "Owner Name",
                              maxLine: 1,
                              onChange: (value) {
                                setState(() {
                                  ownerName = value;
                                });
                              },
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            CustomTextField(
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Enter the phone number.';
                                } else if (value.length != 10) {
                                  return 'Enter valid phone number';
                                }
                                return null;
                              },
                              image: "phone.svg",
                              hintText: "Phone Number",
                              maxLine: 1,
                              onChange: (value) {
                                setState(() {
                                  phoneNumber = value;
                                });
                              },
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            CustomTextField(
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Enter the restaurant address.';
                                }
                                return null;
                              },
                              image: "apartment.svg",
                              hintText: "Restaurant Address",
                              onChange: (value) {
                                setState(() {
                                  address = value;
                                });
                              },
                              maxLine: 5,
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            CustomTextField(
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Enter the city.';
                                }
                                return null;
                              },
                              image: "business.svg",
                              hintText: "City",
                              maxLine: 1,
                              onChange: (value) {
                                setState(() {
                                  city = value;
                                });
                              },
                            ),
                            BottomButton(
                              buttonText: 'Register Your Restaurant',
                              onPressed: () async {
                                if (formKey.currentState.validate()) {
                                  setState(() {
                                    isLoading = true;
                                  });
                                  await DatabaseService(uid: user.uid)
                                      .updateUserData(restaurantName, ownerName,
                                          phoneNumber, address, city);

                                  setState(() {
                                    isRegistered = true;
                                    isLoading = false;
                                  });
                                  ToastClass.buildShowToast(
                                      'Registration Successful');
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
  }
}

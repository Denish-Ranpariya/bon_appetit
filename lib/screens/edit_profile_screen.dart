import 'package:bon_appetit/models/restaurant.dart';
import 'package:bon_appetit/services/auth_service.dart';
import 'package:bon_appetit/services/connectivity_service.dart';
import 'package:bon_appetit/services/database_service.dart';
import 'package:bon_appetit/shared/constants.dart';
import 'package:bon_appetit/shared/loading.dart';
import 'package:bon_appetit/shared/toast.dart';
import 'package:bon_appetit/widgets/alert_dialog_box.dart';
import 'package:bon_appetit/widgets/bottom_button.dart';
import 'package:bon_appetit/widgets/custom_text_field_widget.dart';
import 'package:bon_appetit/widgets/topbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class EditProfileScreen extends StatefulWidget {
  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  String restaurantName,
      ownerName,
      phoneNumber,
      address,
      city;
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
  Widget build(BuildContext buildContext) {
    Future<bool> showAlertBox() {
      return showDialog(
        context: context,
        builder: (context) => AlertDialogBox(
          textMessage: 'Do you really want to logout?',
        ),
      );
    }

    final user = FirebaseAuth.instance.currentUser.uid;

    return isLoading
        ? Loading()
        : StreamBuilder<Restaurant>(
            stream: DatabaseService(uid: user).restaurantData,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Scaffold(
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
                                Text("Edit Your Restaurant Details",
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
                                initialValue: snapshot.data.restaurantName,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Enter the restaurant name.';
                                  }
                                  return null;
                                },
                                icon: FontAwesomeIcons.store,
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
                                initialValue: snapshot.data.restaurantOwnerName,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Enter the owner name.';
                                  }
                                  return null;
                                },
                                icon: Icons.person,
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
                                initialValue: snapshot.data.restaurantPhoneNumber,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Enter the phone number.';
                                  } else if (value.length != 10) {
                                    return 'Enter valid phone number';
                                  }
                                  return null;
                                },
                                icon: Icons.phone,
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
                                initialValue: snapshot.data.restaurantAddress,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Enter the restaurant address.';
                                  }
                                  return null;
                                },
                                icon: FontAwesomeIcons.building,
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
                                initialValue: snapshot.data.restaurantCity,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Enter the city.';
                                  }
                                  return null;
                                },
                                icon: Icons.location_city,
                                hintText: "City",
                                maxLine: 1,
                                onChange: (value) {
                                  setState(() {
                                    city = value;
                                  });
                                },
                              ),
                              BottomButton(
                                buttonText: 'Update Restaurant Details',
                                onPressed: () async {
                                  if (formKey.currentState.validate()) {
                                    bool result = await ConnectivityService
                                        .getConnectivityStatus();
                                    if (result) {
                                      setState(() {
                                        isLoading = true;
                                      });

                                      setState(() {
                                        if(snapshot.hasData){
                                          restaurantName = restaurantName ??
                                              snapshot.data.restaurantName;
                                          ownerName = ownerName ??
                                              snapshot.data.restaurantOwnerName;
                                          phoneNumber = phoneNumber ??
                                              snapshot.data.restaurantPhoneNumber;
                                          address = address ??
                                              snapshot.data.restaurantAddress;
                                          city = city ??
                                              snapshot.data.restaurantCity;
                                        }
                                      });
                                      await DatabaseService(uid: user)
                                          .updateUserData(
                                        restaurantName,
                                        ownerName,
                                        phoneNumber,
                                        address,
                                        city,
                                      );

                                      setState(() {
                                        isRegistered = true;
                                        isLoading = false;
                                      });
                                      ToastClass.buildShowToast(
                                          'Details updated successfully');
                                      Navigator.pop(buildContext);
                                    } else {
                                      ToastClass.buildShowToast(
                                          'No internet connection');
                                      Navigator.pop(buildContext);
                                    }
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
              } else {
                return Loading();
              }
            });
  }
}

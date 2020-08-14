//import 'package:bon_appetit/services/auth_service.dart';
import 'package:bon_appetit/services/database_service.dart';
import 'package:bon_appetit/shared/loading.dart';
import 'package:bon_appetit/widgets/custom_text_field_widget.dart';
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
  String restaurantName = '', ownerName = '', phoneNumber = '', address = '', city = '';
  bool isLoading = false;
  final formKey = GlobalKey<FormState>();
  
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<FirebaseUser>(context);
    return isLoading
        ? Loading()
        : Scaffold(
//            appBar: AppBar(
//              title: Text('Bon Appetit'),
//              actions: <Widget>[
//                IconButton(
//                  icon: Icon(Icons.person),
//                  onPressed: () async {
//                    try {
//                      setState(() {
//                        isLoading = true;
//                      });
//                      await AuthService().logout();
//                      setState(() {
//                        isLoading = false;
//                      });
//                    } catch (e) {
//                      print(e.toString());
//                    }
//                  },
//                ),
//              ],
//            ),
            backgroundColor: Colors.white,
            body: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    flex: 2,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(0xFFc9e3db),
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(25.0),
                          bottomRight: Radius.circular(25.0),
                        ),
                      ),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 30.0,
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
                          Text(
                            "Register Your Restaurant",
                            style: TextStyle(
                              color: Colors.grey[700],
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0,
                            ),
                          ),
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
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 16.0, horizontal: 40.0),
                          child: Material(
                            elevation: 3.0,
                            color: Color(0xff5ab190),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: MaterialButton(
                              onPressed: () async {
                                if (formKey.currentState.validate()) {
                                  setState(() {
                                    isLoading = true;
                                  });
                                  await DatabaseService(uid: user.uid).updateUserData(
                                    restaurantName,
                                    ownerName,
                                    phoneNumber,
                                    address,
                                    city
                                  );
                                  setState(() {
                                    isLoading = false;
                                  });
                                }
                              },
                              child: Center(
                                child: Text(
                                  'Register Your Restaurant',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontSize: 18.0,
                                  ),
                                ),
                              ),
                            ),
                          ),
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

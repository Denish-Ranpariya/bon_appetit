//import 'package:bon_appetit/services/auth_service.dart';
import 'package:bon_appetit/shared/loading.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FormScreen extends StatefulWidget {
  @override
  _FormScreenState createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  String restaurantName,ownerName,mobileNumber,address,city;
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
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
            body: Column(
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
                        SizedBox(height: 30.0,),
                        Expanded(
                          child: SvgPicture.asset(
                              "images/cafe.svg",
                            height: 150.0,
                          ),
                        ),
                        SizedBox(height: 20.0,),
                        Text(
                          "Register Your Restaurant",
                          style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                          ),
                        ),
                        SizedBox(height: 20.0,),
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
                        image: "storefront.svg",
                        hintText: "Restaurant Name",
                        maxLine: 1,
                        onChange: (value) {
                          restaurantName = value;
                        },
                      ),
                      SizedBox(height: 10.0,),
                      CustomTextField(
                        image: "person.svg",
                        hintText: "Owner Name",
                        maxLine: 1,
                        onChange: (value) {
                          ownerName = value;
                        },
                      ),
                      SizedBox(height: 10.0,),
                      CustomTextField(
                        image: "phone.svg",
                        hintText: "Phone Number",
                        maxLine: 1,
                        onChange: (value) {
                          mobileNumber = value;
                        },
                      ),
                      SizedBox(height: 10.0,),
                      CustomTextField(
                        image: "apartment.svg",
                        hintText: "Restaurant Address",
                        onChange: (value) {
                          address = value;
                        },
                        maxLine: 5,
                      ),
                      SizedBox(height: 10.0,),
                      CustomTextField(
                        image: "business.svg",
                        hintText: "City",
                        maxLine: 1,
                        onChange: (value) {
                          city = value;
                        },
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 16.0,horizontal: 40.0),
                        child: Material(
                          elevation: 3.0,
                          color: Color(0xff5ab190),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: MaterialButton(
                            onPressed: () {},
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
          );
  }
}

class CustomTextField extends StatelessWidget {
  final String hintText,image;
  final int maxLine;
  final Function onChange;
  CustomTextField({this.hintText,this.image,this.maxLine,this.onChange});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 26.0),
      child: Container(
        child: Card(
          child: ListTile(
            leading: SvgPicture.asset("images/$image",color: Colors.grey),
            title: TextField(
              maxLines: maxLine,
              decoration: InputDecoration(
                hintStyle: TextStyle(color: Colors.grey,fontSize: 18.0),
                hintText: hintText,
                border: InputBorder.none,
              ),
              onChanged: onChange,
            ),
          ),
        ),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              blurRadius: 5.0,
              color: Colors.grey.withOpacity(.3),
              offset: Offset(1.5, 2.0),
            ),
          ],
        ),
      ),
    );
  }
}
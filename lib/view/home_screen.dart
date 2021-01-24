import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gsm_pos/controller/appBrain.dart';
import 'package:gsm_pos/cusom_widgets/custom_button.dart';
import 'package:gsm_pos/modal/modal.dart';
import 'package:gsm_pos/view/admin_screen.dart';
import 'package:gsm_pos/view/store_screen.dart';

import '../constant.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  AppBrain appBrain;
  String username;
  String password;
  String error;

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Color(0xff1A1B24),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: deviceHeight * 0.1,
            ),
            Center(
              child: Text(
                'GSM DOCTOR PHONES AND ACCESORIES',
                style: TextStyle(
                  fontSize: deviceWidth * 0.02,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              height: deviceHeight * 0.04,
            ),
            Center(
              child: Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.blueGrey,
                  ),
                  borderRadius: BorderRadius.circular(
                    15,
                  ),
                ),
                width: 400,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'LOG IN',
                      style: TextStyle(),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Text('Enter username and password with no space'),
                    ),
                    SizedBox(
                      height: deviceHeight * 0.01,
                    ),
                    TextField(
                      textAlign: TextAlign.center,
                      decoration: kInputOtline,
                      onChanged: (value) {
                        setState(() {
                          username = value;
                        });
                      },
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    TextField(
                      textAlign: TextAlign.center,
                      decoration: kInputOtline.copyWith(
                          labelText: 'Password', errorText: error),
                      onChanged: (value) {
                        setState(() {
                          password = value;
                        });
                      },
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    CustomButtom(
                      width: double.infinity,
                      onpress: () {
                        setState(() {
                          if (username.isEmpty || password.isEmpty) {
                            exit(0);
                          }

                          try {
                            if (username == 'Free-man' &&
                                password == '@gsmdoctor2020') {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return AdminScreen();
                              }));
                            } else if (username == 'admin' &&
                                password == 'admin') {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return StoreHome();
                              }));
                            }
                          } catch (e) {
                            print(e);
                          }
                        });
                      },
                      title: 'LOG IN',
                      color: Color(0xff827F8D),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

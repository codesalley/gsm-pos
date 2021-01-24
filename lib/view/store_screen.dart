import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gsm_pos/constant.dart';
import 'package:gsm_pos/cusom_widgets/custom_button.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class StoreHome extends StatefulWidget {
  @override
  _StoreHomeState createState() => _StoreHomeState();
}

class _StoreHomeState extends State<StoreHome> {
  final productName = TextEditingController();
  TextEditingController productPrice = TextEditingController();
  bool sett = false;
  var total = 0;
  var price;

  void getTotal() {
    var box = Hive.box('storeinfo');
    setState(() {
      total = box.values
          .fold(0, (previousValue, element) => previousValue + element[0]);
    });
  }

  @override
  void initState() {
    getTotal();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;
    // Hive.box('storeinfo').values.elementAt(index)
    return Scaffold(
      backgroundColor: Color(0xff1A1B24),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: deviceWidth * 0.01),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: deviceWidth * 0.03),
                  width: deviceWidth * 0.45,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: FlatButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text("Log Out")),
                      ),
                      Text(
                        'HI, GSM DOCTOR',
                        style: TextStyle(fontSize: deviceWidth * 0.02),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomButtom(
                            width: deviceWidth * 0.15,
                            color: krepairColor,
                            title: 'REPAIRS',
                            onpress: () {
                              setState(() {
                                sett = true;
                              });
                            },
                            height: deviceHeight * 0.03,
                          ),
                          CustomButtom(
                            width: deviceWidth * 0.15,
                            color: ksalesColor,
                            title: 'SALES',
                            onpress: () {
                              setState(() {
                                sett = false;
                              });
                            },
                            height: deviceHeight * 0.03,
                          ),
                        ],
                      ),
                      TextField(
                        controller: productName,
                        textAlign: TextAlign.center,
                        decoration: kInputOtline.copyWith(
                          labelText: 'Service',
                        ),
                      ),
                      TextField(
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp('[0-9.,]+'))
                        ],
                        controller: productPrice,
                        textAlign: TextAlign.center,
                        decoration: kInputOtline.copyWith(
                          labelText: 'Price \$ ',
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomButtom(
                            width: deviceWidth * 0.1,
                            title: 'ADD',
                            onpress: () {
                              if (productPrice.value.text.isEmpty ||
                                  productName.text.isEmpty) {
                                productName.clear();
                                productPrice.clear();
                                return;
                              } else {
                                Hive.box('storeinfo').put(productName.text, [
                                  int.parse(productPrice.text),
                                  DateTime.now()
                                ]);
                                setState(() {
                                  getTotal();
                                });

                                print(Hive.box('storeinfo').values.length);
                              }

                              productName.clear();
                              productPrice.clear();
                            },
                          ),
                          CustomButtom(
                            width: deviceWidth * 0.1,
                            title: 'RESET',
                            onpress: () {
                              productName.clear();
                              productPrice.clear();
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(
                    right: deviceWidth * 0.03, left: deviceWidth * 0.02),
                width: deviceWidth * 0.5,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Align(
                      alignment: Alignment.topRight,
                      child: Text(
                        'GH\$ ${total}.00',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: deviceWidth * 0.02,
                        ),
                      ),
                    ),
                    Text(
                      'Today sales',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: deviceWidth * 0.02,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Item',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: deviceWidth * 0.02,
                          ),
                        ),
                        Text(
                          'Price \$ ',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: deviceWidth * 0.02,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      alignment: Alignment.center,
                      height: deviceHeight * 0.7,
                      child: ValueListenableBuilder(
                          valueListenable: Hive.box('storeinfo').listenable(),
                          builder: (context, box, _) {
                            return ListView.builder(
                                itemCount: box.values.length,
                                itemBuilder: (context, int index) {
                                  return Card(
                                    color: Colors.white,
                                    child: ListTile(
                                      title: Text(
                                        box.keys.elementAt(index),
                                        style: TextStyle(
                                          color: Colors.black,
                                        ),
                                      ),
                                      trailing: Text(
                                        '${box.values.elementAt(index)[0]}'
                                        // box.values
                                        //     .elementAt(index)[0]
                                        //     .toString(),
                                        ,
                                        style: TextStyle(
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  );
                                });
                          }),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

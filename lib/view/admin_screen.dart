import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class AdminScreen extends StatefulWidget {
  @override
  _AdminScreenState createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(''),
          Container(
            height: 50,
            color: Colors.pinkAccent,
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 150),
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
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 15,
                              vertical: 10,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  box.keys.elementAt(index),
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                                Text(
                                  box.values.elementAt(index)[0].toString(),
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                                FlatButton(
                                    onPressed: () {
                                      box.deleteAt(index);
                                    },
                                    child: Text(
                                      'Delete',
                                      style: TextStyle(color: Colors.black),
                                    ))
                              ],
                            ),
                          ),
                        );
                      });
                }),
          ),
          Padding(
            padding: EdgeInsets.all(deviceHeight * 0.05),
            child: Text('Data delted here can not be retored'),
          )
        ],
      )),
    );
  }
}

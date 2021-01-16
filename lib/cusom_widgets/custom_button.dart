import 'package:flutter/material.dart';

class CustomButtom extends StatelessWidget {
  const CustomButtom(
      {this.onpress, this.width, this.title, this.color, this.height});
  final Function onpress;
  final double width;
  final String title;
  final Color color;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(10),
      elevation: 2,
      color: color,
      child: FlatButton(
        padding: EdgeInsets.symmetric(
          vertical: height ?? 20,
        ),
        minWidth: width,
        onPressed: onpress,
        child: Text(
          title,
        ),
      ),
    );
  }
}

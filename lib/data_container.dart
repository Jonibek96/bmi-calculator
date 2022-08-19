import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

 const textStyle1 = TextStyle(
    color: Color(0xFF000000),
    fontSize: 18.0
);

const textStyle2 = TextStyle(
    color: Color(0xFF000000),
    fontSize: 60.0,
    fontWeight: FontWeight.w900
);

const textStyle3 = TextStyle(
    color: Color(0xFFffffff),
    fontSize: 30.0,
    fontWeight: FontWeight.w900
);

class DataContainer extends StatelessWidget {
  DataContainer({required this.iconData, required this.title});

  final IconData iconData;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(
          iconData,
          size: 80.0,
        ),
        SizedBox(height: 15.0),
        Text(
            title,
            style: textStyle1
        )],
    );
  }
}
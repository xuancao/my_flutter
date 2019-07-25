import 'package:flutter/material.dart';

class MineCenterItem extends StatelessWidget{
  String title;
  String icon;
  VoidCallback onPressed;

  MineCenterItem({Key key,this.title,this.icon,this.onPressed}):super(key:key);

  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
      onTap: onPressed,
      child: new Column(
        children: <Widget>[
          Image.asset(icon,height: 40,width: 40,),
          new Padding(
            padding: EdgeInsets.only(top: 5),
            child: new Text(
              title,
              style: new TextStyle(color: new Color(0xFF333333),fontSize: 15),
            ),
          ),
        ],
      ),
    );
  }

}
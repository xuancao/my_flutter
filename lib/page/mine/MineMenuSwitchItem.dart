import 'package:flutter/material.dart';
import 'package:ybwp_flutter/widget/MySwitchButton.dart';

class MineMenuSwitchItem extends StatelessWidget{

  String icon;
  String title;
  bool check;
  ValueChanged<bool> onChanged;

  MineMenuSwitchItem({Key key,this.icon,this.title,this.check,this.onChanged}):super(key:key);

  @override
  Widget build(BuildContext context) {
    return new Column(
      children: <Widget>[
        new Padding(
          padding: EdgeInsets.only(left:15,top: 10,right: 0,bottom: 10),
          child: new Row(
            children: <Widget>[
              new Padding(
                padding: EdgeInsets.only(right: 8),
                child: Image.asset(icon,width: 30,height: 30,),
              ),
              new Expanded(
                child: new Text(
                  title,
                  style: new TextStyle(color: new Color(0xFF333333),fontSize: 15),
                ),
              ),
              MySwitchButtton(
                checked: check,
                onChanged: onChanged,),
            ],
          ),
        ),
        new Padding(
          padding: const EdgeInsets.only(left: 15,right: 15),
          child: new Divider(color: new Color(0xFFEEEEEE),height: 1,),
        ),
      ],
    );
  }

}
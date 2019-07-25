import 'package:flutter/material.dart';
import 'package:ybwp_flutter/resource/Drawable.dart';

class MineMenuItem extends StatelessWidget{

  String icon;
  String title;
  String content;
  VoidCallback onPressed;

  MineMenuItem({Key key,this.icon,this.title,this.content,this.onPressed}):super(key:key);

  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
      onTap: onPressed,
      child: new Column(
        children: <Widget>[
          new Padding(
              padding: EdgeInsets.only(left:15,top: 10,right: 15,bottom: 10),
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
                  new Padding(
                    padding: EdgeInsets.only(right: 8),
                    child: Text(content!=null ? content : "", style: new TextStyle(color: new Color(0xFF999999),fontSize: 15),
                    ),
                  ),
                  Image.asset(Drawable.DRAWABLE_IC_RIGHT_ARROW,height: 20,width: 10,),
                ],
              ),
          ),
          new Padding(
              padding: const EdgeInsets.only(left: 15,right: 15),
              child: new Divider(color: new Color(0xFFEEEEEE),height: 1,),
          ),
        ],
      ),
    );
  }

}
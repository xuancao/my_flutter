import 'package:flutter/material.dart';
import 'package:ybwp_flutter/model/DotNetModel.dart';
import 'package:ybwp_flutter/resource/RColor.dart';
import 'package:ybwp_flutter/utils/ColorUtils.dart';

class NetDot_Item extends StatelessWidget{

  NetDotModel netDot;

  VoidCallback onPressed;

  NetDot_Item({this.netDot,this.onPressed});

  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
      onTap: onPressed,
      child: new Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.only(left: 15,right: 15,top: 10,bottom: 10),
        color: Colors.white,
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            new Row(
              children: <Widget>[
                new Expanded(
                    child: Text(
                      netDot.name,
                      style: new TextStyle(color: new Color(RColor.black),fontSize: 15),
                    )),
                Text(
                  netDot.shortName,
                  style: new TextStyle(color: new Color(RColor.main_color),fontSize: 15),
                ),
              ],
            ),
            new Padding(
                padding: EdgeInsets.only(top: 8),
                child: Text(
                    netDot.id,
                    style:new TextStyle(color: new Color(RColor.gry),fontSize: 13)
                ),
            ),
            new Container(
              decoration: new BoxDecoration(
                color: new Color(RColor.common_f5f5f5),
                borderRadius: new BorderRadius.all(new Radius.circular(5)),
              ),
              padding: const EdgeInsets.only(top: 3,bottom: 3,left: 8,right: 8),
              margin: const EdgeInsets.only(top: 10,bottom: 6),
              child: Text(
                netDot.bankName,
                style: new TextStyle(color: new Color(RColor.gry),fontSize: 11),
              ),
            ),
            new Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                CircleAvatar(
                  backgroundColor: Color(ColorUtils.getColorFromHex(netDot.color)),
                  child: new Text(netDot.logo,style: new TextStyle(color: new Color(RColor.white),fontSize: 9),),
                  radius: 12,
                ),
                new Padding(
                  padding: EdgeInsets.only(left: 8),
                  child: Text(
                    netDot.startTime,
                    style: new TextStyle(color: new Color(RColor.common_666666),fontSize: 15),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }



}
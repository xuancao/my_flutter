import 'package:flutter/material.dart';
import 'package:ybwp_flutter/model/Potential/PotentialNestModel.dart';
import 'package:ybwp_flutter/resource/RColor.dart';

class Potential_Item extends StatelessWidget{

  PotentialModel model;

  VoidCallback onPressed;

  Potential_Item({Key key,@required this.model,@required this.onPressed}):super(key:key);

  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
      onTap: onPressed,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 15,top: 15,right: 15,bottom: 5),
            child:  Text(model.name, style: new TextStyle(color: Color(RColor.black),fontSize: 15),)
          ),
          Padding(
            padding: EdgeInsets.only(left: 15,right: 15,bottom: 15),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                CircleAvatar(
//                  backgroundColor: Color(int.parse(model.bankLogoColor.replaceAll("#", "0xff"))),
                  child: Text(model.bankLogo,style: new TextStyle(color: Color(RColor.white),fontSize: 10),),
                  radius: 12,
                ),
                new Padding(
                  padding: EdgeInsets.only(left: 5),
                  child: Text(
                    model.networkName,
                    style: new TextStyle(color: new Color(0xFF666666),fontSize: 15),
                  ),
                )
              ],
            ),
          ),
          Divider(
            height: 1,
            color: Color(RColor.lineColor),
          )

        ],
      ),
    );
  }

}
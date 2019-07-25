import 'package:flutter/material.dart';
import 'package:ybwp_flutter/generated/translations.dart';
import 'package:ybwp_flutter/resource/Drawable.dart';

class EmptyView extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return new Container(
      width: double.infinity,
      height: 400.0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Image.asset(Drawable.DRAWABLE_IC_EMPTY_VIEW,height: 50,width: 50,),
          Text(
            "没有数据",
            style: TextStyle(fontSize: 18.0, color: Colors.grey),
          )
        ],
      ),
    );
  }

}
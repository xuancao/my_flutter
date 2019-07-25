import 'package:flutter/material.dart';
import 'package:ybwp_flutter/page/listTest/ListAdjustRefreshPage.dart';
import 'package:ybwp_flutter/page/listTest/ListRefreshCompletePage.dart';
import 'package:ybwp_flutter/page/listTest/ListRefreshTestPage.dart';
import 'package:ybwp_flutter/page/netDot/NetDotPage.dart';
import 'package:ybwp_flutter/resource/Drawable.dart';
import 'package:ybwp_flutter/utils/NavigatorUtils.dart';

import 'MineCenterItem.dart';

class MineCenter extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return new Container( color: Colors.white,
      child: new Padding(
        padding: EdgeInsets.only(top: 10,bottom: 10),
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            new MineCenterItem(
              title: "巡访记录",
              icon: Drawable.DRAWABLE_IC_VISIT_RECORDS,
              onPressed: (){
                NavigatorUtils.push(context, new NetDotPage());
              },
            ),
            new MineCenterItem(
              title: "同业信息",
              icon: Drawable.DRAWABLE_IC_SAME_INFO,
              onPressed: (){
                NavigatorUtils.push(context, new ListRefreshCompletePage());
              },
            ),
            new MineCenterItem(
              title: "收到的赞",
              icon: Drawable.DRAWABLE_IC_ZAN,
              onPressed: (){
              NavigatorUtils.push(context, new ListAdjustRefreshPage());
              },
            ),
            new MineCenterItem(
              title: "主管评语",
              icon: Drawable.DRAWABLE_IC_COMMENT,
              onPressed: (){
              NavigatorUtils.push(context, new ListRefreshTestPage());
//              NavigatorUtils.push(context, new ListTestPage());
              },
            ),
          ],
        ),
      ),);
  }

}
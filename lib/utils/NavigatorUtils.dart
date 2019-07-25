import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

//路由跳转
//@author lxl
class NavigatorUtils {

  static pushAndRemoveUntil(BuildContext context, Widget widget) {
    return Navigator.of(context).pushAndRemoveUntil(
        new MaterialPageRoute(builder: (context)=>widget), (Route<dynamic> rout)=>false);
  }

  static push(BuildContext context, Widget widget) {
    return Navigator.push(context, new MaterialPageRoute(builder: (context) => widget));
  }


  static pushReplacementNamed(BuildContext context, String routeName) {
    Navigator.pushReplacementNamed(context, routeName);
  }
  static pushNamed(BuildContext context, String routeName) {
    Navigator.pushNamed(context, routeName);
  }

}

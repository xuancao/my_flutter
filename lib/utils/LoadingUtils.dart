import 'package:flutter/material.dart';
import 'package:ybwp_flutter/resource/RColor.dart';
import 'package:ybwp_flutter/resource/Strings.dart';
import 'package:ybwp_flutter/resource/Style.dart';
import 'package:ybwp_flutter/widget/SpinKitCubeGrid.dart';

//加载框
//@author lxl
class LoadingUtils {

  static Future<Null> showLoadingDialog(BuildContext context) {
    if(context == null)return null;
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return new Material(
              color: Colors.transparent,
              child: WillPopScope(
                onWillPop: () => new Future.value(false),
                child: Center(
                  child: new Container(
                    width: 200.0,
                    height: 200.0,
                    padding: new EdgeInsets.all(4.0),
                    decoration: new BoxDecoration(
                      color: Colors.transparent,
                      //用一个BoxDecoration装饰器提供背景图片
                      borderRadius: BorderRadius.all(Radius.circular(4.0)),
                    ),
                    child: new Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        new Container(child: SpinKitCubeGrid(color: Color(RColor.white))),
                        new Container(height: 10.0),
                        new Container(child: new Text(Strings.TIP_LOADING, style: Style.normalTextWhite)),
                      ],
                    ),
                  ),
                ),
              ));
        });
  }

  static hintLoadingDialog(BuildContext context) {
    if(context == null)return null;
    Navigator.pop(context);
  }
}
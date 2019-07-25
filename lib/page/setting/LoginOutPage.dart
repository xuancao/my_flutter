import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:ybwp_flutter/model/User/UserSPferUtils.dart';
import 'package:ybwp_flutter/model/User/db/UserDBHelper.dart';
import 'package:ybwp_flutter/page/login/LoginPage.dart';
import 'package:ybwp_flutter/resource/RColor.dart';
import 'package:ybwp_flutter/utils/NavigatorUtils.dart';

class LoginOutPage extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return new LoginOutState();
  }

}

class LoginOutState extends StatelessWidget{

  @override
  Widget build(BuildContext context) {

    RaisedButton _raisedButton = RaisedButton(
      child: Text(
        "退出登录",
        style: TextStyle(
            color:  Colors.white,
            fontSize: 18
        ),
      ),
      elevation: 0, //阴影范围
      color: new Color(RColor.red),
      disabledColor: new Color(RColor.red),
      splashColor: new Color(RColor.pink), //点击按钮时水波纹的颜色
//        shape: CircleBorder( //圆形边框
//          side: BorderSide(
//            color: Colors.white,
//          ),
//        ),
//        shape:  RoundedRectangleBorder( //圆角矩形
//          borderRadius: BorderRadius.all(Radius.circular(10)),
//        ),
      shape: StadiumBorder(), //两端是半圆的边框
      onPressed: () {
        UserSpferUtils.clearLoginInfo().then((r){
          UserDBHelper.getInstance().deleteUser();
          NavigatorUtils.pushAndRemoveUntil(context, new LoginPage());
        });
      },
    );

    return new Scaffold(
      appBar: new AppBar(
        elevation: 0,
        centerTitle: true,
        title: new Text("退出登录", style: new TextStyle(fontSize: 20,color: Colors.white),),
      ),
      body: new Container(
        color: Colors.white,
        margin: EdgeInsets.only(bottom: 30),
        padding: EdgeInsets.only(top: 8,bottom: 8,left: 20,right: 20),
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
//          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(child: Text("")),
            Container(
              width: 50.0,
              height: 50.0,
              padding: EdgeInsets.only(top: 8,bottom: 8),
              child: SpinKitFadingCube(
                color: Theme.of(context).primaryColor,
                size: 25.0,
              ),
            ),
            new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _raisedButton,
              ],
            )

          ],
        ),
      ),
    );
  }

}
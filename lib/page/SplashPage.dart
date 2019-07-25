import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ybwp_flutter/api/net/Config.dart';
import 'package:ybwp_flutter/model/User/db/UserDBHelper.dart';
import 'package:ybwp_flutter/page/MainPage.dart';
import 'package:ybwp_flutter/page/login/LoginPage.dart';
import 'package:ybwp_flutter/resource/Drawable.dart';
import 'package:ybwp_flutter/utils/NavigatorUtils.dart';
import 'package:ybwp_flutter/model/User/UserSPferUtils.dart';

class SplashPage extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    return new SplashState();
  }
}

class SplashState extends State<SplashPage>{

  Timer _timer;

  @override
  Widget build(BuildContext context) {
//    return new Material(
//      color: new Color(0xFFFF4D46),
//      child: Container(
//        alignment: Alignment(0, -0.3),
//        child: new Text("SPLASH",style: new TextStyle(color: Colors.white,fontSize: 50,fontWeight: FontWeight.bold),),
//      ),
//    );

    return new Container(
      child: Image.asset(Drawable.DRAWABLE_LAUNCHER_BG,fit: BoxFit.cover,),//BoxFit.cover用于拉伸图片,使图片铺满全屏
    );
  }

  //页面初始化状态的方法
  @override
  void initState() {
    super.initState();
    //开启倒计时
    countDown();

    Config.readSfpHeaders();//设置请求头headers数据
    UserDBHelper.getInstance().initDb();
  }





  //设置倒计时三秒后执行跳转方法
  void countDown() {
    _timer = new Timer(const Duration(seconds: 3), (){
      goToMainPage();
    });
//    var duration = new Duration(seconds: 3);
//    new Future.delayed(duration, goToMainPage);
  }

  void goToMainPage(){
    //如果页面还未跳转过则跳转页面

    //跳转主页 且销毁当前页面
    UserSpferUtils.isLogin().then((islogin){
      if(islogin){
        NavigatorUtils.pushAndRemoveUntil(context, new MainPage());
      }else{
        NavigatorUtils.pushAndRemoveUntil(context, new LoginPage());
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

}
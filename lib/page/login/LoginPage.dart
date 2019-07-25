import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ybwp_flutter/api/ApiInterface.dart';
import 'package:ybwp_flutter/api/net/Config.dart';
import 'package:ybwp_flutter/api/net/ResponseData.dart';
import 'package:ybwp_flutter/model/User/UserEntity.dart';
import 'package:ybwp_flutter/model/User/db/UserDBHelper.dart';
import 'package:ybwp_flutter/page/MainPage.dart';
import 'package:ybwp_flutter/resource/Dimens.dart';
import 'package:ybwp_flutter/resource/Drawable.dart';
import 'package:ybwp_flutter/resource/Strings.dart';
import 'package:ybwp_flutter/utils/NavigatorUtils.dart';
import 'package:ybwp_flutter/utils/ToastUtils.dart';
import 'package:ybwp_flutter/model/User/UserSPferUtils.dart';

class LoginPage extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    return new _LoginPageState();
  }
}

class _LoginPageState extends State<LoginPage>{


  var leftRightPadding = Dimens.VALUE_15;

  bool isShowPwd = false;

  GlobalKey<ScaffoldState> scaffoldKey;

  TextEditingController _nameController = TextEditingController();

  TextEditingController _passwordController = TextEditingController();

  UnderlineInputBorder underlineInputBorder = UnderlineInputBorder(
    borderSide: BorderSide(
      color: Colors.white,
      width: 1,
    ),

  );

  @override
  void initState() {
    super.initState();
    scaffoldKey = GlobalKey();
  }

  @override
  Widget build(BuildContext context) {
    Container container = new Container(
      margin: EdgeInsets.only(top: 50),
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new Image.asset(Drawable.DRAWABLE_IC_ABLIFE,width: 155,height: 31),
          new Container(
            margin: EdgeInsets.only(top: 50),
            child: new Image.asset(Drawable.DRAWABLE_IC_LOGIN_ICON,width: 150,height: 150,),
          )
        ],
      ),
    );
    TextField name = TextField(
      autofocus: false,
      keyboardType: TextInputType.text,
      style: TextStyle(color: Colors.white,fontSize: 15),
      decoration: InputDecoration(
        hintText: "请输入员工号",
        hintStyle:TextStyle(color: Colors.white,fontSize: 15),
        hasFloatingPlaceholder: false,
        enabledBorder: underlineInputBorder,
        focusedBorder: underlineInputBorder,
//        border: InputBorder.none, //设置无下划线
      ),
      maxLines: 1,
      cursorColor: new Color(0xFFFFFFFF),
      cursorWidth: 2,
      controller: _nameController,
    );

    TextField password = TextField(
      autofocus: false,
      keyboardType: TextInputType.text,
      style: TextStyle(color: Colors.white,fontSize: 15),
      decoration: InputDecoration(
        hintText: "请输入邮箱密码",
        hintStyle:TextStyle(color: Colors.white,fontSize: 15),
        hasFloatingPlaceholder: false,
        suffixIcon: IconButton(
            icon: Image.asset(isShowPwd ? Drawable.DRAWABLE_IC_PWD_EYE_CLOSE : Drawable.DRAWABLE_IC_PWD_EYE_OPEN,width: 20,height: 30,),
            onPressed: (){
              onPressEye();
            },
        ),
        focusedBorder: underlineInputBorder,
        enabledBorder: underlineInputBorder,
//        border: InputBorder.none,
      ),
      obscureText: isShowPwd, //隐藏输入文本（密码）
      maxLines: 1,
      cursorColor: new Color(0xFFFFFFFF),
      cursorWidth: 2,
      controller: _passwordController,
    );

    RaisedButton _raisedButton = RaisedButton(
      child: Text(
        "登录",
        style: TextStyle(
          color:  new Color(0xFFFF4D46),
          fontSize: 18
        ),
      ),
      color: Colors.white,
      disabledColor: Colors.white,
      onPressed: () {
        _login(context);
      },
    );

    return Container(
      padding: EdgeInsets.only(bottom: 40),
      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage(Drawable.DRAWABLE_IC_LOGIN_BG),fit: BoxFit.cover),
//          image: DecorationImage(image: NetworkImage('https://img.zcool.cn/community/0372d195ac1cd55a8012062e3b16810.jpg'),fit: BoxFit.cover,)
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        key: scaffoldKey,
        body: ListView(
          children: <Widget>[
            container,
            Padding(
              padding: EdgeInsets.only(top: Dimens.VALUE_30,left: leftRightPadding,right: leftRightPadding),
              child: name,
            ),
            Padding(
              padding: EdgeInsets.only(top: Dimens.VALUE_0,left: leftRightPadding,right: leftRightPadding,bottom: Dimens.VALUE_30),
              child: password,
            ),
            Padding(
              padding: EdgeInsets.only(left: Dimens.VALUE_30,right: Dimens.VALUE_30,),
              child: _raisedButton,
            ),
          ],
        ),
      ),
    );

  }

  void onPressEye(){
    setState(() {
      isShowPwd = !isShowPwd;
    });
  }

  void _login(BuildContext context){
    if(_nameController.text.isEmpty){
      ToastUtils.showToast(Strings.TIP_LOGIN_NAME);
      return;
    }
    if(_passwordController.text.isEmpty){
      ToastUtils.showToast(Strings.TIP_LOGIN_PWD);
      return;
    }


    ApiInterface.login(context, _nameController.text, _passwordController.text,true, (data){
      ResponseData responseData = data;
      String content = json.encode(responseData.data);
      print("content = "+ content);

//      UserBeanEntity user = UserBeanEntity.fromJson(json.decode(content));
//      UserSpferUtils.saveLoginInfo(user.realName, user.imgUrl,user.company).then((r){
//        loginSuccess(context);
//      });
      UserBeanEntity user = UserBeanEntity.fromJson(json.decode(content));
      if(user!=null){
        Config.setRequestHeander(user.token, user.roleType,user.managerMemberId,user.companyId);//设置请求头headers数据
        UserSpferUtils.saveUserInfoHeader(user.token, user.roleType,user.managerMemberId,user.companyId);
        UserDBHelper.getInstance().saveUser(user);
      }
      loginSuccess(context);
    });
  }

  void loginSuccess(BuildContext context){
    var duration = new Duration(microseconds: 100);
    new Future.delayed(duration,(){
      NavigatorUtils.pushAndRemoveUntil(context,new MainPage());
    });
  }

}
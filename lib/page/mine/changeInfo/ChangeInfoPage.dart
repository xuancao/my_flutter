import 'package:flutter/material.dart';
import 'package:ybwp_flutter/generated/translations.dart';
import 'package:ybwp_flutter/model/User/db/UserDBHelper.dart';
import 'package:ybwp_flutter/resource/Drawable.dart';
import 'package:ybwp_flutter/utils/StringUtils.dart';

import '../MineMenuItem.dart';
import 'InputNameDialog.dart';
import 'SexDialog.dart';

class ChangeInfoPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => new _ChangeInfoState();

}

class _ChangeInfoState extends State<ChangeInfoPage>{

  int _sexType = 0;
  String _userName;

  @override
  void initState() {
    super.initState();
    UserDBHelper.getInstance().getUser().then((user){
      setState(() {
        if(StringUtils.isNotEmpty(user.realName)){
          _userName = user.realName;
        }
        if(StringUtils.isNotEmpty(user.sex)){
          _sexType = int.parse(user.sex);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        elevation: 0,
        centerTitle: true,
        title: new Text(Translations.of(context).text("changeUserInfo"), style: new TextStyle(fontSize: 20,color: Colors.white),),
      ),
      body: new Container(
        color: Colors.white,
        child: new Column(
          children: <Widget>[
            new MineMenuItem(
              icon: Drawable.DRAWABLE_IC_SETTING,
              title: Translations.of(context).text("changeName"),
              content: _userName,
              onPressed: (){
                showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (BuildContext context) {
                      return InputNameDialog(
                        title: "输入姓名",
                        onPressed: (value){
                          setState(() {
                            _userName = value;
                          });
                        },
                      );
                    });
              },
            ),
            new MineMenuItem(
              icon: Drawable.DRAWABLE_IC_SETTING,
              title: Translations.of(context).text("changeSex"),
              content: _sexType == 0 ? "男": "女",
              onPressed: (){
                showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (BuildContext context) {
                      return SixDialog(
                        value: _sexType,
                        onPressed: (i, value){
                          setState(() {
                            _sexType = i;
                          });
                          UserDBHelper.getInstance().getUser().then((user){
                            user.sex = _sexType.toString();
                            UserDBHelper.getInstance().updateUser(user);
                          });
                        },
                      );
                    });
              },
            ),
          ],
        ),
      ),
    );
  }

}
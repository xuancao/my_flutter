import 'package:flutter/material.dart';
import 'package:ybwp_flutter/events/SwitchBtnEvent.dart';
import 'package:ybwp_flutter/generated/translations.dart';
import 'package:ybwp_flutter/page/setting/SettingPage.dart';
import 'package:ybwp_flutter/resource/Drawable.dart';
import 'package:ybwp_flutter/utils/NavigatorUtils.dart';

import '../Constant.dart';
import 'MineMenuItem.dart';
import 'MineMenuSwitchItem.dart';
import 'changeInfo/ChangeInfoPage.dart';

class MineMenu extends StatefulWidget{

  @override
  State<StatefulWidget> createState() => _MineMenuState();
}

class _MineMenuState extends State<MineMenu>{

  bool check = false;

  @override
  Widget build(BuildContext context) {
    return new Container(
      color: Colors.white,
      margin: const EdgeInsets.only(top: 10),
      child: Column(
        children: <Widget>[
          new MineMenuSwitchItem(
            icon: Drawable.DRAWABLE_IC_SETTING,
            title:  Translations.of(context).text("wheShowID"),
            check: check,
            onChanged: (bool wheHid){
              setState(() {
                check = wheHid;
                Constant.eventBus.fire(new SwitchBtnEvent(check));
              });
            },
          ),
          new MineMenuItem(
            icon: Drawable.DRAWABLE_IC_CHANGE_INFO,
            title: Translations.of(context).text("changeUserInfo"),
            onPressed: (){
              NavigatorUtils.push(context, new ChangeInfoPage());
            },
          ),
          new MineMenuItem(
            icon: Drawable.DRAWABLE_IC_FEEDBACK,
            title: Translations.of(context).text("feedback"),
            onPressed: (){

            },
          ),
          new MineMenuItem(
            icon: Drawable.DRAWABLE_IC_SETTING,
            title: Translations.of(context).text("setting"),
            onPressed: (){
//                          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
//                            return LoginPage();
//                          }));
              NavigatorUtils.push(context, new SettingPage());
            },
          ),
        ],
      ),
    );
  }

}

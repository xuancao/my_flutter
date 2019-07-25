import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:ybwp_flutter/generated/translations.dart';
import 'package:ybwp_flutter/page/mine/MineMenuItem.dart' show MineMenuItem;
import 'package:ybwp_flutter/page/setting/LoginOutPage.dart';
import 'package:ybwp_flutter/resource/Drawable.dart';
import 'package:ybwp_flutter/resource/RColor.dart';
import 'package:ybwp_flutter/resource/Style.dart';
import 'package:ybwp_flutter/utils/NavigatorUtils.dart';

// import '' show 。。 可以用于快速查看引入的类代码

class SettingPage extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    return new _SettingState();
  }
}

class _SettingState extends State<SettingPage>{

  /// 国际化
  void openLanguageSelectMenu() async {
    await showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return Container(
          child: Wrap(
            children: <Widget>[
              ListTile(
                title: Text(
                  '中文',
                ),
                onTap: () {
                setState(() {
                  Translations.load(Locale('zh'));
                });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text('English'),
                onTap: () {
                  setState(() {
                    Translations.load(Locale('en'));
                  });
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          elevation: 0,
          centerTitle: true,
          title: new Text(Translations.of(context).text("settingPage"), style: new TextStyle(fontSize: 20,color: Colors.white),),
        ),
        body:ListView(
          children: <Widget>[
            MineMenuItem(
              icon: Drawable.DRAWABLE_IC_LANGUAGE,
              title: Translations.of(context).text("chooseLanguage"),
              onPressed: (){
                this.openLanguageSelectMenu();
              },
            ),
            new MineMenuItem(
              icon: Drawable.DRAWABLE_IC_SETTING,
              title: Translations.of(context).text("loginOut"),
              onPressed: (){
//                          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
//                            return LoginPage();
//                          }));
                NavigatorUtils.push(context, new LoginOutPage());
              },

            ),
            Gaps.vGap60,
            new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SpinKitRipple(
                  color: Theme.of(context).primaryColor,
                  size: 25.0,
                ),
                 Text(
                   "https://github.com/xuancao",
                   style: new TextStyle(fontSize: 13,color: Color(RColor.gry)),
                 ),
              ],
            ),
          ],
        ),
    );
  }

}
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:ybwp_flutter/generated/application.dart';
import 'package:ybwp_flutter/generated/translations.dart';
import 'package:ybwp_flutter/page/SplashPage.dart';

//void main() => runApp(MyApp());
//
//class MyApp extends StatelessWidget {
//
//  @override
//  Widget build(BuildContext context) {
//    return MaterialApp(
//      theme: ThemeData(
//        primarySwatch: Colors.red,
//      ),
//      home: SplashPage(),
//    );
//  }
//}

void main() => runApp(MyApp());

class MyApp extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    return new _MyAppState();
  }
}

//带国际化的设置
class _MyAppState extends State<MyApp> {

  SpecificLocalizationDelegate _localeOverrideDelegate;

  @override
  void initState() {
    super.initState();

    /// 初始化一个新的Localization Delegate，当用户选择一种新的工作语言时，可以强制初始化一个新的Translations
    _localeOverrideDelegate = new SpecificLocalizationDelegate(null);

    /// 保存这个方法的指针，当用户改变语言时，我们可以调用applic.onLocaleChanged(new Locale('en',''));，通过SetState()我们可以强制App整个刷新
    applic.onLocaleChanged = onLocaleChange;
  }

  /// 改变语言时的应用刷新核心，每次选择一种新的语言时，都会创造一个新的SpecificLocalizationDelegate实例，强制Translations类刷新。
  onLocaleChange(Locale locale) {
    setState(() {
      _localeOverrideDelegate = new SpecificLocalizationDelegate(locale);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: Colors.red,
      ),
      home: SplashPage(),

      localizationsDelegates: [
        _localeOverrideDelegate, // 注册一个新的delegate
        const TranslationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      supportedLocales: applic.supportedLocales(),
    );
  }

}





/**
 * 本项目中下拉刷新和加载更多用到了国际化，采用flutter_i18n+json文件进行，国际化的几步：
    1、在pubspec.yaml文件中加入
    flutter_localizations:
    sdk: flutter
    2、在main.dart文件中的MaterialApp中加入对应的配置。
    3、项目目录下assets文件中加入json对应的语言文件 i18n_en.json i18n_zh.json
    4、在 pubspec.yaml文件中加入  assets:下加入
    assets:
    - images/
    - assets/
    5、仿照generated目录下三个文件(注意：Translations文件中的路径需和json文件路径匹配)


 * **/
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:ybwp_flutter/generated/translations.dart';

//由于ClassicsFooter构造方法中key不带@required,非必需，所以key封装在这里面进行统一设置(加载更多用统一样式)
class EasyRefreshFooter extends ClassicsFooter{

//  EasyRefreshFooter() :super();
//
//  final GlobalKey<RefreshFooterState> _footerKey = new GlobalKey<RefreshFooterState>();

  static Widget build(BuildContext context) {
    return  ClassicsFooter(
      key: new GlobalKey<RefreshFooterState>(),
      loadText: Translations.of(context).text("pushToLoad"),
      loadReadyText: Translations.of(context).text("releaseToLoad"),
      loadingText: Translations.of(context).text("loading"),
      loadedText: Translations.of(context).text("loaded"),
      noMoreText: Translations.of(context).text("noMore"),
      moreInfo: Translations.of(context).text("updateAt"),
      bgColor: Colors.transparent,
      textColor: Colors.black87,
      moreInfoColor: Colors.black54,
      showMore: true,
    );
  }




}
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:ybwp_flutter/generated/translations.dart';

//由于ClassicsHeader构造方法中key为@required，所以key从页面传进来(页面中可能刷新样式不一样)，不封装在这里面进行设置
class EasyRefreshHeader extends ClassicsHeader{

  static Widget build({BuildContext buildContext,@required GlobalKey<RefreshHeaderState> headerKey}) {
    return ClassicsHeader(
      key: headerKey,
      refreshText: Translations.of(buildContext).text("pullToRefresh"),
      refreshReadyText: Translations.of(buildContext).text("releaseToRefresh"),
      refreshingText: Translations.of(buildContext).text("refreshing") + "...",
      refreshedText: Translations.of(buildContext).text("refreshed"),
      moreInfo: Translations.of(buildContext).text("updateAt"),
      bgColor: Colors.transparent,
      textColor: Colors.black87,
      moreInfoColor: Colors.black54,
      showMore: true,
    );
  }
}




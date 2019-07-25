import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:ybwp_flutter/model/TestItemModel.dart';

class HonorPage extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    return new _HonorPage();
  }
}

class _HonorPage extends State<HonorPage> with AutomaticKeepAliveClientMixin{

  @override
  void initState() {
    super.initState();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    return new Container(
      child: new WebviewScaffold(
        appBar: AppBar(
          title: Text("WebView页面"),
          elevation: 1,
          centerTitle: true,
          titleSpacing: NavigationToolbar.kMiddleSpacing,
        ),
        url: 'https://www.jianshu.com/p/3de8009947f3',
        withZoom: true,
        withLocalStorage: true,
        withJavascript: true,
        bottomNavigationBar: new Text(''),
      ),
    );
  }
}
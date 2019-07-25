import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class H5Page extends StatefulWidget{

  String title;
  String loadUrl;

  H5Page({Key key,this.title,this.loadUrl}) : super(key:key);

  @override
  State<StatefulWidget> createState() {
    return new WebPageState(title,loadUrl);
  }
}

class WebPageState extends State<H5Page>{

  String _title;
  String _loadUrl;

  //标记是否是加载中
  bool loading = true;

  //标记当前页面是否是我们自定义的回调页面
  bool isLoadingCallbackPage = false;

  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey();

  // URL变化监听器
  StreamSubscription<String> onUrlChanged;

  // WebView加载状态变化监听器
  StreamSubscription<WebViewStateChanged> onStateChanged;

  // 插件提供的对象，该对象用于WebView的各种操作
  FlutterWebviewPlugin flutterWebviewPlugin = new FlutterWebviewPlugin();

  WebPageState(this._title,this._loadUrl);

  @override
  void initState() {
    super.initState();
    onStateChanged = flutterWebviewPlugin.onStateChanged.listen((WebViewStateChanged state){
      switch(state.type){
        case WebViewState.shouldStart:// 准备加载
          setState(() {
            loading = true;
          });
          break;
        case WebViewState.startLoad: //开始加载

          break;
        case WebViewState.finishLoad: //加载完成
          setState(() {
            loading = false;
          });
          if(isLoadingCallbackPage){
            parseResult();
          }
          break;
      }
    });
  }

  void parseResult(){

  }

  @override
  Widget build(BuildContext context) {
    return new WebviewScaffold(
      key: scaffoldKey,
      url: _loadUrl,
      appBar: AppBar(
        title: Text(_title),
        elevation: 1,
        centerTitle: true,
        titleSpacing: NavigationToolbar.kMiddleSpacing,
      ),
      withZoom: true,
      withLocalStorage: true,
      withJavascript: true,
    );
  }

  @override
  void dispose() {
    onUrlChanged.cancel();
    onStateChanged.cancel();
    flutterWebviewPlugin.dispose();
    super.dispose();
  }

}













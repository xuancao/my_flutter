import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_easyrefresh/material_footer.dart';
import 'package:flutter_easyrefresh/material_header.dart';
import 'package:ybwp_flutter/model/TestItemModel.dart';
import 'package:ybwp_flutter/page/bankList/Test_List_Item.dart';


////刷新组件用的三方资源 链接地址：https://github.com/xuelongqy/flutter_easyrefresh
class ListRefreshTestPage extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    return new _ListRefreshTestPage();
  }
}

class _ListRefreshTestPage extends State<ListRefreshTestPage>{

  //// 如果不需要可以不用设置EasyRefresh的key
  ////  触发刷新和加载动作 _easyRefreshKey.currentState.callRefresh();  _easyRefreshKey.currentState.callLoadMore();
  GlobalKey<EasyRefreshState> _easyRefreshKey = new GlobalKey<EasyRefreshState>();

  // 因为EasyRefresh会对Header和Footer进行更新，为了与用户保持统一的操作状态，必须设置key, 不同的Header和Footer可能有不同的参数设置
  GlobalKey<RefreshHeaderState> _headerKey = new GlobalKey<RefreshHeaderState>();
  GlobalKey<RefreshFooterState> _footerKey = new GlobalKey<RefreshFooterState>();

  List<TestItemModel> netDotList = List<TestItemModel>();

  bool isnomore = false;

  int pages = 1;

  int tempIndex = 1;//用于造假数据用

  @override
  void initState() {
    super.initState();
    getListData();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        elevation: 0,
        centerTitle: true,
        title: new Text("成就", style: new TextStyle(fontSize: 20,color: Colors.white),),
      ),
      body: new Center(
        child: new EasyRefresh(
          key: _easyRefreshKey,
          child: _createListView(context),
          onRefresh: () async {
            await onRefresh();
          },
          loadMore: isnomore ? null : () async {
            await loadMore();
          },
//          firstRefresh: true,
//          firstRefreshWidget: new LoadingView(),
          refreshHeader: MaterialHeader(  //EasyRefresh中有很多加载样式，可去github上查看源码
            key: _headerKey,
          ),
          refreshFooter: MaterialFooter(
            key: _footerKey,
          ),
        ),
      ),
    );
  }

//  Future<Null> reset(){
//    netDotList.clear();
//    pages = 1;
//    tempIndex = 1;
//    getListData();
//    setState(() {
//      isnomore = false;
//    });
// //加异步是为了等渲染完成后再进行操作，即使延迟时间为0秒。防止RefreshIndicator为空，也就是图层还没渲染完成，build方法还没执行完，
//    return Future.delayed(Duration(milliseconds: 500),(){ });
//  }

  Future<Null> onRefresh(){
    return new Future.delayed(Duration(milliseconds: 500),(){
      netDotList.clear();
      pages = 1;
      tempIndex = 1;
      setState(() {
        getListData();
        isnomore = false;
      });
    });
  }

  Future<Null> loadMore(){
    pages++;
    return new Future.delayed(const Duration(milliseconds: 500), () {//加异步是为了等渲染完成后再进行操作，即使延迟时间为0秒。防止RefreshIndicator为空，也就是图层还没渲染完成，build方法还没执行完，
      if (pages > 3) {
        _easyRefreshKey.currentState.waitState(() {
          setState(() {
            isnomore = true;
          });
        });
      } else {
        setState(() {
          getListData();
        });
      }
    });
  }

  Widget _createListView(BuildContext context){
    return ListView.builder(
        key: new PageStorageKey("list_refresh-test-page"),
        itemCount: netDotList.length,
        itemBuilder: (BuildContext context,int index){
          return new Test_List_Item(
            netDot: netDotList[index],
            onPressed: (){

            },);
        }
    );
  }

  getListData(){
    for(int i = tempIndex;i<=pages * 10;i++){
      TestItemModel netDot = new TestItemModel();
      netDot.title = "title" + i.toString();
      netDot.category = "category" + i.toString();
      netDot.company = "company" + i.toString();
      netDot.salary = "salary" + i.toString();
      netDot.head = "head" + i.toString();
      netDot.id = i.toString();
      netDot.publish = "publish" + i.toString();
      netDot.info = "info" + i.toString();
      netDotList.add(netDot);
    }
    tempIndex = pages * 10 + 1;
  }

}
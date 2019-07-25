import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:ybwp_flutter/model/TestItemModel.dart';
import 'package:ybwp_flutter/page/bankList/Test_List_Item.dart';
import 'package:ybwp_flutter/widget/EmptyView.dart';
import 'package:ybwp_flutter/widget/easyRefresh/EasyRefreshFooter.dart';
import 'package:ybwp_flutter/widget/easyRefresh/EasyRefreshHeader.dart';


/// 带空视图(列表无数据时展示)和刷新header、footer提示的完整页面
class ListRefreshCompletePage extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    return new _ListRefreshCompletePage();
  }
}

class _ListRefreshCompletePage extends State<ListRefreshCompletePage>{

  final GlobalKey<EasyRefreshState> _easyRefreshKey = new GlobalKey<EasyRefreshState>();
  final GlobalKey<RefreshHeaderState> _headerKey = new GlobalKey<RefreshHeaderState>();

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
        title: new Text("完整简便的刷新加载", style: new TextStyle(fontSize: 20,color: Colors.white),),
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
          refreshHeader: EasyRefreshHeader.build(buildContext: context, headerKey: _headerKey),
          refreshFooter: EasyRefreshFooter.build(context),
          emptyWidget: EmptyView(),
        ),
      ),
    );
  }

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
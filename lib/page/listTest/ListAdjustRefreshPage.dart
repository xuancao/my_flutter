import 'package:flutter/material.dart';
import 'package:ybwp_flutter/model/TestItemModel.dart';
import 'package:ybwp_flutter/page/bankList/Test_List_Item.dart';
import 'package:ybwp_flutter/widget/AdjustRefresh/RefreshLayout.dart';

class ListAdjustRefreshPage extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    return new _ListRefreshAdjustPage();
  }
}

class _ListRefreshAdjustPage extends State<ListAdjustRefreshPage>{

  Key key = GlobalKey();

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
        title: new Text("刷新加载页", style: new TextStyle(fontSize: 20,color: Colors.white),),
      ),
      body: new Center(
        child: RefreshLayout(
          canloading: !isnomore,
          key: key,
          child: _createListView(context),
          onRefresh: (boo){
            if(!boo){
              return loadMore();
            }else{
              return onRefresh();
            }
          },

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
          setState(() {
            isnomore = true;
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
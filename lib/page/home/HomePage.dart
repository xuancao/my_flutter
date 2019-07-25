import 'package:flutter/material.dart';
import 'package:ybwp_flutter/model/TestItemModel.dart';
import 'package:ybwp_flutter/page/bankList/Test_List_Item.dart';
import 'package:ybwp_flutter/page/netDot/NetDotPage.dart';
import 'package:ybwp_flutter/page/potentialCustom/PotentialListPage.dart';
import 'package:ybwp_flutter/utils/NavigatorUtils.dart';

class HomePage extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new _HomePage();
  }
}

class _HomePage extends State<HomePage> with AutomaticKeepAliveClientMixin{

  List<TestItemModel> netDotList = List<TestItemModel>();

  @override
  void initState() {
    super.initState();
    TestItemModel netDot = new TestItemModel();
    netDot.title = "title";
    netDot.category = "category";
    netDot.company = "company";
    netDot.salary = "salary";
    netDot.head = "head";
    netDot.id = "1";
    netDot.publish = "publish";
    netDot.info = "info";
    netDotList.add(netDot);
    TestItemModel netDot1 = new TestItemModel();
    netDot1.title = "title";
    netDot1.category = "category";
    netDot1.company = "company";
    netDot1.salary = "salary";
    netDot1.head = "head";
    netDot1.id = "1";
    netDot1.publish = "publish";
    netDot1.info = "info";
    netDotList.add(netDot1);
    TestItemModel netDot2 = new TestItemModel();
    netDot2.title = "title";
    netDot2.category = "category";
    netDot2.company = "company";
    netDot2.salary = "salary";
    netDot2.head = "head";
    netDot2.id = "1";
    netDot2.publish = "publish";
    netDot2.info = "info";
    netDotList.add(netDot2);
    TestItemModel netDot3 = new TestItemModel();
    netDot3.title = "title";
    netDot3.category = "category";
    netDot3.company = "company";
    netDot3.salary = "salary";
    netDot3.head = "head";
    netDot3.id = "1";
    netDot3.publish = "publish";
    netDot3.info = "info";
    netDotList.add(netDot3);
    TestItemModel netDot4 = new TestItemModel();
    netDot4.title = "title";
    netDot4.category = "category";
    netDot4.company = "company";
    netDot4.salary = "salary";
    netDot4.head = "head";
    netDot4.id = "1";
    netDot4.publish = "publish";
    netDot4.info = "info";
    netDotList.add(netDot4);
    TestItemModel netDot5 = new TestItemModel();
    netDot5.title = "title";
    netDot5.category = "category";
    netDot5.company = "company";
    netDot5.salary = "salary";
    netDot5.head = "head";
    netDot5.id = "1";
    netDot5.publish = "publish";
    netDot5.info = "info";
    netDotList.add(netDot5);
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        elevation: 0,
        centerTitle: true,
        title: new Text("成就", style: new TextStyle(fontSize: 20,color: Colors.white),),
      ),
      body: new Center(
        child: _createListView(context),
      ),
    );
  }

  Widget _createListView(BuildContext context){
    return ListView.builder(
      key: new PageStorageKey("home-list"),
        itemCount: netDotList.length,
        itemBuilder: (BuildContext context,int index){
          return new Test_List_Item(
            netDot: netDotList[index],
            onPressed: (){
              NavigatorUtils.push(context, new PotentialListPage());
          },);
        }
    );
  }

}
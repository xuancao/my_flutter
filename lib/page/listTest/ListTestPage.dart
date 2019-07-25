import 'package:flutter/material.dart';
import 'package:ybwp_flutter/model/TestItemModel.dart';
import 'package:ybwp_flutter/page/bankList/Test_List_Item.dart';

class ListTestPage extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    return new _ListTestPage();
  }
}

class _ListTestPage extends State<ListTestPage>{


  List<TestItemModel> netDotList = List<TestItemModel>();

  @override
  void initState() {
    super.initState();
    for(int i = 0;i<10;i++){
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
        child: _createListView(context),
      ),
    );
  }

  Widget _createListView(BuildContext context){
    return ListView.builder(
        key: new PageStorageKey("achive-list"),
        itemCount: netDotList.length,
        itemBuilder: (BuildContext context,int index){
          return new Test_List_Item(
            netDot: netDotList[index],
            onPressed: (){

            },);
        }
    );
  }
}
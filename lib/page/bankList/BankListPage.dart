import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ybwp_flutter/api/ApiInterface.dart';
import 'package:ybwp_flutter/api/net/ResponseData.dart';
import 'package:ybwp_flutter/model/DotNetModel.dart';
import 'package:ybwp_flutter/page/listTest/ListRefreshCompletePage.dart';
import 'package:ybwp_flutter/utils/NavigatorUtils.dart';

import 'NetDot_Item.dart';

class BankListPage extends StatefulWidget{


  @override
  State<StatefulWidget> createState() {
    return new _BankListState();
  }
}

class _BankListState extends State<BankListPage> with AutomaticKeepAliveClientMixin{

  List<NetDotModel> netDotList = List<NetDotModel>();


  @override
  void initState() {
    super.initState();

    getListData(false);
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        elevation: 0,
        centerTitle: true,
        title: new Text("银行列表", style: new TextStyle(fontSize: 20,color: Colors.white),),
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
          return new NetDot_Item(
            netDot: netDotList[index],
            onPressed: (){
              NavigatorUtils.push(context, new ListRefreshCompletePage());
            },);
        }
    );
  }

  getListData(bool wheShowLoading){
    ApiInterface.getNetDotList(context, "",wheShowLoading, (data){
      ResponseData responseData = data;
      String content = json.encode(responseData.data);
      setData(content);
    });
  }

  setData(String content){
    DotNetNestModel nestModel = DotNetNestModel.fromJson(json.decode(content));
    if(nestModel!=null){
      if (!mounted) { //解决Flutter报错：setState() called after dispose()
        return;
      }
      netDotList.clear();
      netDotList.addAll(nestModel.content);
      setState(() {
      });
    }
  }
}
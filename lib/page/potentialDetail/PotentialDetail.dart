import 'package:flutter/material.dart';
import 'package:ybwp_flutter/model/Potential/PotentialNestModel.dart';
import 'package:ybwp_flutter/resource/RColor.dart';

class PotentialDetailPage extends StatelessWidget{

  PotentialModel nestModel;

  PotentialDetailPage({Key key,this.nestModel}) : super(key:key);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        elevation: 0,
        centerTitle: true,
        title: new Text("客户信息详情", style: new TextStyle(fontSize: 20,color: Colors.white),),
      ),
      body: Container(
        color: new Color(RColor.white),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            new Padding(
                padding: EdgeInsets.only(left: 15,top: 10,right: 15,bottom: 10),
                child: new Text("所在网点",style: new TextStyle(fontSize: 15,color: Color(RColor.black)),)
            ),
            new Padding(
              padding: EdgeInsets.only(left: 15,),
              child: Divider(height: 1, color: Color(RColor.lineColor),)
            ),
            Padding(
              padding: EdgeInsets.only(left: 15,top: 10,right: 15,bottom: 15),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  CircleAvatar(
//                  backgroundColor: Color(int.parse(model.bankLogoColor.replaceAll("#", "0xff"))),
                    child: Text(nestModel.bankLogo,style: new TextStyle(color: Color(RColor.white),fontSize: 10),),
                    radius: 12,
                  ),
                  new Padding(
                    padding: EdgeInsets.only(left: 5),
                    child: Text(nestModel.networkName, style: new TextStyle(color: Color(RColor.black),fontSize: 15),
                    ),
                  )
                ],
              ),
            ),
            new Divider(height: 10,color:  Color(RColor.lineColor),),
            Padding(
              padding: EdgeInsets.all(15),
              child: new Row(
                children: <Widget>[
                  Expanded(child: new Text("姓名",style: new TextStyle(color: Color(RColor.black),fontSize: 15),)),
                  new Text(nestModel.name,style: new TextStyle(color: Color(RColor.black),fontSize: 15),)
                ],
              ),
            ),
            new Padding(
                padding: EdgeInsets.only(left: 15,),
                child: Divider(height: 1, color: Color(RColor.lineColor),)
            ),
            Padding(
              padding: EdgeInsets.all(15),
              child: new Row(
                children: <Widget>[
                  Expanded(child: new Text("性别",style: new TextStyle(color: Color(RColor.black),fontSize: 15),)),
                  new Text("1" == nestModel.sex ? "男" : "女",style: new TextStyle(color: Color(RColor.black),fontSize: 15),)
                ],
              ),
            ),
            new Padding(
                padding: EdgeInsets.only(left: 15,),
                child: Divider(height: 1, color: Color(RColor.lineColor),)
            ),
            Padding(
              padding: EdgeInsets.all(15),
              child: new Row(
                children: <Widget>[
                  Expanded(child: new Text("添加时间",style: new TextStyle(color: Color(RColor.black),fontSize: 15),)),
                  new Text(nestModel.createDate,style: new TextStyle(color: Color(RColor.black),fontSize: 15),)
                ],
              ),
            ),
            new Padding(
                padding: EdgeInsets.only(left: 15,),
                child: Divider(height: 1, color: Color(RColor.lineColor),)
            ),

          ],
        ),
      ),
    );
  }



}
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ybwp_flutter/events/SwitchBtnEvent.dart';
import 'package:ybwp_flutter/model/User/db/UserDBHelper.dart';
import 'package:ybwp_flutter/resource/RColor.dart';

import '../Constant.dart';
import 'MineCenter.dart';
import 'MineMenu.dart';
import 'MineTop.dart';

class MinePage extends StatefulWidget{


  @override
  State<StatefulWidget> createState() {
    return new _MinePageState();
  }
}

class _MinePageState extends State<MinePage> with AutomaticKeepAliveClientMixin{

  String userName;
  String userHeadUrl;
  String mCompany;
  String mID;
  bool mWheShowSex = false;

  StreamSubscription _switchBtnEvent;

  @override
  void initState() {
    super.initState();
    _initEvents();
    _getUSerInfo();
  }

  _getUSerInfo(){
//    UserSpferUtils.getUserName().then((username){
//      setState(() {
//        userName = username;
//      });
//    });
//    UserSpferUtils.getUserHeadUrl().then((userHeadurl){
//      setState(() {
//        userHeadUrl = userHeadurl;
//      });
//    });
//    UserSpferUtils.getCompany().then((company){
//      setState(() {
//        mCompany = company;
//      });
//    });
    UserDBHelper.getInstance().getUser().then((user){
      setState(() {
        userName = user.realName;
        userHeadUrl = user.imgUrl;
        mCompany = user.company;
        mID = user.id;
      });
    });
  }

  @override
  Widget build(BuildContext context) {

    return new Scaffold(
      backgroundColor: new Color(RColor.common_f5f5f5),
      body: new CustomScrollView(
        slivers: <Widget>[
          new MineTop(
            userName: userName,
            userHeadUrl: userHeadUrl,
            mCompany: mCompany,
            mID: mID,
            mWheShowSex: mWheShowSex,
          ),
          new SliverList(
              delegate: new SliverChildListDelegate(<Widget>[
                new MineCenter(),
                new MineMenu(),
              ]),
          ),
        ],
      ),
    );
  }


  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  _initEvents(){
    _switchBtnEvent = Constant.eventBus.on<SwitchBtnEvent>().listen((event){
      setState(() {
        mWheShowSex = event.isChecked;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _switchBtnEvent.cancel();
  }

}
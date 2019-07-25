import 'package:flutter/material.dart';
import 'package:ybwp_flutter/resource/Drawable.dart';
import 'package:ybwp_flutter/resource/RColor.dart';

class MineTop extends StatelessWidget{

  double _appBarHeight = 180;
  String _defaultHeadUrl = "http://pic132.nipic.com/file/20170610/25460683_171223590238_2.jpg";

  String userName;
  String userHeadUrl;
  String mCompany;
  String mID;
  bool mWheShowSex;

  MineTop({Key key,this.userName,this.userHeadUrl,this.mCompany,this.mID,this.mWheShowSex}) : super(key:key);

  @override
  Widget build(BuildContext context) {
    Padding sexPadding = new Padding(
      padding: const EdgeInsets.only(left: 15),
      child: new Text(
        mID == null ? "" : mID,
        style: new TextStyle(color: Colors.white,fontSize: 15),
      ),
    );
    return new SliverAppBar(
      expandedHeight: _appBarHeight,
      flexibleSpace: new FlexibleSpaceBar(
        collapseMode: CollapseMode.parallax,
        background: new Stack(
          fit: StackFit.expand,
          children: <Widget>[
            const DecoratedBox(
                decoration: const BoxDecoration(
                  gradient: const LinearGradient(
                    colors: const <Color>[const Color(RColor.transparent),const Color(RColor.transparent)],
                    begin: const Alignment(0, -1),
                    end: const Alignment(0, -0.4),
                  ),
                )
            ),
            new Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                new Expanded(
                  flex: 3,
                  child: new Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      new Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: new Text(
                          userName==null ?"萱草":userName,
                          style: new TextStyle(color: Colors.white,fontSize: 25,fontWeight: FontWeight.bold),
                        ),
                      ),
                      new Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: new Text(
                          mCompany == null ? "安邦人寿保险股份有限公司":mCompany,
                          style: new TextStyle(color: Colors.white,fontSize: 15),
                        ),
                      ),
                      mWheShowSex ? sexPadding : new Container(),
                    ],
                  ),
                ),
                new Expanded(
                  flex: 1,
                  child: new Padding(
                    padding: const EdgeInsets.only(right: 30),
                    child:new ClipOval(
                      child: new FadeInImage.assetNetwork(
                        placeholder: Drawable.DRAWABLE_IC_AVATAR,//预览图
                        fit: BoxFit.fitWidth,
                        image:(userHeadUrl == null || userHeadUrl.isEmpty) ? _defaultHeadUrl : userHeadUrl,
                        width: 60.0,
                        height: 60.0,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

}

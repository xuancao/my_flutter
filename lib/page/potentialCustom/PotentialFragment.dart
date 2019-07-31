import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:ybwp_flutter/api/ApiInterface.dart';
import 'package:ybwp_flutter/api/net/ResponseData.dart';
import 'package:ybwp_flutter/model/Potential/PotentialNestModel.dart';
import 'package:ybwp_flutter/model/User/db/UserDBHelper.dart';
import 'package:ybwp_flutter/page/potentialCustom/Potential_Item.dart';
import 'package:ybwp_flutter/page/potentialDetail/PotentialDetail.dart';
import 'package:ybwp_flutter/utils/NavigatorUtils.dart';
import 'package:ybwp_flutter/widget/EmptyView.dart';
import 'package:ybwp_flutter/widget/easyRefresh/EasyRefreshFooter.dart';
import 'package:ybwp_flutter/widget/easyRefresh/EasyRefreshHeader.dart';

class PotentialFragment extends StatefulWidget{

  int topicIndex;
  PotentialFragment({Key key,this.topicIndex}) : super(key:key);

  @override
  State<StatefulWidget> createState() {
    return new _PotentialFragmentState(mTopicIndex: topicIndex);
  }
}

class _PotentialFragmentState extends State<PotentialFragment>{

  final GlobalKey<EasyRefreshState> _easyRefreshKey = new GlobalKey<EasyRefreshState>();
  final GlobalKey<RefreshHeaderState> _headerKey = new GlobalKey<RefreshHeaderState>();

  int mTopicIndex;
  String mMemberId;

  _PotentialFragmentState({this.mTopicIndex});

  bool isnomore = false;

  int mCurrentPage = 1;


  List<PotentialModel> netDotList = List<PotentialModel>();

  @override
  void initState() {
    super.initState();

    UserDBHelper.getInstance().getUser().then((user){
      setState(() {
        mMemberId = user.id;
        getListData(true);
      });
    });

  }

  @override
  Widget build(BuildContext context) {
    return  new EasyRefresh(
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
    );
  }

  Future<Null> onRefresh(){
    return new Future.delayed(Duration(milliseconds: 500),(){
      mCurrentPage = 1;
      getListData(false);
    });
  }

  Future<Null> loadMore(){
    mCurrentPage++;
    return new Future.delayed(const Duration(milliseconds: 500), () {//加异步是为了等渲染完成后再进行操作，即使延迟时间为0秒。防止RefreshIndicator为空，也就是图层还没渲染完成，build方法还没执行完，
      getListData(false);
    });
  }

  Widget _createListView(BuildContext context){
    return ListView.builder(
        key: new PageStorageKey("potential_fragment"),
        itemCount: netDotList.length,
        itemBuilder: (BuildContext context,int index){
          return new Potential_Item(
            model: netDotList[index],
            onPressed: (){
              NavigatorUtils.push(context, new PotentialDetailPage(nestModel: netDotList[index],));
            },
          );
        }
    );
  }


  getListData(bool wheShowLoading){
    ApiInterface.getPotentialList(context, mMemberId, mTopicIndex,mCurrentPage,wheShowLoading, (data){
      ResponseData responseData = data;
      String content = json.encode(responseData.data);
//      print("content = "+ content);
      setData(content);
    });
  }

  setData(String content){
    PotentialNestModel nestModel = PotentialNestModel.fromJson(json.decode(content));
    if(nestModel!=null){
      if (!mounted) { //解决Flutter报错：setState() called after dispose()
        return;
      }
      setState(() {
        if(mCurrentPage >= nestModel.total){
          isnomore = true;
        }else{
          isnomore = false;
        }
        if(mCurrentPage == 1){
          netDotList.clear();
        }
        netDotList.addAll(nestModel.list);
      });
    }
  }
}
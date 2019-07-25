import 'package:flutter/material.dart';
import 'package:ybwp_flutter/model/TestItemModel.dart';
import 'package:ybwp_flutter/page/bankList/Test_List_Item.dart';
import 'package:ybwp_flutter/resource/Drawable.dart';
import 'package:ybwp_flutter/resource/RColor.dart';

class NetDotPage extends StatefulWidget{

  @override
  State<StatefulWidget> createState() => new _NetDotPage();
}

class _NetDotPage extends State<NetDotPage> with SingleTickerProviderStateMixin{

  int _currentIndex = -1;
  TabController _tabController;

  List<String> _tabs;
  List<TestItemModel> netDotList = List<TestItemModel>();
  int ItemSize = 30;

  @override
  void initState() {
    super.initState();
    _tabs = ['名称排序','价值排序'];

    _tabController = new TabController(length: _tabs.length, vsync: this);
    _tabController.addListener((){
      if(_currentIndex!=_tabController.index){
        _currentIndex = _tabController.index;
      }
    });


    for(int i = 0;i<ItemSize;i++){
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
    return Scaffold(
      backgroundColor: Color(RColor.white),
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context,bool innerBoxIsScrolled){
          return <Widget>[
            SliverOverlapAbsorber(
              handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
              child: SliverAppBar(
                title: const Text('银行列表'),
                centerTitle: true,
                pinned: true,// 固定顶部appbar
                expandedHeight: 230.0,//展开显示面板的最大高度
                forceElevated: innerBoxIsScrolled, // appbar底部阴影
                bottom: TabBar(
                  indicatorColor: Color(RColor.white),
                  indicatorSize: TabBarIndicatorSize.label,
                  controller: _tabController,
                  tabs: _tabs.map((String name){
                    return Tab(text:name);
                  }).toList(),
                ),
                leading: IconButton(
                  onPressed: (){
                    Navigator.of(context).pop(true);
                  },
                  padding: const EdgeInsets.all(12.0),
                  icon: Image.asset(Drawable.DRAWABLE_IC_BACK,width: 20,height: 20,),
                ) ,
                flexibleSpace: FlexibleSpaceBar(
                  background: Image.network(
                    'https://ss0.bdstatic.com/70cFvHSh_Q1YnxGkpoWK1HF6hhy/it/u=2969356121,954987121&fm=26&gp=0.jpg',
                    filterQuality: FilterQuality.high,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
          ];
        },
        body: TabBarView(
          controller: _tabController,
          children: _tabs.map((String name){
            return SafeArea(
              child: Builder(
                  builder: (BuildContext context){
                    return CustomScrollView(
                      key: PageStorageKey<String>(name),
                      slivers: <Widget>[
                        SliverOverlapInjector(handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context)),
                        SliverPadding(
                          padding: const EdgeInsets.all(8),
                          sliver: SliverFixedExtentList(
                            itemExtent: 154.0,
                            delegate: SliverChildBuilderDelegate(
                                  (BuildContext context,int index){
                                return new Test_List_Item(
                                  netDot: netDotList[index],
                                  onPressed: (){

                                  },
                                );
                              },
                              childCount: ItemSize,
                            ),
                          ),
                        ),
                      ],
                    );
                  }
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

}
import 'package:flutter/material.dart';
import 'package:ybwp_flutter/page/potentialCustom/PotentialFragment.dart';
import 'package:ybwp_flutter/resource/RColor.dart';

class PotentialListPage extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    return new _PotentialListState();
  }
}

class _PotentialListState extends State<PotentialListPage> with SingleTickerProviderStateMixin{

  final GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>();

  List _topicList= getTopics();
  int _currentIndex = -1;
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(length: _topicList.length, vsync: this);
    _tabController.addListener((){
      if(_currentIndex!=_tabController.index){
        _currentIndex = _tabController.index;
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(RColor.white),
      key: _scaffoldkey,
      appBar: new AppBar(
        elevation: 0,
        centerTitle: true,
        title: new Text("客户清单", style: new TextStyle(fontSize: 20,color: Colors.white),),
      ),
      body: Column(
        children: <Widget>[
          PreferredSize(
            preferredSize: Size.fromHeight(kToolbarHeight),
            child: Container(
              color: Color(RColor.common_f5f5f5),
              child: SafeArea(child: this._TabBar()),
            ),
          ),
          this._TabView()
        ],
      ),
    );
  }

  Widget _TabBar(){
    return TabBar(
      indicatorColor: Color(RColor.indicatorColor),
      indicatorSize: TabBarIndicatorSize.label,
//      indicatorWeight: 3,
//      indicatorPadding: EdgeInsets.fromLTRB(5, 0, 5, 0),
      controller: _tabController,
      isScrollable: true,
      labelColor: Color(RColor.main_color),
      unselectedLabelColor: Color(RColor.black),
      tabs: _topicList.map<Widget>((item){
        return item;
      }).toList(),
    );
  }

  Widget _TabView(){
    return Expanded(
      child: new TabBarView(
          controller: _tabController,
          children: List.generate(_topicList.length, (index){
            return new PotentialFragment(topicIndex:index);
          })
//        children: _topicList.map((item) {
//          return Stack(children: <Widget>[
//            Align(alignment:Alignment.topCenter,child: Text("ddddd"),),
//          ],);
//        }).toList(),
      ),
    );
  }



}

List getTopics(){
  List<Widget> topics =[];
  topics.add(new Tab(text: "名单",));
  topics.add(new Tab(text: "触达",));
  topics.add(new Tab(text: "意向",));
  topics.add(new Tab(text: "多次",));
  topics.add(new Tab(text: "签单",));
  topics.add(new Tab(text: "记账",));
  topics.add(new Tab(text: "回访",));

  return topics;
}

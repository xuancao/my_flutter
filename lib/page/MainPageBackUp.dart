
import 'package:flutter/material.dart';
import 'package:ybwp_flutter/page/home/HomePage.dart';
import 'package:ybwp_flutter/page/honor/HonorPage.dart';
import 'package:ybwp_flutter/page/mine/MinePage.dart';
import 'package:ybwp_flutter/resource/RColor.dart';

import 'bankList/BankListPage.dart';
//切换底部Tab不重新绘制页面的类实现
class MainPageBackUp extends StatefulWidget {
  MainPageBackUp({Key key, this.title}) : super(key: key);

  final String title;

  @override
  State<StatefulWidget> createState() {
    return new _MainPageState();
  }
}

enum LayoutType{
  home,
  achievement,
  trump,
  mine,
}

class _MainPageState extends State<MainPageBackUp>{

  PageController _controller;
  List<Widget> _pages;
  LayoutType _layoutSelection = LayoutType.home;

  @override
  void initState() {
    super.initState();
    _pages = List()..add(HomePage())..add(BankListPage())..add(HonorPage())..add(MinePage());
    _controller = PageController(initialPage: 0);
  }


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: _buildBody(),
      bottomNavigationBar: _buildButtonNavBar(),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

//  Widget _buildBody(){
//    LayoutType layoutSelection = _layoutSelection;
//    switch(layoutSelection){
//      case LayoutType.home:
//        return HomePage();
//      case LayoutType.achievement:
//        return AchiveMentPage();
//      case LayoutType.trump:
//        return HonorPage();
//      case LayoutType.mine:
//        return MinePage();
//    }
//  }

  Widget _buildBody(){
    return PageView.builder(
        physics: NeverScrollableScrollPhysics(),//viewPage禁止左右滑动
        controller: _controller,
        itemCount: _pages.length,
        itemBuilder: (context, index) => _pages[index]);
  }

  Widget _buildButtonNavBar(){
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      items: [
        _buildItem(
            icon: _layoutSelection == LayoutType.home ? "images/tab_home_select.png" :"images/tab_home.png",
            layoutSelection: LayoutType.home
        ),
        _buildItem(
            icon: _layoutSelection == LayoutType.achievement ? "images/tab_achieve_select.png" :"images/tab_achieve.png",
            layoutSelection: LayoutType.achievement
        ),
        _buildItem(
            icon: _layoutSelection == LayoutType.trump ? "images/tab_honor_select.png" :"images/tab_honor.png",
            layoutSelection: LayoutType.trump
        ),
        _buildItem(
            icon: _layoutSelection == LayoutType.mine ? "images/tab_mine_select.png" :"images/tab_mine.png",
            layoutSelection: LayoutType.mine
        ),
      ],
      onTap: _onSelectTab,
    );
  }

  void _onSelectTab(int index){
    _controller.jumpToPage(index);
    switch (index){
    case 0:
    _onLayoutSelected(LayoutType.home);
    break;
    case 1:
    _onLayoutSelected(LayoutType.achievement);
    break;
    case 2:
    _onLayoutSelected(LayoutType.trump);
    break;
    case 3:
    _onLayoutSelected(LayoutType.mine);
    break;
    }
  }

  void _onLayoutSelected(LayoutType selection){
    setState(() {
      _layoutSelection = selection;
    });
  }

  String layoutName (LayoutType layoutType){
    switch (layoutType){
      case LayoutType.home:
        return '首页';
      case LayoutType.achievement:
        return '银行';
      case LayoutType.trump:
        return '荣誉';
      case LayoutType.mine:
        return '我的';
      default:
        return '';
    }
  }


  Color _colorTabMatching({LayoutType layoutSelection}){
    return _layoutSelection == layoutSelection ?  new Color(RColor.main_color) : new Color(RColor.black);
  }

  BottomNavigationBarItem _buildItem({String icon,LayoutType layoutSelection}){
    String text = layoutName(layoutSelection);
    return BottomNavigationBarItem(
      icon: new Image.asset(icon,width: 25,height: 25,),
      title: Text(text,style: TextStyle(color: _colorTabMatching(layoutSelection: layoutSelection)),),
    );
  }










}

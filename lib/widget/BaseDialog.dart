

import 'package:flutter/material.dart';
import 'package:ybwp_flutter/resource/RColor.dart';
import 'package:ybwp_flutter/resource/Style.dart';

class BaseDialog extends StatelessWidget{

  BaseDialog({
    Key key,
    this.title,
    this.onPressed,
    this.height,
    this.hiddenTitle : false,
    @required this.child
  }) : super(key : key);

  final String title;
  final Function onPressed;
  final Widget child;
  final double height;
  final bool hiddenTitle;

  @override
  Widget build(BuildContext context) {
    return Scaffold(//创建透明层
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.transparent,
      // 键盘弹出收起动画过渡
      body: AnimatedContainer(
        alignment: Alignment.center,
        height: MediaQuery.of(context).size.height - MediaQuery.of(context).viewInsets.bottom,
        duration: const Duration(milliseconds: 120),
        curve: Curves.easeInCubic,
        child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.0),
            ),
            width: 270.0,
            height: height,
            padding: const EdgeInsets.only(top: 24.0),
            child: Column(
              children: <Widget>[
                Offstage(
                  offstage: hiddenTitle,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Text(
                      hiddenTitle ? "" : title,
                      style: new TextStyle(fontSize: 18.0,color: Color(RColor.black)),
                    ),
                  ),
                ),
                Expanded(child: child),
                Gaps.vGap8,
                Gaps.line,
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        height: 48.0,
                        child: FlatButton(
                          child: Text(
                            "取消",
                            style: TextStyle(
                                fontSize: 18.0
                            ),
                          ),
                          textColor: Color(RColor.gry),
                          onPressed: (){
                            Navigator.pop(context);
                          },
                        ),
                      ),
                    ),
                    Container(
                      height: 48.0,
                      width: 0.6,
                      color:  Color(RColor.lineColor),
                    ),
                    Expanded(
                      child: Container(
                        height: 48.0,
                        child: FlatButton(
                          child: Text(
                            "确定",
                            style: TextStyle(
                                fontSize: 18.0
                            ),
                          ),
                          textColor: Color(RColor.main_color),
                          onPressed: (){
                            onPressed();
                          },
                        ),
                      ),
                    )
                  ],
                )
              ],
            )
        ),
      ),
    );
  }
}
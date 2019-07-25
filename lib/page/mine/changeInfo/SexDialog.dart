import 'package:flutter/material.dart';
import 'package:ybwp_flutter/resource/Drawable.dart';
import 'package:ybwp_flutter/resource/Fonts.dart';
import 'package:ybwp_flutter/resource/RColor.dart';
import 'package:ybwp_flutter/resource/Style.dart';
import 'package:ybwp_flutter/utils/ImagesUtils.dart';
import 'package:ybwp_flutter/widget/BaseDialog.dart';

class SixDialog extends StatefulWidget{

  SixDialog({Key key, this.value, this.onPressed,}) : super(key : key);

  int value;
  final Function(int, String) onPressed;


  @override
  State<StatefulWidget> createState() => new _SexDialogState(value);
}

class _SexDialogState extends State<SixDialog>{
  int _value = 0;
  var _list = ["男", "女"];

  _SexDialogState(this._value);

  Widget getItem(int index){
    return Material(
      type: MaterialType.transparency,
      child: InkWell(
        child: Container(
          height: 42.0,
          child: Row(
            children: <Widget>[
              Gaps.hGap16,
              Expanded(
                child: Text(
                  _list[index],
                  style: _value == index
                      ? new TextStyle(fontSize: Fonts.FONT_SIZE_14,color: Color(RColor.main_color))
                      : new TextStyle(fontSize: Fonts.FONT_SIZE_14,color: Color(RColor.common_666666)),
                ),
              ),
              Offstage(
                  offstage: _value != index,
                  child: loadAssetImage(Drawable.DRAWABLE_IC_DIALOG_CHECK, width: 16.0, height: 16.0)),
              Gaps.hGap16,
            ],
          ),
        ),
        onTap: (){
          if (mounted) {
            setState(() {
              _value = index;
            });
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BaseDialog(
      title: "选择性别",
      height: 205.0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          getItem(0),
          getItem(1),
        ],
      ),
      onPressed: (){
        widget.onPressed(_value, _list[_value]);
        Navigator.pop(context);
      },
    );
  }
}
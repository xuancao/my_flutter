
import 'package:flutter/material.dart';
import 'package:ybwp_flutter/resource/RColor.dart';
import 'package:ybwp_flutter/utils/ToastUtils.dart';
import 'package:ybwp_flutter/utils/number_text_input_formatter.dart';
import 'package:ybwp_flutter/widget/BaseDialog.dart';

class InputNameDialog extends StatefulWidget{

  InputNameDialog({
    Key key,
    this.title,
    this.name,
    this.onPressed,
  }) : super(key : key);

  final String title;
  final String name;
  final Function(String) onPressed;

  @override
  State<StatefulWidget> createState() => _InputNameDialog();

  
}

class _InputNameDialog extends State<InputNameDialog>{

  TextEditingController _controller = new TextEditingController();
  FocusNode _contentFocusNode = FocusNode();
  
  @override
  Widget build(BuildContext context) {
    return BaseDialog(
      title: widget.title,
      height: 160.0,
      child: Container(
        height: 34.0,
        margin: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 0.0),
        decoration: BoxDecoration(
          color: Color(0xFFFAFAFA),
          borderRadius: BorderRadius.circular(2.0),
        ),
        child: TextField(
          autofocus: true,
          focusNode: _contentFocusNode,
          controller: _controller,
          maxLines: 1,
//          keyboardType: TextInputType.numberWithOptions(decimal: true),
//          // 金额限制数字格式
//          inputFormatters: [UsNumberTextInputFormatter()],
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.only(top: 8.0, left: 16.0, right: 16.0),
            border: InputBorder.none,
            hintText: "输入${widget.title}",
            hintStyle: new TextStyle(fontSize: 14.0,color: Color(RColor.gry)),
          ),
        ),
      ),
      onPressed: (){
        if (_controller.text.isEmpty){
          ToastUtils.showToast("请输入${widget.title}");
          return;
        }
        widget.onPressed(_controller.text);
        _contentFocusNode.unfocus(); //隐藏键盘
        Navigator.pop(context);
      },
    );
  }
}
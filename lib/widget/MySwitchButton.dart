import 'package:flutter/material.dart';

class MySwitchButtton extends StatelessWidget{

  bool checked;
  ValueChanged<bool> onChanged;

  MySwitchButtton({Key key,@required this.checked,@required this.onChanged}):super(key:key);

  @override
  Widget build(BuildContext context) {
    return Switch(
        value: checked,
        onChanged: onChanged,
        activeColor: Colors.red,
        activeTrackColor:Colors.red,
        inactiveThumbColor:Colors.grey,
        inactiveTrackColor: Colors.grey,
//        activeThumbImage: AssetImage(
//          'images/1.png',
//        ),
    );
  }

}
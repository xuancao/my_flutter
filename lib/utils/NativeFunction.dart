//调用native原生方法
//@author lxl
import 'package:flutter/services.dart';

//登录加密
const String methodName = "ACTION_DES";
const String PARAMS_PWD = "PARAMS_PWD";

const MethodChannel LoginChannel = MethodChannel("com.nativefunction/plugin");

class NativeFunction {

  /**
   * 调用Android、Ios本地方法分别进行加密操作
   */
  static Future<String> DESPwd(String pwd) async {
    Map<String, String> map = {PARAMS_PWD: pwd};
    String result = await LoginChannel.invokeMethod(methodName, map);
    return result;
  }


}



//错误编码
//@author lxl
import 'package:event_bus/event_bus.dart';
import 'package:ybwp_flutter/events/HttpErrorEvent.dart';

class ResponseCode {
  //网络错误
  static const NETWORK_ERROR = -1;

  //网络超时
  static const NETWORK_TIMEOUT = -2;

  //服务器约定Code
  static const DATA_FAIL = 0;
  static const DATA_SUCCESS = 1;
  static const TOKEN_TIMEOUT = 10000;

  static final EventBus eventBus = new EventBus();

  static errorHandleFunction(code, message, noTip) {
    if(noTip) {
      return message;
    }
    eventBus.fire(new HttpErrorEvent(code, message));
    return message;
  }
}

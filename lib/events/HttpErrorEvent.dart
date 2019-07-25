
//网络错误通知event
//@author lxl

class HttpErrorEvent {

  final int code;

  final String message;

  HttpErrorEvent(this.code, this.message);
}
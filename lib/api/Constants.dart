
//网络环境枚举
//@author lxl
class Constants {
  //不同环境host
  static final String _devHost =    "xxxx";
  static final String _datHost =    "xxxx";
  static final String _uatHost =    "xxxx";
  static final String _virHost =    "xxxx";
  static final String _onlineHost = "xxxx";


  //获取对应的host
  static String getHost(int hostType) {
    String host;
    switch (hostType) {
      case 0:
        host = _devHost;
        break;
      case 1:
        host = _datHost;
        break;
      case 2:
        host = _uatHost;
        break;
      case 3:
        host = _virHost;
        break;
      case 4:
        host = _onlineHost;
        break;
      default:
        host = _onlineHost;
        break;
    }
    return host;
  }

}
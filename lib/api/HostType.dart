//网络环境切换
//@author lxl
class HostType {
  static final int _host_type_dev = 0;
  static final int _host_type_dat = 1;
  static final int _host_type_uat = 2;
  static final int _host_type_vir = 3;
  static final int _host_type_online = 4;

  static final int _host_type = _host_type_dat;

  static int hostType(){
    return _host_type;
  }
}
//数据为空判断
//@author lxl
class StringUtils {
  static bool isNotEmpty(String text) {
    if (text != null && text.isNotEmpty && text.toLowerCase() != "null" && text.length != 0) {
      return true;
    }
    return false;
  }

}

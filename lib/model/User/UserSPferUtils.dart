
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ybwp_flutter/model/User/UserEntity.dart';
import 'package:ybwp_flutter/model/User/db/UserDBHelper.dart';
import 'package:ybwp_flutter/utils/StringUtils.dart';

class UserSpferUtils{

  static const String IS_LOGIN = "isLogin";
  static const String USERNAME = "userName";
  static const String HEADURL = "headUrl";
  static const String COMPANY = "company";

  static const String spKeyToken = "_sp_token";
  static const String ROLETYPE = "roleType";
  static const String MANAFER_MemberId = "managerMemberId";
  static const String COMPANY_ID = "companyId";

  //保存请求头所需参数到spf中
  static Future saveUserInfoHeader(String token,String roleType,String managerMemberId,String companyId) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    await sp.setString(spKeyToken, token);
    await sp.setString(ROLETYPE, roleType);
    await sp.setString(MANAFER_MemberId, managerMemberId);
    await sp.setBool(COMPANY_ID, true);
  }

  // 保存用户登录信息，data中包含了userName
  static Future saveLoginInfo(String userName,String headUrl,String company) async {
    print('isLogin');
    SharedPreferences sp = await SharedPreferences.getInstance();
    await sp.setString(USERNAME, userName);
    await sp.setString(HEADURL, headUrl);
    await sp.setString(COMPANY, company);
    await sp.setBool(IS_LOGIN, true);
  }

  static Future saveToken(String token) async{
    print("token");
    SharedPreferences sp = await SharedPreferences.getInstance();
    await sp.setString(spKeyToken, token);
  }

  static Future getToken() async{
    SharedPreferences sp = await SharedPreferences.getInstance();
    print("token:"+sp.getString(spKeyToken));
    return sp.getString(spKeyToken);
  }

  static Future getRoleType() async{
    SharedPreferences sp = await SharedPreferences.getInstance();
    print("roleType:"+sp.getString(ROLETYPE));
    return sp.getString(ROLETYPE);
  }

  static Future getManagerMemberId() async{
    SharedPreferences sp = await SharedPreferences.getInstance();
    print("managerMemberId:"+sp.getString(MANAFER_MemberId));
    return sp.getString(MANAFER_MemberId);
  }

  static Future getCompanyId() async{
    SharedPreferences sp = await SharedPreferences.getInstance();
    print("companyId:"+sp.getString(COMPANY_ID));
    return sp.getString(COMPANY_ID);
  }

  static Future clearLoginInfo() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    print('clean');
    return sp.clear();
  }

  static Future<String> getUserHeadUrl() async{
    SharedPreferences sp = await SharedPreferences.getInstance();
    return sp.getString(HEADURL);
  }

  static Future<String> getUserName() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    return sp.getString(USERNAME);
  }

  static Future<String> getCompany() async{
    SharedPreferences sp = await SharedPreferences.getInstance();
    return sp.getString(COMPANY);
  }


//  static Future<bool> isLogin() async {
//    SharedPreferences sp = await SharedPreferences.getInstance();
//    bool b = sp.getBool(IS_LOGIN);
//    return true == b;
//  }

  static isLogin() async {
    UserBeanEntity user = await UserDBHelper.getInstance().getUser();
    return user != null && StringUtils.isNotEmpty(user.id);
//  return false;
  }
}
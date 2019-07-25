
import 'package:ybwp_flutter/model/User/UserSPferUtils.dart';

import '../Constants.dart';
import '../HostType.dart';

//网络配置
//@author lxl
class Config {

  static final debug = true;


  static final int connectTimeout = 5000;
  static final int receiveTimeout = 5000;

  static final String baseUrl = Constants.getHost(HostType.hostType());


  static const String GET = "get";
  static const String POST = "post";
  static const String PUT = "put";
  static const String DELETE = "delete";

  static const String CODE = "code";
  static const String MSG = "msg";
  static const String CONTENT = "content";


  ///=========header设置====start=============
  static String mToken;
  static String mRoleType;
  static String mManagerMemberId;
  static String mCompanyId;

  static Map<String, dynamic> headers = {
    'version':"1.1.6-debug",
    'token': mToken,
    'roleType': mRoleType,
    'managerMemberId': mManagerMemberId,
    'branchId': '',
    'companyId': mCompanyId
  };

  static readSfpHeaders() async{
    mToken = await UserSpferUtils.getToken();
    mRoleType = await UserSpferUtils.getRoleType();
    mManagerMemberId = await UserSpferUtils.getManagerMemberId();
    mCompanyId = await UserSpferUtils.getCompanyId();
  }

  static setRequestHeander(String token,String roleType,String managerMemberId,String companyId){
    mToken = token;
    mRoleType = roleType;
    mManagerMemberId = managerMemberId;
    mCompanyId = companyId;
  }
///=========header设置====end=============

}
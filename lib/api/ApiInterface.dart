
//网络API
//@author lxl
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:ybwp_flutter/api/net/NetWork.dart';
import 'package:ybwp_flutter/utils/NativeFunction.dart';

class ApiInterface {

  /// 分页条数默认10
  static final int DEFAULT_PAGE_SIZE = 10;

  // 登录
  static final String _apiLogin = 'member/login';
  static login (BuildContext context,String userName, String password, bool wheShowLoading,Function successCallBack) async{
    String  pwd = await NativeFunction.DESPwd(password);
    FormData formData = FormData.from({'userName': userName, 'password':pwd});
    NetWork.getInstance().wheShowLoadDialog(wheShowLoading).buildContext(context);
    NetWork.getInstance().get(_apiLogin,successCallBack, params: formData);

  }

  //
  static final String _apiPotentialList = "member/potentialCustomer/list";
  static getPotentialList(BuildContext context,String memberId,int topicStatus,int currentPage,bool wheShowLoading,Function successCallBack) async{
    FormData formData = FormData.from({
      'networkId': "",
      'memberId':memberId,
      'startDate':"",
      'endDate':"",
      'keyword':"",
      'status':topicStatus.toString(),
      'dateType':"all",
      'currentPage':currentPage,
      'pageSize':DEFAULT_PAGE_SIZE
    });
    NetWork.getInstance().wheShowLoadDialog(wheShowLoading).buildContext(context);
    NetWork.getInstance().get(_apiPotentialList,successCallBack, params: formData);
  }


  static final String _apiNetDotList = "member/myNetworkList";
  static getNetDotList(BuildContext context,String keyWord,bool wheShowLoading,Function successCallBack) async{
    FormData formData = FormData.from({
      'keyWord' : keyWord,
      'sortType' : 'all'
    });
    NetWork.getInstance().wheShowLoadDialog(wheShowLoading).buildContext(context);
    NetWork.getInstance().get(_apiNetDotList, successCallBack,params: formData);
  }
}
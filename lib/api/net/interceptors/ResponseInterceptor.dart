import 'dart:io';

import 'package:dio/dio.dart';
import 'package:ybwp_flutter/api/net/Config.dart';
import 'package:ybwp_flutter/api/net/ResponseCode.dart';
import 'package:ybwp_flutter/api/net/ResponseData.dart';
import 'package:ybwp_flutter/resource/Strings.dart';
import 'package:ybwp_flutter/utils/ToastUtils.dart';

//返回结果
//@author lxl
class ResponseInterceptor extends InterceptorsWrapper {

  final Function successCallBack;
  final Function errorCallBack;

  ResponseInterceptor(this.successCallBack,this.errorCallBack,);

  @override
  onResponse(Response response) {
    try {
      if (response.statusCode != HttpStatus.OK) {
        String errorMsg = Strings.TIP_ERROR_CODE + response.statusCode.toString() + '，' + response.data.toString();
        _error(errorCallBack,errorMsg);
      }else {
        if(ResponseCode.DATA_SUCCESS == response.data[Config.CODE]){
            _success(successCallBack,new ResponseData(response.data[Config.CONTENT], response.data[Config.CODE], response.data[Config.MSG]));
        }else if(response.data != null){
          String errorMsg = response.data[Config.CODE].toString()+ '，'  + response.data[Config.MSG];
          _error(errorCallBack,errorMsg);
        }
      }
    } catch (e) {
      _error(errorCallBack,e.toString());
    }
    return response;
  }

  _success(Function successCallBack,ResponseData data) {
    if(data.code == ResponseCode.NETWORK_ERROR){
      _error(errorCallBack, data.toString());
    }
    if (successCallBack != null) {
      successCallBack(data);
    }
  }

  _error(Function errorCallBack, String error) {
    ToastUtils.showToast(error);
    if (errorCallBack != null) {
      errorCallBack(error);
    }
  }
}
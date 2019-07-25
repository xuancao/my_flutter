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
        String  errorMsg = Strings.TIP_ERROR_CODE + response.statusCode.toString() + '，' + response.data.toString();
        _error(errorCallBack,errorMsg);
      }else{
        _success(successCallBack,new ResponseData(response.data[Config.CONTENT],
            response.data[Config.CODE], response.data[Config.MSG]));
      }
    } catch (e) {
      Response errorResponse;
      if (e.response != null) {
        errorResponse = e.response;
      } else {
        errorResponse = new Response(statusCode: ResponseCode.NETWORK_ERROR);
      }
      if (e.type == DioErrorType.CONNECT_TIMEOUT || e.type == DioErrorType.RECEIVE_TIMEOUT) {
        errorResponse.statusCode = ResponseCode.NETWORK_TIMEOUT;
      }
      String  errorMsg = Strings.TIP_ERROR_CODE + errorResponse.statusCode.toString() + '，' + errorResponse.data.toString();
      _error(errorCallBack,errorMsg);
    }
    return response;
  }

  _success(Function successCallBack,ResponseData data) {
    if (successCallBack != null) {
      successCallBack(data);
    }
  }

  _error(Function errorCallBack, String error) {
    ToastUtils.showToast(error.toString());
    if (errorCallBack != null) {
      errorCallBack(error);
    }
  }
}
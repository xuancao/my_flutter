import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:ybwp_flutter/api/net/Config.dart';
import 'package:ybwp_flutter/api/net/ResponseCode.dart';
import 'package:ybwp_flutter/api/net/interceptors/ErrorInterceptor.dart';
import 'package:ybwp_flutter/api/net/interceptors/HeaderInterceptor.dart';
import 'package:ybwp_flutter/api/net/interceptors/LogsInterceptor.dart';
import 'package:ybwp_flutter/api/net/interceptors/ResponseInterceptor.dart';
import 'package:ybwp_flutter/resource/Strings.dart';
import 'package:ybwp_flutter/utils/LoadingUtils.dart';
import 'package:ybwp_flutter/utils/ToastUtils.dart';

//带请求头带网络请求封装
class NetWork {

  Dio dio;
  BuildContext _context;
  bool _wheShowLoading;

  static NetWork _instance;

  static NetWork getInstance() {
    if (_instance == null) {
      _instance = NetWork();
    }
    return _instance;
  }

  NetWork() {
    dio = Dio();
    dio.interceptors.add(new HeaderInterceptor(Config.headers));
    dio.interceptors.add(new LogsInterceptor());
    dio.interceptors.add(new ErrorInterceptor(dio));
  }

  //绑定context显示加载进度框，否则不显示
  NetWork buildContext(BuildContext context) {
    _context = context;
    return this;
  }

  NetWork wheShowLoadDialog(bool wheShowLoading){
    _wheShowLoading = wheShowLoading;
    return this;
  }

  //get请求
  get(String url, Function successCallBack,
      {params, Function errorCallBack}) async {
    _requestHttp(url, successCallBack, Config.GET, params, errorCallBack);
  }

  //post请求
  post(String url, Function successCallBack,
      {params, Function errorCallBack}) async {
    _requestHttp(url, successCallBack, Config.POST, params, errorCallBack);
  }

  // 文件上传
  putFile<T>(String url, String filePath,Function successCallBack, Function errorCallBack) {
    var name =
    filePath.substring(filePath.lastIndexOf("/") + 1, filePath.length);
    var suffix = name.substring(name.lastIndexOf(".") + 1, name.length);
    FormData formData = new FormData.from({
      "multipartFile": new UploadFileInfo(new File(filePath), name,
          contentType: ContentType.parse("image/$suffix"))
    });
    _requestHttp(url, successCallBack, Config.POST, formData, errorCallBack);
  }

  _requestHttp(String url, Function successCallBack, [String method, FormData params, Function errorCallBack]) async {
    if(_wheShowLoading){
      LoadingUtils.showLoadingDialog(_context);
    }
    dio.interceptors.add(new ResponseInterceptor(successCallBack, errorCallBack));
    try {
      if (method == Config.GET) {
        if (params != null && params.isNotEmpty) {
          await dio.get(url, queryParameters: params);
        } else {
          await dio.get(url);
        }
      } else if (method == Config.POST) {
        if (params != null && params.isNotEmpty) {
          await dio.post(url, data: params);
        } else {
          await dio.post(url);
        }
      }
      if(_wheShowLoading){
        LoadingUtils.hintLoadingDialog(_context);
      }
      _context = null;
    } catch (e) {
      if(_wheShowLoading){
        LoadingUtils.hintLoadingDialog(_context);
      }
      _context = null;
      Response errorResponse;
      if (e.response != null) {
        errorResponse = e.response;
      } else {
        errorResponse = new Response(statusCode: ResponseCode.NETWORK_ERROR);
      }
      if (e.type == DioErrorType.CONNECT_TIMEOUT ||
          e.type == DioErrorType.RECEIVE_TIMEOUT) {
        errorResponse.statusCode = ResponseCode.NETWORK_TIMEOUT;
      }
      String errorMsg = Strings.TIP_ERROR_CODE +
          errorResponse.statusCode.toString() + '，' +
          errorResponse.data.toString();
      _error(errorCallBack, errorMsg);
    }finally{
      if(_wheShowLoading){
        LoadingUtils.hintLoadingDialog(_context);
      }
    }
  }

  _error(Function errorCallBack, String error) {
    ToastUtils.showToast(error.toString());
    if (errorCallBack != null) {
      errorCallBack(error);
    }
  }
}

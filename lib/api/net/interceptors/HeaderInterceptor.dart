import 'package:dio/dio.dart';
import 'package:ybwp_flutter/api/net/Config.dart';

//header拦截器
//@author lxl
class HeaderInterceptor extends InterceptorsWrapper {

  Map<String, dynamic> mHeaders;

  HeaderInterceptor(Map<String, dynamic> headers){
    mHeaders = headers;
  }

  @override
  onRequest(RequestOptions options) async{
    options.baseUrl=Config.baseUrl;
    options.connectTimeout=Config.connectTimeout;
    options.receiveTimeout=Config.receiveTimeout;
    options.headers=mHeaders;
    options.followRedirects=true;
    return options;
  }
}
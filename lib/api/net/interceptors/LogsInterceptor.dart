import 'package:dio/dio.dart';
import 'package:ybwp_flutter/api/net/Config.dart';

//日志拦截器
//@author lxl
class LogsInterceptor extends InterceptorsWrapper {
  @override
  onRequest(RequestOptions options) {
    if (Config.debug) {
      print("请求url：${options.path}");
      print('请求头: ' + options.headers.toString());
      if (options.data != null) {
        print('请求参数: ' + options.data);
      }
    }
    return options;
  }

  @override
  onResponse(Response response) {
    if (Config.debug) {
      if (response != null ) {
        print('返回参数: ' + response.toString());
      }
    }
    return response;
  }

  @override
  onError(DioError err) {
    if (Config.debug) {
      print('请求异常: ' + err.toString());
      print('请求异常信息: ' + err.response?.toString() ?? "");
    }
    return err;
  }


}

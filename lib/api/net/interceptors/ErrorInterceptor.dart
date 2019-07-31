import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
import 'package:ybwp_flutter/api/net/ResponseCode.dart';
import 'package:ybwp_flutter/api/net/ResponseData.dart';
import 'package:ybwp_flutter/resource/Strings.dart';
import 'package:ybwp_flutter/utils/ToastUtils.dart';

//错误拦截
//@author lxl
class ErrorInterceptor extends InterceptorsWrapper {
  final Dio _dio;

  ErrorInterceptor(this._dio,);

  @override
  onRequest(RequestOptions options) async {
    //没有网络
    var connectivityResult = await (new Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      return _dio.resolve(new ResponseData(
          ResponseCode.errorHandleFunction(ResponseCode.NETWORK_ERROR,Strings.TIP_NETWORK_ERROR, true),
          ResponseCode.NETWORK_ERROR,Strings.TIP_NETWORK_ERROR));
    }
    return options;
  }


}

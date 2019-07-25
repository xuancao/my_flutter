package com.nativefunction;



import android.text.TextUtils;
import android.util.Log;

import com.nativefunction.util.DESUtils;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.PluginRegistry;

public class Methods implements MethodChannel.MethodCallHandler {

  /**
   * 插件标识
   */
  public static String CHANNEL = "com.nativefunction/plugin";

  static MethodChannel channel;

  static String ACTION_DES = "ACTION_DES";
  static String PARAMS_PWD = "PARAMS_PWD";

  public static void registerWith(PluginRegistry.Registrar registrar) {
    channel = new MethodChannel(registrar.messenger(), CHANNEL);
    Methods instance = new Methods();
    channel.setMethodCallHandler(instance);
  }

  @Override
  public void onMethodCall(MethodCall methodCall, MethodChannel.Result result) {
    if (methodCall.method.equals(ACTION_DES)) {
      String text = methodCall.argument(PARAMS_PWD);
      if (TextUtils.isEmpty(text)) {
        result.error("Data is Null",null,null);
      }else {
        String r = DESUtils.encrypt(text, Constant.DES_KEY);
        result.success(r);
      }

    }else {
      result.notImplemented();
    }
  }



}
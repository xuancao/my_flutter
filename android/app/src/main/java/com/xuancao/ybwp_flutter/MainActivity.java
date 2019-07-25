package com.xuancao.ybwp_flutter;

import android.os.Bundle;

import com.nativefunction.Methods;

import io.flutter.app.FlutterActivity;
import io.flutter.plugins.GeneratedPluginRegistrant;

public class MainActivity extends FlutterActivity {
  @Override
  protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
    GeneratedPluginRegistrant.registerWith(this);
    Methods.registerWith(this.registrarFor(Methods.CHANNEL));
  }
}

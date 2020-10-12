package com.geetest.onelogindemo;

import android.os.Bundle;

import java.util.HashMap;

import com.geetest.onelogindemo.onelogin.OneLoginUtils;
import io.flutter.app.FlutterActivity;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugins.GeneratedPluginRegistrant;

public class MainActivity extends FlutterActivity {

  //桥接地址
  private static final String ONE_LOGIN_CHANNEL = "com.geetest.onelogin/onelogin";


  //桢数据回传方法名
  private static final String REQUEST = "oneLogin";

  private OneLoginUtils oneLoginUtils;

  @Override
  protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
    GeneratedPluginRegistrant.registerWith(this);
    oneLoginUtils=new OneLoginUtils(MainActivity.this);
    MethodChannel channel = new MethodChannel(getFlutterView(), ONE_LOGIN_CHANNEL);
    channel.setMethodCallHandler(
            new MethodChannel.MethodCallHandler() {
              @Override
              public void onMethodCall(MethodCall call, MethodChannel.Result result) {
                switch (call.method) {
                  case REQUEST:
                    oneLoginUtils.requestToken(result);
                    break;
                  default:
                    result.notImplemented();
                    break;
                }
              }
            });
  }
}

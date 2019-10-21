package com.geetest.onelogindemo;

import com.geetest.onelogindemo.onelogin.OneLoginUtils;

import io.flutter.app.FlutterApplication;

public class App extends FlutterApplication {
    @Override
    public void onCreate() {
        super.onCreate();
        OneLoginUtils.oneLoginPreInApplication(this);
    }
}

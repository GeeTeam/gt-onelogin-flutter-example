import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/services.dart';

class Channel {
  static const MethodChannel _channel =
      const MethodChannel('com.geetest.onelogin/onelogin');

  static Future<String> oneLoginBegin() async {
    return await _channel.invokeMethod('request');
  }
}

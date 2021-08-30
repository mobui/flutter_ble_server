
import 'dart:async';

import 'package:flutter/services.dart';

class FlutterBleServer {
  static const MethodChannel _channel =
      const MethodChannel('flutter_ble_server');

  static Future<String?> get platformVersion async {
    final String? version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}

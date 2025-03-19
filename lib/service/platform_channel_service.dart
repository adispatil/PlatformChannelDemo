import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

class PlatformChannelService {
  static const platform = MethodChannel(
    "com.example.platform_channel_demo/platform",
  );
  static const batteryChannel = MethodChannel(
    "com.example.platform_channel_demo/battery",
  );

  // GET BATTERY LEVEL
  Future<int> getBatteryLevel() async {
    try {
      final int result = await batteryChannel.invokeMethod('getBatteryLevel');
      return result;
    } on PlatformException catch (ex) {
      debugPrint(ex.message);
      return -1;
    }
  }
}

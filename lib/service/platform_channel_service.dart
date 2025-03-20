import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

class PlatformChannelService {
  static const platform = MethodChannel(
    "com.example.platform_channel_demo/platform",
  );
  static const batteryChannel = MethodChannel(
    "com.example.platform_channel_demo/battery",
  );
  static const calculatorChannel = MethodChannel(
    "com.example.platform_channel_demo/calculator",
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

  // PERFORM ARITHMETIC CALCULATIONS
  Future<double> performCalculation({
    required double num1,
    required double num2,
    required String operation,
  }) async {
    try {
      final Map<String, dynamic> arguments = {
        'num1': num1,
        'num2': num2,
        'operation': operation,
      };

      final double result = await calculatorChannel.invokeMethod(
        'calculate',
        arguments,
      );
      return result;
    } on PlatformException catch (e) {
      debugPrint(e.message);
      return 0.0;
    }
  }
}

import 'package:flutter/material.dart';
import 'package:platform_channel_demo/service/platform_channel_service.dart';

class BatteryLevelWidget extends StatefulWidget {
  const BatteryLevelWidget({super.key});

  @override
  State<BatteryLevelWidget> createState() => _BatteryLevelWidgetState();
}

class _BatteryLevelWidgetState extends State<BatteryLevelWidget> {
  final PlatformChannelService _platformChannelService =
      PlatformChannelService();
  int _batteryLevel = 0;

  Future<void> _getBatteryLevel() async {
    int level = await _platformChannelService.getBatteryLevel();
    setState(() {
      _batteryLevel = level;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Battery Level Example',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text(
              'Current Battery Level: $_batteryLevel%',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                _getBatteryLevel();
              },
              child: const Text('Get Battery Level'),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:platform_channel_demo/widgets/battery_level_widget.dart';
import 'package:platform_channel_demo/widgets/calculator_widget.dart';
import 'package:platform_channel_demo/widgets/device_info_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Platform Channel Demo'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: const [
            BatteryLevelWidget(),
            CalculatorWidget(),
            DeviceInfoWidget(),
          ],
        ),
      ),
    );
  }
}

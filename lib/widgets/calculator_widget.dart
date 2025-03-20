import 'package:flutter/material.dart';
import 'package:platform_channel_demo/service/platform_channel_service.dart';

class CalculatorWidget extends StatefulWidget {
  const CalculatorWidget({super.key});

  @override
  State<CalculatorWidget> createState() => _CalculatorWidgetState();
}

class _CalculatorWidgetState extends State<CalculatorWidget> {
  final _num1Controller = TextEditingController();
  final _num2Controller = TextEditingController();
  double _result = 0;
  String _operation = '+';
  PlatformChannelService _platformChannelService = PlatformChannelService();

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
              'Calculator Example',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _num1Controller,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'First Number',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Radio<String>(
                  value: '+',
                  groupValue: _operation,
                  onChanged: (value) {
                    setState(() {
                      _operation = value!;
                    });
                  },
                ),
                const Text('+'),
                Radio<String>(
                  value: '-',
                  groupValue: _operation,
                  onChanged: (value) {
                    setState(() {
                      _operation = value!;
                    });
                  },
                ),
                const Text('-'),
              ],
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _num2Controller,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Second Number',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                _calculate();
              },
              child: const Text('Calculate'),
            ),
            const SizedBox(height: 16),
            Text('Result: $_result', style: const TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _num1Controller.dispose();
    _num2Controller.dispose();
    super.dispose();
  }

  Future<void> _calculate() async {
    final num1 = double.tryParse(_num1Controller.text) ?? 0.0;
    final num2 = double.tryParse(_num2Controller.text) ?? 0.0;

    final result = await _platformChannelService.performCalculation(
      num1: num1,
      num2: num2,
      operation: _operation,
    );

    setState(() {
      _result = result;
    });
  }
}

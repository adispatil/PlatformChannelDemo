import 'package:flutter/material.dart';

class DeviceInfoWidget extends StatefulWidget {
  const DeviceInfoWidget({super.key});

  @override
  State<DeviceInfoWidget> createState() => _DeviceInfoWidgetState();
}

class _DeviceInfoWidgetState extends State<DeviceInfoWidget> {
  Map<String, dynamic> _deviceInfo = {};

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
              'Device Information Example',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            if (_deviceInfo.isNotEmpty) ...[
              _buildInfoRow('Model', _deviceInfo['model'] ?? 'N/A'),
              _buildInfoRow('Brand', _deviceInfo['brand'] ?? 'N/A'),
              _buildInfoRow(
                'Android Version',
                _deviceInfo['androidVersion'] ?? 'N/A',
              ),
              _buildInfoRow(
                'SDK Version',
                _deviceInfo['sdkVersion']?.toString() ?? 'N/A',
              ),
            ],
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {},
              child: const Text('Get Device Info'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
          Text(value),
        ],
      ),
    );
  }
}

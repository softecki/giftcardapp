import 'dart:async';
import 'package:flutter/material.dart';

import '../../../core/app_color.dart';
import '../../../services/niimbot_printer_service.dart';
import '../../../services/jcdemo_launcher_service.dart';

class NiimbotPrinterWidget extends StatefulWidget {
  const NiimbotPrinterWidget({super.key});

  @override
  State<NiimbotPrinterWidget> createState() => _NiimbotPrinterWidgetState();
}

class _NiimbotPrinterWidgetState extends State<NiimbotPrinterWidget> {
  String _macConnection = '';
  String _statusMessage = 'Unknown';
  bool _isConnected = false;

  @override
  void initState() {
    super.initState();
    _initializePrinter();
  }

  Future<void> _initializePrinter() async {
    await _checkConnectionStatus();
  }

  Future<void> _checkConnectionStatus() async {
    try {
      final status = await NiimbotPrinterService.checkConnection();
      setState(() {
        _isConnected = status['connected'];
        _macConnection = status['macAddress'] ?? '';
        _statusMessage = status['message'] ?? 'Unknown status';
      });
    } catch (e) {
      setState(() {
        _statusMessage = 'Connection check error: $e';
      });
    }
  }

  Future<void> _connectToDevice(String deviceAddress) async {
    setState(() {
      _macConnection = deviceAddress;
    });

    try {
      final bool result = await NiimbotPrinterService.connectBluetooth(deviceAddress);
      setState(() {
        _isConnected = result;
        _statusMessage = result ? 'Connected to $deviceAddress' : 'Failed to connect to $deviceAddress';
      });
    } catch (e) {
      setState(() {
        _statusMessage = 'Connection error: $e';
      });
    }
  }

  Future<void> _disconnect() async {
    try {
      final bool result = await NiimbotPrinterService.disconnect();
      setState(() {
        _isConnected = false;
        _macConnection = '';
        _statusMessage = result ? 'Disconnected' : 'Failed to disconnect';
      });
    } catch (e) {
      setState(() {
        _statusMessage = 'Disconnect error: $e';
      });
    }
  }

  Future<void> _printTestLabel() async {
    if (!_isConnected) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please connect to a printer first'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    try {
      // Show loading indicator
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => const Center(
          child: CircularProgressIndicator(color: AppColor.primaryColor),
        ),
      );

      // Create test receipt data
      final receiptData = {
        'title': 'Niimbot Printer Test',
        'merchant': 'Test Merchant',
        'agent': 'Test Agent',
        'transactionId': 'TEST${DateTime.now().millisecondsSinceEpoch}',
        'date': DateTime.now().toIso8601String(),
        'items': [
          {'name': 'Test Print', 'amount': 0.00},
          {'name': 'Label Test', 'amount': 0.00},
        ],
        'total': 0.00,
        'status': 'Test Successful',
        'note': 'This is a test print from Niimbot printer',
      };

      // Print the receipt
      final success = await NiimbotPrinterService.printTextReceipt(receiptData);

      // Close loading dialog
      if (mounted) {
        Navigator.of(context, rootNavigator: true).pop();
      }

      // Show result
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(success ? 'Test print successful!' : 'Test print failed'),
          backgroundColor: success ? Colors.green : Colors.red,
        ),
      );

    } catch (e) {
      // Close loading dialog if still open
      if (mounted) {
        Navigator.of(context, rootNavigator: true).pop();
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Print error: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _showConnectDialog() {
    final TextEditingController addressController = TextEditingController();
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Connect to Printer'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Enter the MAC address of your Niimbot printer:'),
            const SizedBox(height: 16),
            TextField(
              controller: addressController,
              decoration: const InputDecoration(
                labelText: 'MAC Address',
                hintText: 'XX:XX:XX:XX:XX:XX',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              final address = addressController.text.trim();
              if (address.isNotEmpty) {
                Navigator.of(context).pop();
                _connectToDevice(address);
              }
            },
            child: const Text('Connect'),
          ),
        ],
      ),
    );
  }

  Future<void> _launchJcDemo() async {
    try {
      // Try launching directly
      final bool launched = await JcDemoLauncherService.launchJcDemo();
      
      if (!launched) {
        if (mounted) {
          JcDemoLauncherService.showInstallDialog(context);
        }
        return;
      }
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('JcDemo app launched successfully!'),
            backgroundColor: Colors.green,
          ),
        );
      }

    } catch (e) {
      if (mounted) {
        JcDemoLauncherService.showInstallDialog(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: AppColor.primaryColor,
        title: const Text('Niimbot Printer Settings'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _initializePrinter,
            tooltip: 'Refresh',
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Status Card
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          _isConnected ? Icons.bluetooth_connected : Icons.bluetooth_disabled,
                          color: _isConnected ? Colors.green : Colors.red,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Status: $_statusMessage',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    if (_macConnection.isNotEmpty) ...[
                      const SizedBox(height: 8),
                      Text(
                        'Connected to: $_macConnection',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: _isConnected ? _disconnect : null,
                    icon: const Icon(Icons.bluetooth_disabled),
                    label: const Text('Disconnect'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () => _showConnectDialog(),
                    icon: const Icon(Icons.bluetooth_searching),
                    label: const Text('Connect'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColor.primaryColor,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // Launch JcDemo Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _launchJcDemo,
                icon: const Icon(Icons.print),
                label: const Text('Open JcDemo Printer'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Instructions
            Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Instructions',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      '1. Install the JcDemo app on your device\n'
                      '2. Click "Open JcDemo Printer" to launch the printing app\n'
                      '3. Use JcDemo to connect to your Niimbot printer\n'
                      '4. Print labels directly from JcDemo app',
                      style: TextStyle(fontSize: 14),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

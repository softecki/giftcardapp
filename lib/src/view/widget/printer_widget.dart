import 'package:flutter/material.dart';
import 'package:malipo_agent/services/printer_service.dart';

/// PrinterWidget - Flutter widget for printer functionality
/// Provides UI for printer connection and printing operations
class PrinterWidget extends StatefulWidget {
  const PrinterWidget({Key? key}) : super(key: key);

  @override
  State<PrinterWidget> createState() => _PrinterWidgetState();
}

class _PrinterWidgetState extends State<PrinterWidget> {
  bool _isConnected = false;
  bool _isLoading = false;
  String _connectionStatus = 'Not Connected';
  int _printMode = PrintMode.thermal;
  int _printDensity = PrintDensity.medium;

  @override
  void initState() {
    super.initState();
    _checkConnection();
  }

  Future<void> _checkConnection() async {
    print('PrinterWidget: Starting connection check...');
    try {
      print('PrinterWidget: Calling PrinterService.checkConnection()');
      final status = await PrinterService.checkConnection();
      print('PrinterWidget: Connection status received: $status');
      setState(() {
        _isConnected = status['connected'] ?? false;
        _connectionStatus = _isConnected ? 'Connected' : 'Not Connected';
      });
      print('PrinterWidget: Connection check completed. Connected: $_isConnected');
    } catch (e) {
      print('PrinterWidget: Connection check failed with error: $e');
      _showError('Failed to check connection: $e');
    }
  }

  Future<void> _connectBluetooth() async {
    print('PrinterWidget: Starting Bluetooth connection dialog...');
    // Show input dialog for Bluetooth address
    final TextEditingController addressController = TextEditingController();
    
    final result = await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Connect Bluetooth Printer'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Enter Bluetooth device address (MAC address):'),
              const SizedBox(height: 16),
              TextField(
                controller: addressController,
                decoration: const InputDecoration(
                  hintText: '00:11:22:33:44:55',
                  labelText: 'Device Address',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.text,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(addressController.text),
              child: const Text('Connect'),
            ),
          ],
        );
      },
    );

    print('PrinterWidget: Dialog result: $result');
    if (result != null && result.isNotEmpty) {
      print('PrinterWidget: Attempting Bluetooth connection to: $result');
      setState(() => _isLoading = true);
      
      try {
        print('PrinterWidget: Calling PrinterService.connectBluetooth($result)');
        await PrinterService.connectBluetooth(result);
        print('PrinterWidget: Bluetooth connection successful, checking status...');
        await _checkConnection();
        _showSuccess('Connected to Bluetooth printer');
        print('PrinterWidget: Bluetooth connection completed successfully');
      } catch (e) {
        print('PrinterWidget: Bluetooth connection failed with error: $e');
        _showError('Bluetooth connection failed: $e');
      } finally {
        setState(() => _isLoading = false);
        print('PrinterWidget: Bluetooth connection attempt finished');
      }
    } else {
      print('PrinterWidget: Bluetooth connection cancelled or empty address');
    }
  }

  Future<void> _connectWifi() async {
    print('PrinterWidget: Starting WiFi connection dialog...');
    // Show input dialog for WiFi IP address
    final TextEditingController ipController = TextEditingController();
    
    final result = await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Connect WiFi Printer'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Enter WiFi printer IP address:'),
              const SizedBox(height: 16),
              TextField(
                controller: ipController,
                decoration: const InputDecoration(
                  hintText: '192.168.1.100',
                  labelText: 'IP Address',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(ipController.text),
              child: const Text('Connect'),
            ),
          ],
        );
      },
    );

    print('PrinterWidget: WiFi dialog result: $result');
    if (result != null && result.isNotEmpty) {
      print('PrinterWidget: Attempting WiFi connection to: $result');
      setState(() => _isLoading = true);
      
      try {
        print('PrinterWidget: Calling PrinterService.connectWifi($result)');
        await PrinterService.connectWifi(result);
        print('PrinterWidget: WiFi connection successful, checking status...');
        await _checkConnection();
        _showSuccess('Connected to WiFi printer');
        print('PrinterWidget: WiFi connection completed successfully');
      } catch (e) {
        print('PrinterWidget: WiFi connection failed with error: $e');
        _showError('WiFi connection failed: $e');
      } finally {
        setState(() => _isLoading = false);
        print('PrinterWidget: WiFi connection attempt finished');
      }
    } else {
      print('PrinterWidget: WiFi connection cancelled or empty IP');
    }
  }

  Future<void> _disconnect() async {
    print('PrinterWidget: Starting disconnect...');
    setState(() => _isLoading = true);
    
    try {
      print('PrinterWidget: Calling PrinterService.disconnect()');
      await PrinterService.disconnect();
      print('PrinterWidget: Disconnect successful, checking status...');
      await _checkConnection();
      _showSuccess('Disconnected from printer');
      print('PrinterWidget: Disconnect completed successfully');
    } catch (e) {
      print('PrinterWidget: Disconnect failed with error: $e');
      _showError('Disconnect failed: $e');
    } finally {
      setState(() => _isLoading = false);
      print('PrinterWidget: Disconnect attempt finished');
    }
  }

  Future<void> _printTestText() async {
    print('PrinterWidget: Starting print test text...');
    // First check connection status
    await _checkConnection();
    
    if (!_isConnected) {
      print('PrinterWidget: Print test failed - printer not connected');
      _showError('Please connect to a printer first');
      return;
    }

    print('PrinterWidget: Printer is connected, proceeding with print test');
    setState(() => _isLoading = true);
    
    try {
      // Double-check connection before printing
      print('PrinterWidget: Double-checking connection before print...');
      final status = await PrinterService.checkConnection();
      print('PrinterWidget: Double-check status: $status');
      if (!status['connected']) {
        print('PrinterWidget: Print test failed - connection lost during check');
        _showError('Printer connection lost. Please reconnect.');
        setState(() => _isConnected = false);
        return;
      }
      
      // Try simple print method first
      try {
        print('PrinterWidget: Attempting simple text print...');
        final testText = 'Test Print from Flutter App\nDate: ${DateTime.now()}\nStatus: Connected';
        print('PrinterWidget: Test text content: $testText');
        await PrinterService.printSimpleText(testText);
        print('PrinterWidget: Simple text print successful');
        _showSuccess('Text printed successfully');
      } catch (e) {
        // If simple print fails, try the regular print method
        print('PrinterWidget: Simple print failed with error: $e');
        print('PrinterWidget: Trying regular print method...');
        final testText = 'Test Print from Flutter App\nDate: ${DateTime.now()}\nStatus: Connected';
        print('PrinterWidget: Regular print text content: $testText');
        await PrinterService.printText(testText);
        print('PrinterWidget: Regular text print successful');
        _showSuccess('Text printed successfully');
      }
    } catch (e) {
      print('PrinterWidget: Print test failed with error: $e');
      _showError('Print failed: $e');
      // Check connection again after error
      print('PrinterWidget: Checking connection after print error...');
      await _checkConnection();
    } finally {
      setState(() => _isLoading = false);
      print('PrinterWidget: Print test attempt finished');
    }
  }

  Future<void> _debugConnection() async {
    print('PrinterWidget: Starting debug connection...');
    setState(() => _isLoading = true);
    
    try {
      print('PrinterWidget: Getting connection status...');
      final status = await PrinterService.checkConnection();
      print('PrinterWidget: Connection status: $status');
      
      print('PrinterWidget: Getting print status...');
      final printStatus = await PrinterService.getPrintStatus();
      print('PrinterWidget: Print status: $printStatus');
      
      String debugInfo = 'Connection Status:\n';
      debugInfo += 'Connected: ${status['connected']}\n';
      debugInfo += 'Status Code: ${status['status']}\n';
      debugInfo += 'Print Mode: ${printStatus['printMode']}\n';
      debugInfo += 'Print Density: ${printStatus['printDensity']}\n';
      debugInfo += 'Print Multiple: ${printStatus['printMultiple']}\n';
      
      print('PrinterWidget: Debug info generated: $debugInfo');
      _showSuccess('Debug Info: $debugInfo');
      
      // Update UI state
      setState(() {
        _isConnected = status['connected'] ?? false;
        _connectionStatus = _isConnected ? 'Connected' : 'Not Connected';
      });
      print('PrinterWidget: UI state updated - Connected: $_isConnected');
      
    } catch (e) {
      print('PrinterWidget: Debug failed with error: $e');
      _showError('Debug failed: $e');
    } finally {
      setState(() => _isLoading = false);
      print('PrinterWidget: Debug attempt finished');
    }
  }

  Future<void> _printTestBarcode() async {
    print('PrinterWidget: Starting barcode print test...');
    if (!_isConnected) {
      print('PrinterWidget: Barcode print failed - printer not connected');
      _showError('Please connect to a printer first');
      return;
    }

    print('PrinterWidget: Printer is connected, proceeding with barcode print');
    setState(() => _isLoading = true);
    
    try {
      print('PrinterWidget: Calling PrinterService.printBarcode(123456789012)');
      await PrinterService.printBarcode('123456789012');
      print('PrinterWidget: Barcode print successful');
      _showSuccess('Barcode printed successfully');
    } catch (e) {
      print('PrinterWidget: Barcode print failed with error: $e');
      _showError('Barcode print failed: $e');
    } finally {
      setState(() => _isLoading = false);
      print('PrinterWidget: Barcode print attempt finished');
    }
  }

  Future<void> _printTestQRCode() async {
    print('PrinterWidget: Starting QR code print test...');
    if (!_isConnected) {
      print('PrinterWidget: QR code print failed - printer not connected');
      _showError('Please connect to a printer first');
      return;
    }

    print('PrinterWidget: Printer is connected, proceeding with QR code print');
    setState(() => _isLoading = true);
    
    try {
      print('PrinterWidget: Calling PrinterService.printQRCode(https://flutter.dev)');
      await PrinterService.printQRCode('https://flutter.dev');
      print('PrinterWidget: QR code print successful');
      _showSuccess('QR Code printed successfully');
    } catch (e) {
      print('PrinterWidget: QR code print failed with error: $e');
      _showError('QR Code print failed: $e');
    } finally {
      setState(() => _isLoading = false);
      print('PrinterWidget: QR code print attempt finished');
    }
  }

  Future<void> _printReceipt() async {
    print('PrinterWidget: Starting receipt print test...');
    if (!_isConnected) {
      print('PrinterWidget: Receipt print failed - printer not connected');
      _showError('Please connect to a printer first');
      return;
    }

    print('PrinterWidget: Printer is connected, proceeding with receipt print');
    setState(() => _isLoading = true);
    
    try {
      final receiptData = {
        'title': 'Payment Receipt',
        'items': [
          {'name': 'Service Fee', 'amount': 100.00},
          {'name': 'Processing Fee', 'amount': 5.00},
        ],
        'total': 105.00,
        'date': DateTime.now().toIso8601String(),
      };
      
      print('PrinterWidget: Receipt data prepared: $receiptData');
      print('PrinterWidget: Calling PrinterService.printReceipt()');
      await PrinterService.printReceipt(receiptData);
      print('PrinterWidget: Receipt print successful');
      _showSuccess('Receipt printed successfully');
    } catch (e) {
      print('PrinterWidget: Receipt print failed with error: $e');
      _showError('Receipt print failed: $e');
    } finally {
      setState(() => _isLoading = false);
      print('PrinterWidget: Receipt print attempt finished');
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  void _showSuccess(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Printer Settings'),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Connection Status Card
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Printer Status',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(
                          _isConnected ? Icons.check_circle : Icons.error,
                          color: _isConnected ? Colors.green : Colors.red,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          _connectionStatus,
                          style: TextStyle(
                            color: _isConnected ? Colors.green : Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: _isLoading ? null : _connectBluetooth,
                            icon: const Icon(Icons.bluetooth),
                            label: const Text('Connect Bluetooth'),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: _isLoading ? null : _connectWifi,
                            icon: const Icon(Icons.wifi),
                            label: const Text('Connect WiFi'),
                          ),
                        ),
                      ],
                    ),
                    if (_isConnected) ...[
                      const SizedBox(height: 8),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          onPressed: _isLoading ? null : _disconnect,
                          icon: const Icon(Icons.close),
                          label: const Text('Disconnect'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            foregroundColor: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 16),
            
            // Print Settings Card
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Print Settings',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(height: 16),
                    
                    // Print Mode Selection
                    Text('Print Mode:', style: Theme.of(context).textTheme.titleMedium),
                    Row(
                      children: [
                        Radio<int>(
                          value: PrintMode.thermal,
                          groupValue: _printMode,
                          onChanged: (value) {
                            setState(() => _printMode = value!);
                            PrinterService.setPrintMode(value!);
                          },
                        ),
                        const Text('Thermal'),
                        Radio<int>(
                          value: PrintMode.thermalTransfer,
                          groupValue: _printMode,
                          onChanged: (value) {
                            setState(() => _printMode = value!);
                            PrinterService.setPrintMode(value!);
                          },
                        ),
                        const Text('Thermal Transfer'),
                      ],
                    ),
                    
                    const SizedBox(height: 16),
                    
                    // Print Density Selection
                    Text('Print Density:', style: Theme.of(context).textTheme.titleMedium),
                    Row(
                      children: [
                        Radio<int>(
                          value: PrintDensity.low,
                          groupValue: _printDensity,
                          onChanged: (value) {
                            setState(() => _printDensity = value!);
                            PrinterService.setPrintDensity(value!);
                          },
                        ),
                        const Text('Low'),
                        Radio<int>(
                          value: PrintDensity.medium,
                          groupValue: _printDensity,
                          onChanged: (value) {
                            setState(() => _printDensity = value!);
                            PrinterService.setPrintDensity(value!);
                          },
                        ),
                        const Text('Medium'),
                        Radio<int>(
                          value: PrintDensity.high,
                          groupValue: _printDensity,
                          onChanged: (value) {
                            setState(() => _printDensity = value!);
                            PrinterService.setPrintDensity(value!);
                          },
                        ),
                        const Text('High'),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 16),
            
            // Print Test Card
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Print Test',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(height: 16),
                    
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        ElevatedButton.icon(
                          onPressed: _isLoading ? null : _printTestText,
                          icon: const Icon(Icons.text_fields),
                          label: const Text('Print Text'),
                        ),
                        ElevatedButton.icon(
                          onPressed: _isLoading ? null : _debugConnection,
                          icon: const Icon(Icons.bug_report),
                          label: const Text('Debug Connection'),
                        ),
                        ElevatedButton.icon(
                          onPressed: _isLoading ? null : _printTestBarcode,
                          icon: const Icon(Icons.qr_code),
                          label: const Text('Print Barcode'),
                        ),
                        ElevatedButton.icon(
                          onPressed: _isLoading ? null : _printTestQRCode,
                          icon: const Icon(Icons.qr_code_2),
                          label: const Text('Print QR Code'),
                        ),
                        ElevatedButton.icon(
                          onPressed: _isLoading ? null : _printReceipt,
                          icon: const Icon(Icons.receipt),
                          label: const Text('Print Receipt'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            
            if (_isLoading) ...[
              const SizedBox(height: 16),
              const Center(
                child: CircularProgressIndicator(),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

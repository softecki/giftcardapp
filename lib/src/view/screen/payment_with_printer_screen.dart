import 'package:flutter/material.dart';
import 'package:malipo_agent/services/printer_service.dart';
import 'package:malipo_agent/src/view/widget/printer_widget.dart';

/// Example screen showing how to integrate printer functionality
/// into your existing Flutter payment app
class PaymentWithPrinterScreen extends StatefulWidget {
  const PaymentWithPrinterScreen({Key? key}) : super(key: key);

  @override
  State<PaymentWithPrinterScreen> createState() => _PaymentWithPrinterScreenState();
}

class _PaymentWithPrinterScreenState extends State<PaymentWithPrinterScreen> {
  bool _isPrinterConnected = false;
  bool _isLoading = false;
  String _paymentStatus = '';

  @override
  void initState() {
    super.initState();
    _checkPrinterConnection();
  }

  Future<void> _checkPrinterConnection() async {
    try {
      final status = await PrinterService.checkConnection();
      setState(() {
        _isPrinterConnected = status['connected'] ?? false;
      });
    } catch (e) {
      print('Failed to check printer connection: $e');
    }
  }

  Future<void> _processPayment() async {
    setState(() {
      _isLoading = true;
      _paymentStatus = 'Processing payment...';
    });

    try {
      // Simulate payment processing
      await Future.delayed(const Duration(seconds: 2));
      
      setState(() {
        _paymentStatus = 'Payment successful!';
      });

      // Print receipt if printer is connected
      if (_isPrinterConnected) {
        await _printReceipt();
      } else {
        _showSnackBar('Payment successful, but printer not connected for receipt printing');
      }

    } catch (e) {
      setState(() {
        _paymentStatus = 'Payment failed: $e';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _printReceipt() async {
    try {
      final receiptData = {
        'title': 'Payment Receipt',
        'merchant': 'Malipo Agent',
        'transactionId': 'TXN${DateTime.now().millisecondsSinceEpoch}',
        'amount': 100.00,
        'fee': 5.00,
        'total': 105.00,
        'date': DateTime.now().toIso8601String(),
        'items': [
          {'name': 'Service Fee', 'amount': 100.00},
          {'name': 'Processing Fee', 'amount': 5.00},
        ],
      };

      await PrinterService.printReceipt(receiptData);
      _showSnackBar('Receipt printed successfully');
    } catch (e) {
      _showSnackBar('Failed to print receipt: $e');
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment with Printer'),
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
            icon: const Icon(Icons.print),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const PrinterWidget(),
                ),
              );
            },
            tooltip: 'Printer Settings',
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Payment Status Card
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Payment Status',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _paymentStatus.isEmpty ? 'Ready to process payment' : _paymentStatus,
                      style: TextStyle(
                        color: _paymentStatus.contains('successful') 
                            ? Colors.green 
                            : _paymentStatus.contains('failed') 
                                ? Colors.red 
                                : Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    if (_isLoading) ...[
                      const SizedBox(height: 16),
                      const Center(child: CircularProgressIndicator()),
                    ],
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Printer Status Card
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
                          _isPrinterConnected ? Icons.check_circle : Icons.error,
                          color: _isPrinterConnected ? Colors.green : Colors.red,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          _isPrinterConnected ? 'Printer Connected' : 'Printer Not Connected',
                          style: TextStyle(
                            color: _isPrinterConnected ? Colors.green : Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: _checkPrinterConnection,
                        icon: const Icon(Icons.refresh),
                        label: const Text('Check Printer Status'),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Payment Actions Card
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Payment Actions',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(height: 16),
                    
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: _isLoading ? null : _processPayment,
                        icon: const Icon(Icons.payment),
                        label: const Text('Process Payment'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                      ),
                    ),
                    
                    const SizedBox(height: 8),
                    
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: _isLoading ? null : _printReceipt,
                        icon: const Icon(Icons.receipt),
                        label: const Text('Print Test Receipt'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Quick Print Tests
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Quick Print Tests',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(height: 16),
                    
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        ElevatedButton.icon(
                          onPressed: _isLoading ? null : () async {
                            try {
                              await PrinterService.printText('Test Print from Malipo Agent');
                              _showSnackBar('Text printed successfully');
                            } catch (e) {
                              _showSnackBar('Text print failed: $e');
                            }
                          },
                          icon: const Icon(Icons.text_fields),
                          label: const Text('Print Text'),
                        ),
                        ElevatedButton.icon(
                          onPressed: _isLoading ? null : () async {
                            try {
                              await PrinterService.printQRCode('https://malipo-agent.com');
                              _showSnackBar('QR Code printed successfully');
                            } catch (e) {
                              _showSnackBar('QR Code print failed: $e');
                            }
                          },
                          icon: const Icon(Icons.qr_code),
                          label: const Text('Print QR'),
                        ),
                        ElevatedButton.icon(
                          onPressed: _isLoading ? null : () async {
                            try {
                              await PrinterService.printBarcode('123456789012');
                              _showSnackBar('Barcode printed successfully');
                            } catch (e) {
                              _showSnackBar('Barcode print failed: $e');
                            }
                          },
                          icon: const Icon(Icons.qr_code_2),
                          label: const Text('Print Barcode'),
                        ),
                      ],
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

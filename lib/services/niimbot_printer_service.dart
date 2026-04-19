import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// NiimbotPrinterService - Service for Niimbot Label Printer integration
/// Uses native Android JcDemo SDK via method channel
class NiimbotPrinterService {
  static const MethodChannel _channel = MethodChannel('com.niimbot.printer/channel');
  static String _macConnection = '';
  static bool _connecting = false;

  /// Check if printer is connected
  static Future<Map<String, dynamic>> checkConnection() async {
    try {
      final Map<dynamic, dynamic> result = await _channel.invokeMethod('checkConnection');
      return {
        'connected': result['connected'] ?? false,
        'message': result['connected'] ? 'Printer is connected' : 'Printer is not connected',
        'macAddress': _macConnection,
        'status': result['status'] ?? -1,
      };
    } catch (e) {
      return {
        'connected': false,
        'message': 'Error checking connection: $e',
        'macAddress': '',
        'status': -1,
      };
    }
  }

  /// Connect to Bluetooth printer
  static Future<bool> connectBluetooth(String deviceAddress) async {
    try {
      _connecting = true;
      _macConnection = deviceAddress;
      final String result = await _channel.invokeMethod('connectBluetooth', {
        'deviceAddress': deviceAddress,
      });
      _connecting = false;
      return result.contains('success');
    } catch (e) {
      _connecting = false;
      print('Error connecting to Bluetooth: $e');
      return false;
    }
  }

  /// Connect to WiFi printer
  static Future<bool> connectWifi(String ipAddress) async {
    try {
      _connecting = true;
      final String result = await _channel.invokeMethod('connectWifi', {
        'ipAddress': ipAddress,
      });
      _connecting = false;
      return result.contains('success');
    } catch (e) {
      _connecting = false;
      print('Error connecting to WiFi: $e');
      return false;
    }
  }

  /// Disconnect from printer
  static Future<bool> disconnect() async {
    try {
      final String result = await _channel.invokeMethod('disconnect');
      if (result.contains('success')) {
        _macConnection = '';
      }
      return result.contains('success');
    } catch (e) {
      print('Error disconnecting: $e');
      return false;
    }
  }

  /// Print text receipt
  static Future<bool> printTextReceipt(Map<String, dynamic> receiptData) async {
    try {
      // Check if printer is connected
      final status = await checkConnection();
      if (!status['connected']) {
        print('Printer not connected');
        return false;
      }

      // Create receipt text
      final String receiptText = _formatReceiptText(receiptData);
      
      // Print using native Android channel
      final String result = await _channel.invokeMethod('printText', {
        'text': receiptText,
      });
      
      print('Print result: $result');
      return result.contains('success');
      
    } catch (e) {
      print('Error printing text receipt: $e');
      return false;
    }
  }

  /// Print simple text
  static Future<bool> printSimpleText(String text) async {
    try {
      // Check if printer is connected
      final status = await checkConnection();
      if (!status['connected']) {
        print('Printer not connected');
        return false;
      }

      // Print using native Android channel
      final String result = await _channel.invokeMethod('printSimpleText', {
        'text': text,
      });
      
      print('Print result: $result');
      return result.contains('success');
      
    } catch (e) {
      print('Error printing simple text: $e');
      return false;
    }
  }

  /// Print barcode
  static Future<bool> printBarcode(String data) async {
    try {
      // Check if printer is connected
      final status = await checkConnection();
      if (!status['connected']) {
        print('Printer not connected');
        return false;
      }

      // Print using native Android channel
      final String result = await _channel.invokeMethod('printBarcode', {
        'data': data,
      });
      
      print('Print result: $result');
      return result.contains('success');
      
    } catch (e) {
      print('Error printing barcode: $e');
      return false;
    }
  }

  /// Print QR code
  static Future<bool> printQRCode(String data) async {
    try {
      // Check if printer is connected
      final status = await checkConnection();
      if (!status['connected']) {
        print('Printer not connected');
        return false;
      }

      // Print using native Android channel
      final String result = await _channel.invokeMethod('printQRCode', {
        'data': data,
      });
      
      print('Print result: $result');
      return result.contains('success');
      
    } catch (e) {
      print('Error printing QR code: $e');
      return false;
    }
  }

  /// Print image from file path
  static Future<bool> printImage(String imagePath) async {
    try {
      // Check if printer is connected
      final status = await checkConnection();
      if (!status['connected']) {
        print('Printer not connected');
        return false;
      }

      // Print using native Android channel
      final String result = await _channel.invokeMethod('printImage', {
        'imagePath': imagePath,
      });
      
      print('Print result: $result');
      return result.contains('success');
      
    } catch (e) {
      print('Error printing image: $e');
      return false;
    }
  }

  /// Print receipt with structured data
  static Future<bool> printReceipt(Map<String, dynamic> receiptData) async {
    try {
      // Check if printer is connected
      final status = await checkConnection();
      if (!status['connected']) {
        print('Printer not connected');
        return false;
      }

      // Print using native Android channel
      final String result = await _channel.invokeMethod('printReceipt', {
        'receiptData': receiptData,
      });
      
      print('Print result: $result');
      return result.contains('success');
      
    } catch (e) {
      print('Error printing receipt: $e');
      return false;
    }
  }

  /// Set print mode (1: Thermal, 2: Thermal Transfer)
  static Future<bool> setPrintMode(int mode) async {
    try {
      final String result = await _channel.invokeMethod('setPrintMode', {
        'mode': mode,
      });
      return result.contains('success');
    } catch (e) {
      print('Error setting print mode: $e');
      return false;
    }
  }

  /// Set print density
  static Future<bool> setPrintDensity(int density) async {
    try {
      final String result = await _channel.invokeMethod('setPrintDensity', {
        'density': density,
      });
      return result.contains('success');
    } catch (e) {
      print('Error setting print density: $e');
      return false;
    }
  }

  /// Get current print status
  static Future<Map<String, dynamic>> getPrintStatus() async {
    try {
      final Map<dynamic, dynamic> result = await _channel.invokeMethod('getPrintStatus');
      return Map<String, dynamic>.from(result);
    } catch (e) {
      print('Error getting print status: $e');
      return {
        'connected': false,
        'printMode': 1,
        'printDensity': 3,
        'printMultiple': 8.0,
      };
    }
  }

  /// Format receipt data into text for printing
  static String _formatReceiptText(Map<String, dynamic> receiptData) {
    final StringBuffer text = StringBuffer();
    
    // Add title
    text.writeln(receiptData['title'] ?? 'RECEIPT');
    text.writeln();
    
    // Add merchant info
    if (receiptData['merchant'] != null) {
      text.writeln('Merchant: ${receiptData['merchant']}');
    }
    if (receiptData['phone'] != null) {
      text.writeln('Phone: ${receiptData['phone']}');
    }
    if (receiptData['agent'] != null) {
      text.writeln('Agent: ${receiptData['agent']}');
    }
    
    text.writeln();
    
    // Add transaction details
    if (receiptData['transactionId'] != null) {
      text.writeln('ID: ${receiptData['transactionId']}');
    }
    if (receiptData['date'] != null) {
      text.writeln('Date: ${_formatDate(receiptData['date'])}');
    }
    
    text.writeln();
    
    // Add items
    if (receiptData['items'] != null) {
      for (var item in receiptData['items']) {
        text.writeln('${item['name']}: \$${item['amount']?.toStringAsFixed(2) ?? '0.00'}');
      }
    }
    
    text.writeln();
    
    // Add status
    if (receiptData['status'] != null) {
      text.writeln('Status: ${receiptData['status']}');
    }
    
    return text.toString();
  }

  /// Format date string
  static String _formatDate(String dateString) {
    try {
      final DateTime date = DateTime.parse(dateString);
      return '${date.day}/${date.month}/${date.year} ${date.hour}:${date.minute.toString().padLeft(2, '0')}';
    } catch (e) {
      return dateString;
    }
  }

  /// Get current connection status
  static String get macConnection => _macConnection;
  static bool get connecting => _connecting;
}

/// Custom exception for printer-related errors
class NiimbotPrinterException implements Exception {
  final String message;
  final String? code;

  NiimbotPrinterException(this.message, [this.code]);

  @override
  String toString() => 'NiimbotPrinterException: $message';
}
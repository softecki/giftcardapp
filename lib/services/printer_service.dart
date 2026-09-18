import 'dart:async';
import 'package:flutter/services.dart';

/// PrinterService - Flutter service for Niimbot Printer integration
/// Provides methods to interact with native Android printer functionality
class PrinterService {
  static const MethodChannel _channel = MethodChannel('com.niimbot.printer/channel');

  /// Check if printer is connected
  static Future<Map<String, dynamic>> checkConnection() async {
    try {
      final result = await _channel.invokeMethod('checkConnection');
      return Map<String, dynamic>.from(result);
    } on PlatformException catch (e) {
      throw PrinterException(e.code, e.message ?? 'Unknown error');
    }
  }

  /// Connect to Bluetooth printer
  static Future<String> connectBluetooth(String deviceAddress) async {
    try {
      final result = await _channel.invokeMethod('connectBluetooth', {
        'deviceAddress': deviceAddress,
      });
      return result.toString();
    } on PlatformException catch (e) {
      throw PrinterException(e.code, e.message ?? 'Bluetooth connection failed');
    }
  }

  /// Connect to WiFi printer
  static Future<String> connectWifi(String ipAddress) async {
    try {
      final result = await _channel.invokeMethod('connectWifi', {
        'ipAddress': ipAddress,
      });
      return result.toString();
    } on PlatformException catch (e) {
      throw PrinterException(e.code, e.message ?? 'WiFi connection failed');
    }
  }

  /// Disconnect from printer
  static Future<String> disconnect() async {
    try {
      final result = await _channel.invokeMethod('disconnect');
      return result.toString();
    } on PlatformException catch (e) {
      throw PrinterException(e.code, e.message ?? 'Disconnect failed');
    }
  }

  /// Print text
  static Future<String> printText(String text) async {
    try {
      final result = await _channel.invokeMethod('printText', {
        'text': text,
      });
      return result.toString();
    } on PlatformException catch (e) {
      throw PrinterException(e.code, e.message ?? 'Text print failed');
    }
  }

  /// Print simple text (alternative method)
  static Future<String> printSimpleText(String text) async {
    try {
      final result = await _channel.invokeMethod('printSimpleText', {
        'text': text,
      });
      return result.toString();
    } on PlatformException catch (e) {
      throw PrinterException(e.code, e.message ?? 'Simple text print failed');
    }
  }

  /// Print barcode
  static Future<String> printBarcode(String data) async {
    try {
      final result = await _channel.invokeMethod('printBarcode', {
        'data': data,
      });
      return result.toString();
    } on PlatformException catch (e) {
      throw PrinterException(e.code, e.message ?? 'Barcode print failed');
    }
  }

  /// Print QR code
  static Future<String> printQRCode(String data) async {
    try {
      final result = await _channel.invokeMethod('printQRCode', {
        'data': data,
      });
      return result.toString();
    } on PlatformException catch (e) {
      throw PrinterException(e.code, e.message ?? 'QR code print failed');
    }
  }

  /// Print image from file path
  static Future<String> printImage(String imagePath) async {
    try {
      final result = await _channel.invokeMethod('printImage', {
        'imagePath': imagePath,
      });
      return result.toString();
    } on PlatformException catch (e) {
      throw PrinterException(e.code, e.message ?? 'Image print failed');
    }
  }

  /// Print receipt with structured data
  static Future<String> printReceipt(Map<String, dynamic> receiptData) async {
    try {
      final result = await _channel.invokeMethod('printReceipt', {
        'receiptData': receiptData,
      });
      return result.toString();
    } on PlatformException catch (e) {
      throw PrinterException(e.code, e.message ?? 'Receipt print failed');
    }
  }

  /// Set print mode (1: Thermal, 2: Thermal Transfer)
  static Future<String> setPrintMode(int mode) async {
    try {
      final result = await _channel.invokeMethod('setPrintMode', {
        'mode': mode,
      });
      return result.toString();
    } on PlatformException catch (e) {
      throw PrinterException(e.code, e.message ?? 'Set print mode failed');
    }
  }

  /// Set print density
  static Future<String> setPrintDensity(int density) async {
    try {
      final result = await _channel.invokeMethod('setPrintDensity', {
        'density': density,
      });
      return result.toString();
    } on PlatformException catch (e) {
      throw PrinterException(e.code, e.message ?? 'Set print density failed');
    }
  }

  /// Get current print status
  static Future<Map<String, dynamic>> getPrintStatus() async {
    try {
      final result = await _channel.invokeMethod('getPrintStatus');
      return Map<String, dynamic>.from(result);
    } on PlatformException catch (e) {
      throw PrinterException(e.code, e.message ?? 'Get print status failed');
    }
  }
}

/// Custom exception for printer-related errors
class PrinterException implements Exception {
  final String code;
  final String message;

  PrinterException(this.code, this.message);

  @override
  String toString() => 'PrinterException($code): $message';
}

/// Print mode constants
class PrintMode {
  static const int thermal = 1;
  static const int thermalTransfer = 2;
}

/// Print density constants
class PrintDensity {
  static const int low = 1;
  static const int medium = 3;
  static const int high = 6;
  static const int veryHigh = 8;
}

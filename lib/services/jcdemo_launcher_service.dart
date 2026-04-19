import 'package:android_intent_plus/android_intent.dart';
import 'package:flutter/material.dart';

/// JcDemoLauncherService - Service to launch JcDemo app for printing
class JcDemoLauncherService {
  static const String _jcdemoPackageName = 'com.niimbot.jcdemo';
  static const String _jcdemoMainActivity = 'com.niimbot.jcdemo.ui.MainActivity';

  /// Check if JcDemo app is installed
  static Future<bool> isJcDemoInstalled() async {
    try {
      final AndroidIntent intent = AndroidIntent(
        action: 'android.intent.action.MAIN',
        package: _jcdemoPackageName,
        componentName: _jcdemoMainActivity,
      );
      
      // Try to resolve the intent
      final bool? canResolve = await intent.canResolveActivity();
      print('JcDemo installation check: canResolve = $canResolve');
      return canResolve ?? false;
    } catch (e) {
      print('Error checking JcDemo installation: $e');
      return false;
    }
  }

  /// Launch JcDemo app
  static Future<bool> launchJcDemo({String? printData, String? merchantId, String? qrLink}) async {
    try {
      print('Attempting to launch JcDemo with package: $_jcdemoPackageName');
      
      Map<String, String>? intentArgs;
      if (merchantId != null || qrLink != null) {
        intentArgs = <String, String>{};
        if (merchantId != null) {
          intentArgs['merchantId'] = merchantId;
        }
        if (qrLink != null) {
          intentArgs['qrLink'] = qrLink;
        }
      }
      
      final AndroidIntent intent = AndroidIntent(
        action: 'android.intent.action.MAIN',
        package: _jcdemoPackageName,
        componentName: _jcdemoMainActivity,
        flags: <int>[268435456], // Intent.FLAG_ACTIVITY_NEW_TASK
        arguments: intentArgs,
      );
      
      await intent.launch();
      print('JcDemo launch successful');
      return true;
    } catch (e) {
      print('Error launching JcDemo: $e');
      return false;
    }
  }

  /// Launch JcDemo with specific print type
  static Future<bool> launchJcDemoWithPrintType(String printType) async {
    try {
      print('Attempting to launch JcDemo with print type: $printType');
      
      final AndroidIntent intent = AndroidIntent(
        action: 'android.intent.action.MAIN',
        package: _jcdemoPackageName,
        componentName: _jcdemoMainActivity,
        flags: <int>[268435456], // Intent.FLAG_ACTIVITY_NEW_TASK
        arguments: <String, String>{
          'printType': printType,
          'autoPrint': 'true',
        },
      );
      
      await intent.launch();
      print('JcDemo launch with print type successful');
      return true;
    } catch (e) {
      print('Error launching JcDemo with print type: $e');
      return false;
    }
  }

  /// Show dialog to install JcDemo if not available
  static void showInstallDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('JcDemo App Required'),
        content: const Text(
          'The JcDemo printing app is required for printer functionality.\n\n'
          'Please install the JcDemo app from the provided APK file.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              // You can add logic to open APK file or redirect to installation
              _showInstallationInstructions(context);
            },
            child: const Text('Install'),
          ),
        ],
      ),
    );
  }

  /// Show installation instructions
  static void _showInstallationInstructions(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Installation Instructions'),
        content: const Text(
          '1. Locate the JcDemo APK file\n'
          '2. Enable "Install from Unknown Sources" in Android settings\n'
          '3. Tap the APK file to install\n'
          '4. Return to this app and try printing again',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}

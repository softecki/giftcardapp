import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:malipo_agent/src/view/screen/encryptdecrpty.dart';
import 'src/view/screen/gift_card/login_screen.dart' as gift_card_login;
import 'package:flutter/material.dart';
import 'dart:ui' show PointerDeviceKind;
import 'package:malipo_agent/core/app_theme.dart';
import 'package:http/http.dart' as http;
import 'package:package_info_plus/package_info_plus.dart';
import 'core/app_color.dart';
import 'core/app_data.dart';
import 'src/view/widget/gift_card_brand.dart';
import 'src/data/sqflite_web_init_stub.dart'
    if (dart.library.html) 'src/data/sqflite_web_init_web.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  initSqfliteForWeb();
  await EasyLocalization.ensureInitialized();

  runApp(
    EasyLocalization(
      supportedLocales: [Locale('en'), Locale('sw')],
      path: 'assets/translations',
      fallbackLocale: Locale('en'),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      scrollBehavior: const MaterialScrollBehavior().copyWith(
        dragDevices: {
          PointerDeviceKind.mouse,
          PointerDeviceKind.touch,
        },
      ),
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
      theme: AppTheme.lightAppTheme,
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}


class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      splash(context);
    });
  }

  Future<void> splash(BuildContext context) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const Center(
        child: CircularProgressIndicator(color: AppColor.primaryColor),
      ),
    );

    try {
      final url = Uri.parse('${AppData.url}/splash');
      final info = await PackageInfo.fromPlatform();
      final Map<String, dynamic> body = {
        'version_name': info.version,
        'version_code': info.buildNumber,
      };
      final encryptedBody = ApiCrypto.encryptRequest(body);
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: encryptedBody,
      );

      Map<String, dynamic>? payload;
      try {
        payload = ApiCrypto.decryptResponse(response.body);
      } catch (_) {
        try {
          final decoded = jsonDecode(response.body);
          if (decoded is Map<String, dynamic>) {
            payload = decoded;
          }
        } catch (_) {}
      }

      if (context.mounted && Navigator.of(context).canPop()) {
        Navigator.of(context).pop();
      }

      if (response.statusCode == 200 && payload != null) {
        if (!context.mounted) return;
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => const gift_card_login.LoginScreen(),
          ),
        );
      } else {
        _showError('Could not reach GiftCard servers. Please try again.');
      }
    } catch (e) {
      _showError(e.toString());
    }
  }



  void _showError(String message) {
    Navigator.of(context).pop(); // Close loading
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFffffff),
      body: const Center(
        child: GiftCardBrand(iconSize: 96, fontSize: 36, showSubtitle: true),
      ),
    );
  }
}

import 'package:easy_localization/easy_localization.dart';
import 'package:malipo_agent/core/app_color.dart';
import 'package:malipo_agent/generated/assets.dart';
import 'package:malipo_agent/src/view/screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:package_info_plus/package_info_plus.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/app_data.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import '../../data/database_helper.dart';
import '../../data/drift_platform_database_helper.dart';
import '../../static.dart';
import '../widget/custom_text_button.dart';
import 'encryptdecrpty.dart';
import 'otp.dart';
import 'reset_password_screen.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _obscurePassword = true;

  Future<void> login(BuildContext context) async {
    print('[AGENT LOGIN] Started');
    print('[AGENT LOGIN] Input phone=' +
        phoneController.text +
        ' passLen=' +
        passwordController.text.length.toString());
    if (phoneController.text.length < 10) {
      print('[AGENT LOGIN] Invalid phone length');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Enter_full_phone_number'.tr())),
      );
      await Future.delayed(Duration(milliseconds: 500));
      return;
    }

    if (passwordController.text.length < 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Enter_correct_Password'.tr())),
      );
      await Future.delayed(Duration(milliseconds: 500));
      return;
    }

    print('[AGENT LOGIN] Showing loader');
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const Center(
        child: CircularProgressIndicator(
          color: AppColor.primaryColor,
        ),
      ),
    );
    final url = Uri.parse(AppData.url + '/login_agent');
    print('[AGENT LOGIN] URL: ' + url.toString());
    PackageInfo info;
    try {
      info = await PackageInfo.fromPlatform();
      print('[AGENT LOGIN] PackageInfo ok: version=' +
          info.version +
          ' code=' +
          info.buildNumber);
    } catch (e) {
      print('[AGENT LOGIN][WARN] PackageInfo failed: ' + e.toString());
      info = PackageInfo(
          appName: 'app', packageName: 'pkg', version: '0', buildNumber: '0');
    }
    final versionCode = info.buildNumber;
    final versionName = info.version;
    try {
      final Map<String, dynamic> body = {
        'phone': phoneController.text,
        'password': passwordController.text,
        'version_name': versionName,
        'version_code': versionCode,
      };
      final debugBody = Map.of(body);
      debugBody['password'] = '***';
      print('[AGENT LOGIN] Body (masked): ' + debugBody.toString());
      final encryptedBody = ApiCrypto.encryptRequest(body);
      print('[AGENT LOGIN] Body encrypted');
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: encryptedBody,
      );
      print('[AGENT LOGIN] Response status: ' + response.statusCode.toString());
      final decryptresponse = ApiCrypto.decryptResponse(response.body);
      final responseBody = decryptresponse;
      print('[AGENT LOGIN] Response keys: ' +
          (responseBody is Map ? responseBody.keys.join(',') : 'non-map'));
      if (response.statusCode == 200) {
        print('[AGENT LOGIN] 200 OK');
        if (responseBody['data'] != null &&
            responseBody['data']['changePassword'] == true) {
          print(
              '[AGENT LOGIN] changePassword required, navigating to ResetPasswordScreen');
          Navigator.of(context).pop(); // Remove loader
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ResetPasswordScreen(
                phone: phoneController.text,
                password: passwordController.text,
              ),
            ),
          );
          return;
        }
        final prefs = await SharedPreferences.getInstance();
        final userData = responseBody['data']['user'];
        final merchants = responseBody['data']['mechant'];
        final transactionData = responseBody['data']['totals'];
        final statusList = responseBody['data']['status'];
        print('[AGENT LOGIN] user:' +
            (userData != null ? 'yes' : 'no') +
            ' merchants:' +
            (merchants == null ? '0' : merchants.length.toString()) +
            ' totals:' +
            (transactionData == null
                ? '0'
                : transactionData.length.toString()));
        prefs.setString('code_number', userData['id'].toString());
        // userData includes commission_charge and admission_charge from API response
        print(
            '[AGENT LOGIN] commission_charge: ${userData['commission_charge']}, admission_charge: ${userData['admission_charge']}');

        if (kIsWeb) {
          await DriftPlatformDatabaseHelper.instance.logOutUser();
          await DriftPlatformDatabaseHelper.instance.insertCustomer(userData);
        } else {
          await DatabaseHelper.instance.delete();
          await DatabaseHelper.instance.insertCustomer(userData);
        }
        print('[AGENT LOGIN 2] Inserting merchants');

        if (merchants != null) {
          for (var merchant in merchants) {
            if (kIsWeb) {
              await DriftPlatformDatabaseHelper.instance
                  .insertMerchants(merchant);
            } else {
              await DatabaseHelper.instance.insertMerchants(merchant);
            }
          }
          print('[AGENT LOGIN] Inserted merchants');
        }
        print('[AGENT LOGIN 2] Inserting transactions');

        if (transactionData != null) {
          for (var transaction in transactionData) {
            if (kIsWeb) {
              await DriftPlatformDatabaseHelper.instance
                  .insertTransaction(transaction);
            } else {
              await DatabaseHelper.instance.insertTransaction(transaction);
            }
          }
          print('[AGENT LOGIN] Inserted totals');
        }
        print('[AGENT LOGIN 2] Inserting status');

        if (statusList != null) {
          for (var status in statusList) {
            if (kIsWeb) {
              await DriftPlatformDatabaseHelper.instance.insertStatus(status);
            } else {
              await DatabaseHelper.instance.insertStatus(status);
            }
          }
          print('[AGENT LOGIN] Inserted status');
        }

        String message = 'Login_Successful'.tr();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(message)),
        );
        constant().isItLogged = true;
        if (userData['otp_verified'].toString() == '0') {
          print(
              '[AGENT LOGIN] OTP not verified – navigating to VerifyOtpScreen');
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => VerifyOtpScreen(phoneController.text)));
        } else {
          print('[AGENT LOGIN] Success – navigating to HomeScreen');
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HomeScreen()),
          );
        }
      } else {
        print('[AGENT LOGIN][ERROR] Status: ' + response.statusCode.toString());
        final errorMsg = decryptresponse['message'] ?? 'Login Failed';
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(errorMsg)),
        );
      }
    } catch (e) {
      print('[AGENT LOGIN][EXCEPTION] ' + e.toString());
      Navigator.of(context).pop(); // Remove loader on error
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.toString()),
      ));
    }
  }

  void showLanguageSwitcher(BuildContext context) {
    showMenu<Locale>(
      context: context,
      position:
          RelativeRect.fromLTRB(100, 100, 0, 0), // Adjust based on your UI
      items: [
        PopupMenuItem<Locale>(
          value: Locale('en'),
          child: Text('English'),
        ),
        PopupMenuItem<Locale>(
          value: Locale('sw'),
          child: Text('Swahili'),
        ),
      ],
    ).then((Locale? selectedLocale) {
      if (selectedLocale != null) {
        context.setLocale(selectedLocale);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade50,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 40),
                Container(
                  height: 200,
                  width: 200,
                  decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.white.withOpacity(0.8),
                        offset: Offset(-5, -5),
                        blurRadius: 10,
                        spreadRadius: 1,
                      ),
                      BoxShadow(
                        color: Colors.white.withOpacity(0.8),
                        offset: Offset(5, 5),
                        blurRadius: 10,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(
                      Assets.imagesMalipoMtandao1,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  "",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  'Sign_in_with_your_Phone_Number'.tr(),
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
                ),
                const SizedBox(height: 20),
                // Phone field
                Container(
                  decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.white,
                        offset: Offset(-3, -3),
                        blurRadius: 6,
                      ),
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        offset: Offset(3, 3),
                        blurRadius: 6,
                      ),
                    ],
                  ),
                  child: TextField(
                    controller: phoneController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: 'Phone_number'.tr(),
                      prefixIcon: Icon(Icons.call),
                      border: InputBorder.none,
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                // Password field
                Container(
                  decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.white,
                        offset: Offset(-3, -3),
                        blurRadius: 6,
                      ),
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        offset: Offset(3, 3),
                        blurRadius: 6,
                      ),
                    ],
                  ),
                  child: TextField(
                    controller: passwordController,
                    obscureText: _obscurePassword,
                    decoration: InputDecoration(
                      hintText: 'Password'.tr(),
                      prefixIcon: Icon(Icons.password),
                      border: InputBorder.none,
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscurePassword
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscurePassword = !_obscurePassword;
                          });
                        },
                      ),
                    ),
                  ),
                ),
                // Removed inline new password and confirm password fields
                const SizedBox(height: 20),
                // Login Button
                GestureDetector(
                  onTap: () => login(context),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 80, vertical: 16),
                    decoration: BoxDecoration(
                      color: Colors.red.shade600,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.white,
                          offset: Offset(4, 4),
                          blurRadius: 6,
                        ),
                        BoxShadow(
                          color: Colors.white,
                          offset: Offset(-2, -2),
                          blurRadius: 6,
                        ),
                      ],
                    ),
                    child: Text(
                      'LOGIN'.tr(),
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 25),
                CustomTextButton(
                  text: 'language'.tr(),
                  onPressed: () => showLanguageSwitcher(context),
                  icon: Icons.language,
                  textColor: Colors.black54,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class LanguageSwitcher extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<Locale>(
      icon: Icon(Icons.language),
      onSelected: (Locale locale) {
        context.setLocale(locale);
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<Locale>>[
        PopupMenuItem<Locale>(
          value: Locale('en'),
          child: Text('English'),
        ),
        PopupMenuItem<Locale>(
          value: Locale('sw'),
          child: Text('Swahili'),
        ),
      ],
    );
  }
}

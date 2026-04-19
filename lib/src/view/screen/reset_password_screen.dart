import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/app_data.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import '../../data/database_helper.dart';
import '../../data/drift_platform_database_helper.dart';
import '../../static.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'encryptdecrpty.dart';
import 'home_screen.dart';
import 'otp.dart';

class ResetPasswordScreen extends StatefulWidget {
  final String phone;
  final String password;
  const ResetPasswordScreen({Key? key, required this.phone, required this.password}) : super(key: key);

  @override
  _ResetPasswordScreenState createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _obscureNewPassword = true;
  bool _obscureConfirmPassword = true;

  @override
  void dispose() {
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> loginWithNewPassword(BuildContext context) async {
    print('[AGENT RESET] Started for phone='+widget.phone);
    if (_newPasswordController.text.isEmpty || _confirmPasswordController.text.isEmpty) {
      print('[AGENT RESET] Empty fields');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter and confirm your new password.')),
      );
      return;
    }
    if (_newPasswordController.text != _confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Passwords do not match.')),
      );
      return;
    }
    if (_newPasswordController.text.length < 8 ||
        !_newPasswordController.text.contains(RegExp(r'[A-Z]')) ||
        !_newPasswordController.text.contains(RegExp(r'[a-z]')) ||
        !_newPasswordController.text.contains(RegExp(r'[0-9]'))) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Password must be at least 8 characters and include uppercase, lowercase letters, and a number.')),
      );
      return;
    }

    print('[AGENT RESET] Showing loader');
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const Center(
        child: CircularProgressIndicator(),
      ),
    );
    final url = Uri.parse(AppData.url + '/login_agent');
    print('[AGENT RESET] URL: '+url.toString());
    PackageInfo info;
    try {
      info = await PackageInfo.fromPlatform();
      print('[AGENT RESET] PackageInfo ok: version='+info.version+' code='+info.buildNumber);
    } catch (e) {
      print('[AGENT RESET][WARN] PackageInfo failed: '+e.toString());
      info = PackageInfo(appName: 'app', packageName: 'pkg', version: '0', buildNumber: '0');
    }
    final versionCode = info.buildNumber;
    final versionName = info.version;
    try {

      final Map<String, dynamic> body = {
        'phone': widget.phone,
        'password': widget.password,
        'new_password': _newPasswordController.text,
        'confirm_new_password': _confirmPasswordController.text,
        'version_name': versionName,
        'version_code': versionCode,
      };
      final debugBody = Map.of(body);
      debugBody['password'] = '***';
      debugBody['new_password'] = '***';
      debugBody['confirm_new_password'] = '***';
      print('[AGENT RESET] Body (masked): '+debugBody.toString());
      final encryptedBody = ApiCrypto.encryptRequest(body);
      print('[AGENT RESET] Body encrypted');

      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: encryptedBody,
      );
      print('[AGENT RESET] Response status: '+response.statusCode.toString());
      final decryptresponse = ApiCrypto.decryptResponse(response.body);
      final responseBody = decryptresponse;
      print('[AGENT RESET] Response keys: '+(responseBody is Map ? responseBody.keys.join(',') : 'non-map'));

      Navigator.of(context).pop(); // Remove loader
      if (response.statusCode == 200) {
        print('[AGENT RESET] 200 OK – updating local data');
        final prefs = await SharedPreferences.getInstance();
        final userData = responseBody['data']['user'];
        final transactionData = responseBody['data']['mechant'];
        final statusList = responseBody['data']['status'];
        prefs.setString('code_number', userData['id'].toString());
                print('[AGENT RESET 2] 200 OK – updating local data');

        if (kIsWeb) {
          await DriftPlatformDatabaseHelper.instance.logOutUser();
          await DriftPlatformDatabaseHelper.instance.insertCustomer(userData);
        } else {
          await DatabaseHelper.instance.delete();
          await DatabaseHelper.instance.insertCustomer(userData);
        }
                print('[AGENT RESET 3] 200 OK – updating local data');

        if (transactionData != null) {
          for (var transaction in transactionData) {
            if (kIsWeb) {
              await DriftPlatformDatabaseHelper.instance.insertMerchants(transaction);
            } else {
              await DatabaseHelper.instance.insertMerchants(transaction);
            }
          }
          print('[AGENT RESET] Inserted merchants');
        }
        if (statusList != null) {
          for (var status in statusList) {
            if (kIsWeb) {
              await DriftPlatformDatabaseHelper.instance.insertStatus(status);
            } else {
              await DatabaseHelper.instance.insertStatus(status);
            }
          }
          print('[AGENT RESET] Inserted status');
        }
        String message = 'Password changed and login successful!';
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(message)),
        );
        constant().isItLogged = true;
        if (userData['otp_verified'].toString() == '0') {
          print('[AGENT RESET] OTP not verified – navigating to VerifyOtpScreen');
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => VerifyOtpScreen(widget.phone)));
        } else {
          print('[AGENT RESET] Success – navigating to HomeScreen');
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HomeScreen()),
          );
        }
      } else {
        print('[AGENT RESET][ERROR] Status: '+response.statusCode.toString());
        final errorMsg = decryptresponse['message'] ?? 'Password change failed';
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(errorMsg)),
        );
      }
    } catch (e) {
      print('[AGENT RESET][EXCEPTION] '+e.toString());
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.toString()),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade50,
      appBar: AppBar(
        title: const Text('Reset Password'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
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
          ),child:
              TextFormField(
                controller: _newPasswordController,
                obscureText: _obscureNewPassword,
                decoration: InputDecoration(
                  labelText: 'New Password',
                  suffixIcon: IconButton(
                    icon: Icon(_obscureNewPassword ? Icons.visibility : Icons.visibility_off),
                    onPressed: () {
                      setState(() {
                        _obscureNewPassword = !_obscureNewPassword;
                      });
                    },
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a new password';
                  }
                  if (value.length < 8) {
                    return 'Password must be at least 8 characters';
                  }
                  if (!RegExp(r'^(?=.*[a-z])').hasMatch(value)) {
                    return 'Password must contain a lowercase letter';
                  }
                  if (!RegExp(r'^(?=.*[A-Z])').hasMatch(value)) {
                    return 'Password must contain an uppercase letter';
                  }
                  if (!RegExp(r'^(?=.*[0-9])').hasMatch(value)) {
                    return 'Password must contain a number';
                  }
                  return null;
                },
              )),
              const SizedBox(height: 8),
              const Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: 4.0, bottom: 8.0),
                  child: Text(
                    'Password must be at least 8 characters, include uppercase and lowercase letters, and at least one number.',
                    style: TextStyle(fontSize: 13, color: Colors.black54),
                  ),
                ),
              ),
              const SizedBox(height: 16),
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
          ),child:TextFormField(
                controller: _confirmPasswordController,
                obscureText: _obscureConfirmPassword,
                decoration: InputDecoration(
                  labelText: 'Confirm New Password',
                  suffixIcon: IconButton(
                    icon: Icon(_obscureConfirmPassword ? Icons.visibility : Icons.visibility_off),
                    onPressed: () {
                      setState(() {
                        _obscureConfirmPassword = !_obscureConfirmPassword;
                      });
                    },
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please confirm your new password';
                  }
                  if (value != _newPasswordController.text) {
                    return 'Passwords do not match';
                  }
                  return null;
                },
              )),
              const SizedBox(height: 32),
              GestureDetector(
                onTap: () => loginWithNewPassword(context),
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
                    'RESET',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}

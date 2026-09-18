import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../../core/app_color.dart';
import '../../../core/app_data.dart';
import '../widget/gift_card_brand.dart';
import 'encryptdecrpty.dart';
import 'home_screen.dart';

class VerifyOtpScreen extends StatefulWidget {
  final String phone;
  const VerifyOtpScreen(this.phone, {Key? key}) : super(key: key);

  @override
  _VerifyOtpScreenState createState() => _VerifyOtpScreenState();
}

class _VerifyOtpScreenState extends State<VerifyOtpScreen> {
  final TextEditingController otpController = TextEditingController();
  Timer? _countdownTimer;
  int _remainingSeconds = 300; // 5 minutes = 300 seconds
  bool _isExpired = false;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _countdownTimer?.cancel();
    otpController.dispose();
    super.dispose();
  }

  void _startTimer() {
    _isExpired = false;
    _remainingSeconds = 300;
    _countdownTimer?.cancel();
    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingSeconds <= 1) {
        setState(() {
          _remainingSeconds = 0;
          _isExpired = true;
        });
        timer.cancel();
      } else {
        setState(() {
          _remainingSeconds--;
        });
      }
    });
  }

  String _formatTime(int seconds) {
    final minutes = seconds ~/ 60;
    final secs = seconds % 60;
    return '${minutes.toString().padLeft(1, '0')}:${secs.toString().padLeft(2, '0') }';
  }

  Future<void> register(BuildContext context) async {
    if (_isExpired) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('OTP has expired. Please resend OTP.')),
      );
      return;
    }
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const Center(
        child: CircularProgressIndicator(color: AppColor.primaryColor,),
      ),
    );
    final url = Uri.parse(AppData.url+'/otpverification');
    final Map<String, dynamic> body = {
      'otp': otpController.text,
      'phone':widget.phone,
      'type':'agent'
    };
    final encryptedBody = ApiCrypto.encryptRequest(body);
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: encryptedBody,
    );
    final decryptresponse = ApiCrypto.decryptResponse(response.body);
    if (response.statusCode == 200) {
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("User Verified!")));

      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomeScreen()));
    } else {
      Navigator.of(context).pop();
      final errorMsg = decryptresponse['message'] ?? 'Otp Vefirication Failed';
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMsg)),
      );
    }
  }

  Future<void> resendOtp(BuildContext context) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const Center(
        child: CircularProgressIndicator(color: AppColor.primaryColor,),
      ),
    );
    final url = Uri.parse(AppData.url + '/requestotp');
    final Map<String, dynamic> body = {
      'phone': widget.phone,
      'type': 'agent',
    };
    final encryptedBody = ApiCrypto.encryptRequest(body);

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: encryptedBody,
    );
    final decryptresponse = ApiCrypto.decryptResponse(response.body);
    Navigator.of(context).pop();
    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("OTP resent successfully!")));
      _startTimer(); // Restart timer on resend
    } else {
      final errorMsg = decryptresponse['message'] ?? 'Failed to resend OTP';
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMsg)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade50,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
            const GiftCardBrand(iconSize: 64, fontSize: 24),
            const SizedBox(height: 20),
            const Text(
              "Welcome at",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              AppData.appName,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            _isExpired
              ? Container(
                  padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: Colors.red[100],
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: const Text(
                    'OTP Expired. Please click resend.',
                    style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ),
                )
              : Container(
                  padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: Colors.green[100],
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Text(
                    'Your OTP will expire in ${_formatTime(_remainingSeconds)}',
                    style: const TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ),
                ),
            const SizedBox(height: 20),
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
                controller: otpController,
                enabled: !_isExpired,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'Enter OTP Number',
                  prefixIcon: Icon(Icons.call),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                ),
              ),
            ),
            const SizedBox(height: 25),
            GestureDetector(
              onTap: _isExpired ? null : () => register(context),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 80, vertical: 16),
                decoration: BoxDecoration(
                  color: _isExpired ? Colors.grey : Colors.red.shade600,
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
                  'Verify',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            GestureDetector(
              onTap: () => resendOtp(context),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 60, vertical: 14),
                child: Text(
                  'Resend OTP',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue.shade700,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 25),
            // Terms and Sign Up row
          ],
        ),
      ),
    ),
  );
}
}

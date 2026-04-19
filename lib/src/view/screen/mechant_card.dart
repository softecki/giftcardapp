import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:http/http.dart' as http;
import '../../../core/app_data.dart';
import '../../../services/jcdemo_launcher_service.dart';
import '../../data/database_helper.dart';
import '../../data/drift_platform_database_helper.dart';
import 'encryptdecrpty.dart';

class MerchantCard extends StatefulWidget {
  final String name;
  final String code;
  final String status;
  final String phone;
  final String comments;
  final String id;

  const MerchantCard({
    Key? key,
    required this.name,
    required this.code,
    required this.status,
    required this.phone,
    required this.comments,
    required this.id,
  }) : super(key: key);

  @override
  _MerchantCardState createState() => _MerchantCardState();
}

class _MerchantCardState extends State<MerchantCard> {
  int? totalTransaction;
  double? totalAmount;
  bool isLoading = true;
  String? error;

  @override
  void initState() {
    super.initState();
    fetchMerchantData();
  }

  Future<void> fetchMerchantData() async {
    final url = Uri.parse(AppData.url + '/merchant_transactions');
   // Replace with your backend URL
    try {
      final Map<String, dynamic> body = {
        'id': widget.id
      };
      final encryptedBody = ApiCrypto.encryptRequest(body);

      // Password change is now handled in ResetPasswordScreen
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: encryptedBody,
      );
      final decryptresponse = ApiCrypto.decryptResponse(response.body);
      final responseBody = decryptresponse;
      if (response.statusCode == 200) {
        final data = responseBody;
        print(data);
        final rawTotalTransaction = data['data']?['total_transaction'];
        final parsedTotalTransaction = rawTotalTransaction is int
            ? rawTotalTransaction
            : int.tryParse(rawTotalTransaction?.toString() ?? '');
        final rawTotalAmount = data['data']?['total_amount'];
        final parsedTotalAmount = rawTotalAmount is int
            ? rawTotalAmount.toDouble()
            : (rawTotalAmount is double
                ? rawTotalAmount
                : double.tryParse(rawTotalAmount?.toString() ?? ''));
        setState(() {
          totalTransaction = parsedTotalTransaction;
          totalAmount = (parsedTotalAmount! * 0.02);
          isLoading = false;
        });
      } else {
        setState(() {
          error = 'Failed to load data';
          isLoading = false;
        });
      }
      print(totalTransaction);
    } catch (e) {
      setState(() {
        error = 'Error: $e';
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: const Text("Merchant Details"),
        actions: [
          IconButton(
            icon: const Icon(Icons.print),
            onPressed: () async {
              try {
                // Fetch QR link from database
                String qrLink = '1234567890';
                try {
                  if (kIsWeb) {
                    qrLink = await DriftPlatformDatabaseHelper.instance.getMerchantQrLink(widget.id);
                  } else {
                    final qrLinkResult = await DatabaseHelper.instance.getMerchantQrLink(widget.id);
                    qrLink = qrLinkResult ?? '1234567890';
                  }
                } catch (e) {
                  print('Error fetching QR link: $e');
                  // Use default value
                }
                
                // Try launching directly with merchant ID and QR link
                final bool launched = await JcDemoLauncherService.launchJcDemo(
                  merchantId: widget.id,
                  qrLink: qrLink,
                );
                
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
            },
            tooltip: 'Printer Settings',
          ),
        ],
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(24),
          margin: const EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              const BoxShadow(
                color: Colors.white,
                offset: Offset(-6, -6),
                blurRadius: 10,
              ),
              BoxShadow(
                color: Colors.grey.shade500,
                offset: const Offset(6, 6),
                blurRadius: 10,
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.store, size: 40, color: Colors.redAccent),
              const SizedBox(height: 20),
              Text(
                widget.name,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.red[900],
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              Text(
                "Merchant Code: ${widget.code}",
                style: TextStyle(fontSize: 16, color: Colors.grey[800]),
              ),
              const SizedBox(height: 12),
              Text(
                "Merchant Status: ${widget.status}",
                style: TextStyle(
                  fontSize: 16,
                  color: widget.status == 'Success' ? Colors.green : Colors.orange,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "Phone: ${widget.phone}",
                style: TextStyle(fontSize: 16, color: Colors.grey[800]),
              ),
              const SizedBox(height: 20),
              Text(
                "Feedback Comment : ${widget.comments}",
                style: TextStyle(fontSize: 16, color: Colors.grey[800]),
              ),
              const SizedBox(height: 20),
              if (isLoading)
                const CircularProgressIndicator()
              else if (error != null)
                Text(error!, style: const TextStyle(color: Colors.red))
              else ...[
                Text(
                  "Total Transactions: ${totalTransaction ?? '-'}",
                  style: const TextStyle(fontSize: 16, color: Colors.blue),
                ),
                const SizedBox(height: 8),
                Text(
                  "Total Amount TZS: ${totalAmount != null ? totalAmount!.toStringAsFixed(2) : '-'}",
                  style: const TextStyle(fontSize: 16, color: Colors.blue),
                ),
              ],
              const SizedBox(height: 20),
              _neumorphicButton("Go Back", () {
                Navigator.pop(context);
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget _neumorphicButton(String text, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 14),
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            const BoxShadow(
              color: Colors.white,
              offset: Offset(-4, -4),
              blurRadius: 8,
            ),
            BoxShadow(
              color: Colors.grey.shade500,
              offset: const Offset(4, 4),
              blurRadius: 8,
            ),
          ],
        ),
        child: Text(
          text,
          style: TextStyle(color: Colors.red[900], fontSize: 16),
        ),
      ),
    );
  }
}

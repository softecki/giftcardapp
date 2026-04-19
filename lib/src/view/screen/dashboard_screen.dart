import 'package:device_info_plus/device_info_plus.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:malipo_agent/src/view/screen/register_merchants.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import '../../../core/app_data.dart';
import '../../data/database_helper.dart';
import '../../data/drift_platform_database_helper.dart';
import 'encryptdecrpty.dart';
import 'mechant_card.dart';

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({super.key}); // Added super.key for best practice
  @override
  _DashBoardScreenState createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List<Map<String, dynamic>>? transactions;
  Map<String, dynamic>? firstUser;
  String userName = '';
  String amount = '0';
  String amount_earned = '0';
  bool _showAmountEarned = false;

  bool isLoading = false; // Added missing isLoading variable

  final currencyFormatter = NumberFormat("#,##0.00");
  final dateFormatter = DateFormat("dd MMM yyyy");
  final timeFormatter = DateFormat("HH:mm:ss");

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _fetchFirstMerchant();
    _fetchUserName();
  }

  Future<void> _fetchUserName() async {
    if (kIsWeb) {
      final user = await DriftPlatformDatabaseHelper.instance.getFirstUser();
      if (user != null && user.name != null) {
        setState(() {
          userName = user.name!;
        });
      }
    } else {
      final user = await DatabaseHelper.instance.getFirstUser();
      if (user != null && user['name'] != null) {
        setState(() {
          userName = user['name'];
        });
      }
    }
  }

  Future<void> _fetchFirstMerchant() async {
    int balance = kIsWeb
        ? await DriftPlatformDatabaseHelper.instance.getMerchantCount()
        : await DatabaseHelper.instance.getMerchantCount();
    int total_amount = kIsWeb
        ? await DriftPlatformDatabaseHelper.instance.getTransactionsAmount()
        : await DatabaseHelper.instance.getTransactionsAmount();

    // Fetch user data to get commission_charge and admission_charge
    double commissionCharge = 0.02; // Default value
    double admissionCharge = 0.0; // Default value

    if (kIsWeb) {
      final user = await DriftPlatformDatabaseHelper.instance.getFirstUser();
      if (user != null) {
        commissionCharge =
            double.tryParse(user.commissionCharge ?? '0.02') ?? 0.02;
        admissionCharge = double.tryParse(user.admissionCharge ?? '0') ?? 0.0;
      }
    } else {
      final user = await DatabaseHelper.instance.getFirstUser();
      if (user != null) {
        commissionCharge =
            double.tryParse(user['commission_charge']?.toString() ?? '0.02') ??
                0.02;
        admissionCharge =
            double.tryParse(user['admission_charge']?.toString() ?? '0') ?? 0.0;
      }
    }

    List<Map<String, dynamic>> transaction;
    if (kIsWeb) {
      final merchants =
          await DriftPlatformDatabaseHelper.instance.getMerchantList();
      transaction = merchants
          .map((m) => {
                'id': m.id,
                'name': m.name,
                'phone': m.phone,
                'mechant_code': m.mechantCode,
                'status_name': m.status,
                'created_at': m.createdAt,
                'comments': m.comments,
              })
          .toList();
    } else {
      transaction = await DatabaseHelper.instance.getMerchantList();
    }

    amount = balance.toString();
    print('balance: $balance');
    print('total_amount: $total_amount');
    print('commissionCharge: $commissionCharge');
    print('admissionCharge: $admissionCharge');
    // Calculate amount_earned using commission_charge and admission_charge
    double earnedFromCommission = total_amount * commissionCharge;
    double earnedFromAdmission = balance * admissionCharge;
    amount_earned =
        (earnedFromCommission + earnedFromAdmission).toStringAsFixed(2);

    if (transaction.isNotEmpty) {
      transactions = transaction;
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Colors.grey[300],
        elevation: 0,
        title: Text("", style: TextStyle(color: Colors.black)),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.grey[300]),
          onPressed: () {
            Navigator.of(context).maybePop(); // Optionally handle back
          },
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(25),
                    bottomRight: Radius.circular(25),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.white,
                      offset: Offset(-5, -5),
                      blurRadius: 15,
                    ),
                    BoxShadow(
                      color: Colors.grey.shade500,
                      offset: Offset(5, 5),
                      blurRadius: 15,
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.grey[300],
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.shade500,
                                    offset: Offset(4, 4),
                                    blurRadius: 10,
                                  ),
                                  BoxShadow(
                                    color: Colors.white,
                                    offset: Offset(-4, -4),
                                    blurRadius: 10,
                                  ),
                                ],
                              ),
                              child: CircleAvatar(
                                backgroundImage:
                                    AssetImage("assets/profile.jpg"),
                                radius: 22,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                    "${"Hello "}${userName.isNotEmpty ? " $userName" : ""}",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold)),
                                Text("welcome_back".tr(),
                                    style: TextStyle(
                                        color: Colors.black54, fontSize: 12)),
                              ],
                            ),
                          ],
                        ),
                        IconButton(
                          icon:
                              const Icon(Icons.refresh, color: Colors.black54),
                          tooltip: "refresh_transactions".tr(),
                          onPressed: () async {
                            try {
                              // Show loading indicator
                              setState(() {
                                isLoading = true;
                              });

                              // Fetch updated transactions from server
                              final prefs =
                                  await SharedPreferences.getInstance();
                              String? phone = prefs.getString('code_number');
                              final url =
                                  Uri.parse(AppData.url + '/agent_update');
                              final Map<String, dynamic> body = {
                                'phone': phone,
                              };
                              final encryptedBody =
                                  ApiCrypto.encryptRequest(body);
                              final response = await http.post(
                                url,
                                headers: {'Content-Type': 'application/json'},
                                body: encryptedBody,
                              );
                              final decryptresponse =
                                  ApiCrypto.decryptResponse(response.body);
                              final responseBody = decryptresponse;

                              if (response.statusCode == 200) {
                                print(
                                    '[DASHBOARD] 200 OK – responseBody: $responseBody');
                                final merchantsData =
                                    responseBody['data']['mechant'];
                                final transactionData = responseBody['data']
                                        ['totals'] ??
                                    0; // Clear and update local transaction table
                                if (kIsWeb) {
                                  await DriftPlatformDatabaseHelper.instance
                                      .clearTransactions();
                                } else {
                                  await DatabaseHelper.instance
                                      .clearTransactions();
                                }
                                print(
                                    '[DASHBOARD] 200 OK – inserting data into database');
                                if (merchantsData != null) {
                                  for (var transaction in merchantsData) {
                                    if (kIsWeb) {
                                      await DriftPlatformDatabaseHelper.instance
                                          .insertMerchants(transaction);
                                    } else {
                                      await DatabaseHelper.instance
                                          .insertMerchants(transaction);
                                    }
                                  }
                                }
                                print(
                                    '[DASHBOARD] 200 OK – inserting merchants');
                                if (transactionData != null) {
                                  for (var transaction in transactionData) {
                                    if (kIsWeb) {
                                      await DriftPlatformDatabaseHelper.instance
                                          .insertTransaction(transaction);
                                    } else {
                                      await DatabaseHelper.instance
                                          .insertTransaction(transaction);
                                    }
                                  }
                                }
                                // print("object");
                                // Reload data for dashboard
                                await _fetchFirstMerchant();

                                if (mounted) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                          "Transactions updated successfully."),
                                      backgroundColor: Colors.green,
                                    ),
                                  );
                                }
                              } else {
                                if (mounted) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                          "Failed to update transactions. (${response.statusCode})"),
                                      backgroundColor: Colors.red,
                                    ),
                                  );
                                }
                                setState(() {
                                  isLoading = false;
                                });
                              }
                            } catch (e) {
                              if (mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content:
                                        Text("Error updating transactions: $e"),
                                    backgroundColor: Colors.red,
                                  ),
                                );
                              }
                              setState(() {
                                isLoading = false;
                              });
                            }
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "total_merchant".tr(),
                          style: TextStyle(color: Colors.black54, fontSize: 12),
                        ),
                        Text(
                          "Amount Earned",
                          style: TextStyle(
                              color: Colors.black54,
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          " $amount",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              _showAmountEarned
                                  ? "TZS $amount_earned"
                                  : "TZS ******",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(width: 6),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  _showAmountEarned = !_showAmountEarned;
                                });
                              },
                              child: Icon(
                                _showAmountEarned
                                    ? Icons.remove_red_eye
                                    : Icons.remove_red_eye_outlined,
                                color: Colors.black38,
                                size: 20,
                              ),
                            ),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(height: 20),
              _neumorphicButton("register_merchant".tr(), () async {
                final prefs = await SharedPreferences.getInstance();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        MakePayment(prefs.getString('code_number')!),
                  ),
                );
              }),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Text("recent_merchant".tr(),
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 14)),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              ...transactions != null && transactions!.isNotEmpty
                  ? transactions!.map((txn) {
                      print(txn);
                      String receiver = txn['name'] ?? 'Unknown';
                      String amountFormatted = txn['phone'];
                      String status = txn['status_name'] ?? '';
                      DateTime dateTime =
                          DateTime.tryParse(txn['created_at'].toString()) ??
                              DateTime.now();
                      String date = dateFormatter.format(dateTime);
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6, vertical: 3),
                        child: Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.white,
                                offset: Offset(-5, -5),
                                blurRadius: 10,
                              ),
                              BoxShadow(
                                color: Colors.grey.shade500,
                                offset: Offset(5, 5),
                                blurRadius: 10,
                              ),
                            ],
                          ),
                          child: ListTile(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MerchantCard(
                                    id: txn['id'].toString(),
                                    name: txn['name'],
                                    code: txn['merchant_code'] ??
                                        'Unknown', // Fixed typo
                                    status: txn['status_name'],
                                    phone: txn['phone'],
                                    comments: txn['comments'],
                                  ),
                                ),
                              );
                            },
                            leading: CircleAvatar(
                              backgroundColor: status == 'Success'
                                  ? Colors.green
                                  : Colors.redAccent,
                              child: Icon(Icons.home_work_outlined,
                                  color: Colors.white),
                            ),
                            title: Text(receiver),
                            subtitle: Text(status,
                                style: TextStyle(
                                  color: status == 'Success'
                                      ? Colors.green
                                      : Colors.orange,
                                  fontWeight: FontWeight.w600,
                                )),
                            trailing: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(amountFormatted,
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                                const SizedBox(height: 4),
                                Text(date,
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.grey[600])),
                              ],
                            ),
                          ),
                        ),
                      );
                    }).toList()
                  : [Text("no_merchant_available".tr())],
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
            BoxShadow(
              color: Colors.white,
              offset: Offset(-4, -4),
              blurRadius: 8,
            ),
            BoxShadow(
              color: Colors.grey.shade500,
              offset: Offset(4, 4),
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

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}

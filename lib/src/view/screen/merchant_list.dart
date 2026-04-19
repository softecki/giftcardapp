import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

import '../../data/database_helper.dart';
import '../../data/drift_platform_database_helper.dart';
import 'mechant_card.dart';

class MerchantListScreen extends StatefulWidget {
  const MerchantListScreen({Key? key}) : super(key: key);

  @override
  State<MerchantListScreen> createState() => _TransactionListScreenState();
}

class _TransactionListScreenState extends State<MerchantListScreen> {
  List<Map<String, dynamic>> transactions = [];
  final currencyFormatter = NumberFormat("#,##0.00");
  final dateTimeFormatter = DateFormat("dd/MM/yyyy hh:mm a");
  final dateFormatter = DateFormat("dd MMM yyyy");

  DateTime? startDate;
  DateTime? endDate;
  bool _loading = true;

  final _startDateController = TextEditingController();
  final _endDateController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadTransactions();

    Future.delayed(const Duration(seconds: 5), () {
      setState(() {
        _loading = false;
      });
    });
  }

  Future<void> _loadTransactions({DateTime? from, DateTime? to}) async {
    List<Map<String, dynamic>> data;
    if (kIsWeb) {
      final merchants = await DriftPlatformDatabaseHelper.instance.getMerchantList();
      data = merchants.map((m) => {
        'id': m.id,
        'name': m.name,
        'phone': m.phone,
        'mechant_code': m.mechantCode,
        'status_name': m.status,
        'created_at': m.createdAt,
        'comments': m.comments,
      }).toList();
    } else {
      data = await DatabaseHelper.instance.getMerchantList();
    }

    if (from != null && to != null) {


      transactions = data.where((txn) {
        final createdAt = DateTime.tryParse(txn['created_at'].toString());
        if (createdAt == null) return false;
        return createdAt.isAfter(from.subtract(const Duration(days: 1))) &&
            createdAt.isBefore(to.add(const Duration(days: 1)));
      }).toList();
    } else {
      transactions = data;
    }

    setState(() {});
  }

  Future<void> _pickDate(BuildContext context, TextEditingController controller, bool isStartDate) async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: DateTime(now.year - 5),
      lastDate: DateTime(now.year + 5),
    );

    if (picked != null) {
      controller.text = dateFormatter.format(picked);
      setState(() {
        if (isStartDate) {
          startDate = picked;
        } else {
          endDate = picked;
        }
      });
    }
  }

  @override
  void dispose() {
    _startDateController.dispose();
    _endDateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: const Text(
          "Merchant List",
          style: TextStyle(color: Colors.blue, fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          /// Start Date Field - Sunken Design
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.white,
                    offset: Offset(-3, -3),
                    blurRadius: 6,
                  ),
                  BoxShadow(
                    color: Colors.grey.shade500,
                    offset: Offset(3, 3),
                    blurRadius: 6,
                  ),
                ],
              ),
              child: Row(
                children: [
                  Flexible(
                    child: TextFormField(
                      controller: _startDateController,
                      readOnly: true,
                      decoration: InputDecoration(
                        labelText: "Start Date",
                        filled: true,
                        fillColor: Colors.grey[200],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                        suffixIcon: Icon(Icons.calendar_today),
                      ),
                      onTap: () => _pickDate(context, _startDateController, true),
                    ),
                  ),
                ],
              ),
            ),
          ),

          /// End Date + Search Button - Sunken Design
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.white,
                    offset: Offset(-3, -3),
                    blurRadius: 6,
                  ),
                  BoxShadow(
                    color: Colors.grey.shade500,
                    offset: Offset(3, 3),
                    blurRadius: 6,
                  ),
                ],
              ),
              child: Row(
                children: [
                  Flexible(
                    child: TextFormField(
                      controller: _endDateController,
                      readOnly: true,
                      decoration: InputDecoration(
                        labelText: "End Date",
                        filled: true,
                        fillColor: Colors.grey[200],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                        suffixIcon: Icon(Icons.calendar_today),
                      ),
                      onTap: () => _pickDate(context, _endDateController, false),
                    ),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: () => _loadTransactions(from: startDate, to: endDate),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                    ),
                    child: const Text("Search"),
                  ),
                ],
              ),
            ),
          ),


          Expanded(
            child: _loading
                ? const Center(child: CircularProgressIndicator())
                : transactions.isEmpty
                ? const Center(
              child: Text(
                "No Merchant available",
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            )
                : ListView.separated(
              padding: const EdgeInsets.all(6),
              itemCount: transactions.length,
              separatorBuilder: (_, __) => const SizedBox(height: 6),
              itemBuilder: (context, index) {
                final txn = transactions[index];
                String receiver = txn['name'] ?? 'Unknown';
                String amountFormatted = txn['phone'];
                DateTime dateTime = DateTime.tryParse(txn['created_at'].toString()) ?? DateTime.now();
                String status = txn['status_name'];
                String date = dateFormatter.format(dateTime);

                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 1),
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        const BoxShadow(
                          color: Colors.white,
                          offset: Offset(-5, -5),
                          blurRadius: 10,
                        ),
                        BoxShadow(
                          color: Colors.grey.shade500,
                          offset: const Offset(5, 5),
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
                              code: txn['mechant_code'],
                              status: txn['status_name'],// make sure this field exists
                              phone: txn['phone'],
                              comments: txn['comments'] ?? 'No comments available',
                            ),
                          ),
                        );
                      },
                      leading: const CircleAvatar(
                        backgroundColor: Colors.redAccent,
                        child: Icon(Icons.home_work_outlined, color: Colors.white),
                      ),
                      title: Text(receiver),
                      subtitle: Text(
                        status,
                        style: TextStyle(
                          color: status == 'Success' ? Colors.green : Colors.orange,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      trailing: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            amountFormatted,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            date,
                            style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}


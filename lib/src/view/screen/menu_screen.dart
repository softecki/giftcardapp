import 'dart:convert';

import 'package:malipo_agent/core/app_color.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../generated/assets.dart';
import 'package:intl/intl.dart';

class StudentCardWidget extends StatefulWidget {
  final List<Map<String, dynamic>> students;
  final String roleId;

  const StudentCardWidget({required this.students, required this.roleId, super.key});

  @override
  State<StudentCardWidget> createState() => _StudentCardWidgetState();
}

class _StudentCardWidgetState extends State<StudentCardWidget> {
  late Map<String, dynamic> selectedStudent;

  @override
  void initState() {
    super.initState();
    selectedStudent = widget.students.first;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 5, left: 5),
      child: Stack(
        children: [
          Container(
            width: 300,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  AppColor.primaryColor,
                  AppColor.lightOrange,
                  AppColor.primaryColor,
                ],
              ),
              image: DecorationImage(
                image: AssetImage(Assets.imagesNalopa),
                fit: BoxFit.fill,
                colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.08),
                  BlendMode.dstATop,
                ),
              ),
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      selectedStudent['full_name'] ?? 'Student Name',
                      style: Theme.of(context).textTheme.displaySmall?.copyWith(
                        color: Colors.white,
                        fontSize: 13,
                      ),
                    ),
                    const SizedBox(height: 4),
                    widget.roleId != '7'
                        ? const SizedBox(height: 4)
                        : Text(
                      "${selectedStudent['class_name']} (${selectedStudent['section_name']})" ?? "Standard Two (B)",
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        color: Colors.white,
                      ),
                    ),
                    widget.roleId != '7'
                        ? const SizedBox(height: 4)
                        : Text(
                      "Remained : TZS ${NumberFormat('#,##0').format(double.parse(selectedStudent['remained_amount'].toString()))}",
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // 🔽 Dropdown in the top-left corner
          Positioned(
            left: 0,
            top: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 1),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: DropdownButton<Map<String, dynamic>>(
                value: selectedStudent,
                underline: SizedBox(),
                iconEnabledColor: Colors.black,
                onChanged: (Map<String, dynamic>? newStudent) async {
                  if (newStudent != null) {
                    final prefs =  await SharedPreferences.getInstance();
                    prefs.setString('current_student', newStudent['id'].toString());
                    setState(()  {
                      selectedStudent = newStudent;
                    });
                  }
                },
                items: widget.students.map((student) {
                  return DropdownMenuItem<Map<String, dynamic>>(
                    value: student,
                    child: Text(
                      student['first_name'],
                      style: const TextStyle(fontSize: 12),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}







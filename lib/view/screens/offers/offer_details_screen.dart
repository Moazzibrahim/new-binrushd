// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'package:binrushd_medical_center/constants/constants.dart';
import 'package:binrushd_medical_center/controller/branches/fetch_branches_provider.dart';
import 'package:binrushd_medical_center/model/branches_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OfferDetailsScreen extends StatefulWidget {
  final String title;
  final String description;
  final String endTime; // مثال: "2025-05-15T23:59:00"

  const OfferDetailsScreen({
    super.key,
    required this.title,
    required this.description,
    required this.endTime,
  });

  @override
  State<OfferDetailsScreen> createState() => _OfferDetailsScreenState();
}

class _OfferDetailsScreenState extends State<OfferDetailsScreen> {
  late Timer _timer;
  Duration _remaining = Duration.zero;

  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  Branch? _selectedBranch;

  @override
  void initState() {
    super.initState();
    final end = DateTime.parse(widget.endTime);
    _updateCountdown(end);
    _timer = Timer.periodic(
        const Duration(seconds: 1), (_) => _updateCountdown(end));
    Future.delayed(Duration.zero, () {
      final branchProvider =
          Provider.of<FetchBranchesProvider>(context, listen: false);
      branchProvider.loadCachedBranches().then((_) {
        if (branchProvider.branchResponse == null ||
            branchProvider.branchResponse!.data.isEmpty) {
          branchProvider.fetchBranches(context);
        }
      });
    });
  }

  void _updateCountdown(DateTime endTime) {
    final now = DateTime.now();
    final remaining = endTime.difference(now);
    if (remaining.isNegative) {
      _timer.cancel();
      setState(() => _remaining = Duration.zero);
    } else {
      setState(() => _remaining = remaining);
    }
  }

  String twoDigits(int n) => n.toString().padLeft(2, '0');

  @override
  void dispose() {
    _timer.cancel();
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  Widget buildCountdownBox(String label, String value) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            value,
            style: const TextStyle(
                fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(color: Colors.black)),
      ],
    );
  }

  bool isValidEmail(String email) {
    return RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$").hasMatch(email);
  }

  bool isValidPhone(String phone) {
    return RegExp(r'^\d{10,15}$')
        .hasMatch(phone); // يمكن تعديل الطول حسب الدولة
  }

  @override
  Widget build(BuildContext context) {
    final days = _remaining.inDays;
    final hours = _remaining.inHours % 24;
    final minutes = _remaining.inMinutes % 60;
    final seconds = _remaining.inSeconds % 60;

    final branchProvider = Provider.of<FetchBranchesProvider>(context);

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () => Navigator.pop(context),
          ),
          centerTitle: true,
          title: const Text("تفاصيل العرض",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
        ),
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Stack(
            children: [
              SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 40),
                    const Text(
                      "عرض خاص ولفترة محدودة",
                      style:
                          TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "العرض فقط للأعمار من 18 إلى 40",
                      style: TextStyle(color: backgroundColor, fontSize: 16),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      widget.title,
                      style: const TextStyle(
                          fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 16),
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          buildCountdownBox("أيام", twoDigits(days)),
                          buildCountdownBox("ساعات", twoDigits(hours)),
                          buildCountdownBox("دقائق", twoDigits(minutes)),
                          buildCountdownBox("ثواني", twoDigits(seconds)),
                        ],
                      ),
                    ),
                    const SizedBox(height: 32),
                    _buildTextField(label: "اسمك", controller: _nameController),
                    const SizedBox(height: 16),
                    _buildTextField(
                        label: "رقم الجوال",
                        controller: _phoneController,
                        keyboardType: TextInputType.phone),
                    const SizedBox(height: 16),
                    _buildTextField(
                        label: "البريد الإلكتروني",
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress),
                    const SizedBox(height: 16),
                    branchProvider.branchResponse != null &&
                            branchProvider.branchResponse!.data.isNotEmpty
                        ? DropdownButtonFormField<Branch>(
                            value: _selectedBranch,
                            items: branchProvider.branchResponse!.data
                                .map((branch) => DropdownMenuItem<Branch>(
                                      value: branch,
                                      child: Text(branch.name,
                                          textDirection: TextDirection.rtl),
                                    ))
                                .toList(),
                            onChanged: (value) {
                              setState(() {
                                _selectedBranch = value;
                              });
                            },
                            decoration: _inputDecoration("اختر الفرع"),
                          )
                        : const Center(child: CircularProgressIndicator()),
                    const SizedBox(height: 34),
                    ElevatedButton(
                      onPressed: _handleSubmit,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: backgroundColor,
                        minimumSize: const Size.fromHeight(50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text("إرسال",
                          style: TextStyle(fontSize: 18, color: Colors.white)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(color: Colors.black),
      filled: true,
      fillColor: Colors.white10,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
    );
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    TextInputType? keyboardType,
  }) {
    return TextField(
      controller: controller,
      textDirection: TextDirection.rtl,
      keyboardType: keyboardType,
      decoration: _inputDecoration(label),
      style: const TextStyle(color: Colors.black),
    );
  }

  void _handleSubmit() {
    final name = _nameController.text.trim();
    final phone = _phoneController.text.trim();
    final email = _emailController.text.trim();

    if (name.isEmpty ||
        phone.isEmpty ||
        email.isEmpty ||
        _selectedBranch == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("يرجى ملء جميع الحقول")),
      );
      return;
    }

    if (!isValidEmail(email)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("صيغة البريد الإلكتروني غير صحيحة")),
      );
      return;
    }

    if (!isValidPhone(phone)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("رقم الجوال غير صحيح")),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("تم إرسال طلبك بنجاح")),
    );
  }
}

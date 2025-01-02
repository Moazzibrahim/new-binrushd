// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:binrushd_medical_center/constants/constants.dart';
import 'package:binrushd_medical_center/controller/Auth/check_forget_pass_provider.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';

class CheckForgetPasswordScreen extends StatefulWidget {
  final String? emaill;
  const CheckForgetPasswordScreen({super.key, this.emaill});

  @override
  State<CheckForgetPasswordScreen> createState() =>
      _EmailConfirmationScreenState();
}

class _EmailConfirmationScreenState extends State<CheckForgetPasswordScreen> {
  final TextEditingController _otpController = TextEditingController();
  late Timer _timer;

  @override
  void dispose() {
    _otpController.dispose();
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 50,
      height: 50,
      textStyle: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: Colors.black,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyWith(
      decoration: BoxDecoration(
        border: Border.all(color: backgroundColor),
        boxShadow: [
          BoxShadow(
            color: backgroundColor.withOpacity(0.2),
            blurRadius: 8,
          ),
        ],
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.arrow_forward_ios, color: Colors.grey),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
        title: Text(
          'تأكيد الايميل الخاص بك',
          style: TextStyle(
              color: backgroundColor,
              fontWeight: FontWeight.w700,
              fontSize: 20),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 30),
            SvgPicture.asset("assets/images/confirm.svg"),
            const SizedBox(height: 20),
            Text(
              '  ادخل الرمز التعريفى المرسل الى البريد الالكترونى',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.grey[700],
              ),
            ),
            const SizedBox(height: 15),
            // OTP Input
            Pinput(
              length: 6,
              controller: _otpController,
              defaultPinTheme: defaultPinTheme,
              focusedPinTheme: focusedPinTheme,
              keyboardType: TextInputType.number,
              showCursor: true,
            ),
            const SizedBox(height: 46),
            ElevatedButton(
              onPressed: () async {
                final otp = _otpController.text.trim();
                if (otp.length == 6) {
                  // Call the checkForgetPassword function
                  await Provider.of<CheckForgetPassProvider>(context,
                          listen: false)
                      .checkForgetPassword(
                    email: widget.emaill,
                    otpp: otp,
                    context: context,
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('يرجى إدخال رمز مكون من 6 أرقام.'),
                    ),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: backgroundColor,
                padding:
                    const EdgeInsets.symmetric(vertical: 14, horizontal: 110),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                'تأكيد',
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

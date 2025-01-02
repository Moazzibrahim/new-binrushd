// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:binrushd_medical_center/constants/constants.dart';
import 'package:binrushd_medical_center/controller/Auth/send_otp_provider.dart';
import 'package:binrushd_medical_center/view/screens/Auth/login_screen.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';

class EmailConfirmationScreen extends StatefulWidget {
  const EmailConfirmationScreen({super.key});

  @override
  State<EmailConfirmationScreen> createState() =>
      _EmailConfirmationScreenState();
}

class _EmailConfirmationScreenState extends State<EmailConfirmationScreen> {
  final TextEditingController _otpController = TextEditingController();
  late Timer _timer;
  int _remainingTime = 55;
  bool _isResendAllowed = false;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _remainingTime = 55;
    _isResendAllowed = false;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_remainingTime > 0) {
          _remainingTime--;
        } else {
          _isResendAllowed = true;
          _timer.cancel();
        }
      });
    });
  }

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
          style: TextStyle(color: backgroundColor, fontWeight: FontWeight.w700),
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
              'ادخل الرمز التعريفي المرسل الى البريد الالكتروني',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[700],
              ),
            ),
            const SizedBox(height: 30),
            Pinput(
              length: 6,
              controller: _otpController,
              defaultPinTheme: defaultPinTheme,
              focusedPinTheme: focusedPinTheme,
              keyboardType: TextInputType.number,
              showCursor: true,
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () {},
              child: Text(
                _isResendAllowed
                    ? 'إعادة إرسال الكود'
                    : 'إعادة إرسال الكود في $_remainingTime ثانية',
                style: TextStyle(
                  fontSize: 14,
                  color: _isResendAllowed ? Colors.blue : backgroundColor,
                ),
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () async {
                final otp = _otpController.text;
                if (otp.length == 6) {
                  await Provider.of<SendOtpProvider>(context, listen: false)
                      .sendOtp(otp, context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginScreen(),
                    ),
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
                    const EdgeInsets.symmetric(vertical: 14, horizontal: 40),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                'تأكيد',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

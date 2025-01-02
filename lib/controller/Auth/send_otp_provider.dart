// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:binrushd_medical_center/controller/Auth/sign_up_provider.dart';
import 'package:binrushd_medical_center/view/screens/Auth/login_screen.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class SendOtpProvider with ChangeNotifier {
  Future<void> sendOtp(String otp, BuildContext context) async {
    const String url = 'https://binrushd.net/api/auth/check_otp';
    final Map<String, dynamic> body = {'otp': otp};

    // Access the SignUpProvider
    final signUpProvider = Provider.of<SignUpProvider>(context, listen: false);
    final String? token = signUpProvider.token;

    if (token == null || token.isEmpty) {
      log('Error: Token is null or empty.');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Authentication token is missing.')),
      );
      Future.delayed(
        const Duration(seconds: 2),
        () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const LoginScreen()));
        },
      );
      return;
    }

    try {
      // Make the POST request
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json', // JSON content type
          'Authorization': 'Bearer $token', // Add Bearer token
        },
        body: jsonEncode(body),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        // Successful response
        final responseData = jsonDecode(response.body);
        log('OTP verification successful: $responseData');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('OTP verified successfully!')),
        );
      } else {
        // Handle non-successful responses
        final responseData = jsonDecode(response.body);
        log('OTP verification failed. Response: $responseData');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content:
                  Text(responseData['message'] ?? 'Failed to verify OTP.')),
        );
      }
    } catch (e) {
      // Handle exceptions
      log('Error during OTP verification: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('An error occurred. Please try again later.')),
      );
    }
  }
}

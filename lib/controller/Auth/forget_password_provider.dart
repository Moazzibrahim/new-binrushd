// ignore_for_file: avoid_print, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:binrushd_medical_center/view/screens/Auth/forget_password/check_forget_password_screen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ForgetPasswordProvider with ChangeNotifier {
  Future<void> forgetPassword({
    required String? email,
    required BuildContext context, // Make context required
  }) async {
    final url = Uri.parse('https://binrushd.net/api/auth/forget_password');

    // Prepare the request body as JSON
    final Map<String, dynamic> requestBody = {'email': email};

    try {
      // Send the POST request
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 200) {
        print('Request successful: ${response.body}');
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CheckForgetPasswordScreen(emaill: email),
          ),
        );
      } else {
        print('Request failed: ${response.statusCode}');
      }
    } catch (e) {
      print('Error occurred: $e');
    }
  }
}

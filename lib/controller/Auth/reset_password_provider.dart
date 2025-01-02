// ignore_for_file: avoid_print, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:binrushd_medical_center/view/screens/Auth/login_screen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ResetPasswordProvider with ChangeNotifier {
  Future<void> resetPasswordP({
    required String? password,
    required String? confPassword,
    required String? token,
    required BuildContext context, // Make context required
  }) async {
    final url = Uri.parse('https://binrushd.net/api/auth/reset_password');

    // Prepare the request body as JSON
    final Map<String, dynamic> requestBody = {
      'password': password,
      'password_confirmation': confPassword
    };

    try {
      // Send the POST request
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 200) {
        print('Request successful: ${response.body}');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(' تم تأكيد كلمة المرور بنجاح'),
          ),
        );
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const LoginScreen()));
      } else {
        print('Request failed: ${response.statusCode}');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(' حدث خطأ '),
          ),
        );
      }
    } catch (e) {
      print('Error occurred: $e');
    }
  }
}

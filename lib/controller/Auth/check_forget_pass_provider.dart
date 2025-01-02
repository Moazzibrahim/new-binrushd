// ignore_for_file: avoid_print, use_build_context_synchronously

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:binrushd_medical_center/view/screens/Auth/forget_password/new_password_screen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CheckForgetPassProvider with ChangeNotifier {
  String? newToken = '';

  Future<void> checkForgetPassword({
    required String? email,
    required String? otpp,
    required BuildContext context, // Make context required
  }) async {
    final url =
        Uri.parse('https://binrushd.net/api/auth/check_forget_password');

    // Prepare the request body as JSON
    final Map<String, dynamic> requestBody = {'email': email, 'otp': otpp};

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
        final Map<String, dynamic> responsee = jsonDecode(response.body);
        newToken = responsee['data']['token'];
        log(newToken!);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => NewPasswordScreen(
              tokens: newToken,
            ),
          ),
        );
      } else {
        print('Request failed: ${response.statusCode}');
        final Map<String, dynamic> responsee = jsonDecode(response.body);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('${responsee['message']}'),
        ));
      }
    } catch (e) {
      print('Error occurred: $e');
    }
  }
}

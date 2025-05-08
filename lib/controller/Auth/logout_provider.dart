// ignore_for_file: use_build_context_synchronously, avoid_print

import 'dart:convert';
import 'package:binrushd_medical_center/controller/Auth/login_provider.dart';
import 'package:flutter/material.dart';
import 'package:binrushd_medical_center/view/screens/Auth/login_screen.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class LogoutProvider with ChangeNotifier {
  Future<void> logOut({
    required String token,
    required BuildContext context, // Make context required to avoid null issues
  }) async {
    final url = Uri.parse(
        'https://binrushd.net/api/auth/logout'); // Replace with your API endpoint

    try {
      // Show a loading indicator to improve UX
      _showLoadingDialog(context);

      // Send the POST request
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token', // Use token here
        },
        body: jsonEncode({}),
      );

      Navigator.pop(context); // Dismiss the loading dialog

      if (response.statusCode == 200) {
        // Parse the response if needed
        print('Request successful: ${response.body}');

        final loginProvider =
            Provider.of<LoginProvider>(context, listen: false);
        loginProvider.clearToken();
        // Navigate to the login screen and remove all previous routes
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const LoginScreen()),
          (route) => false,
        );
      } else {
        print('Request failed: ${response.statusCode}');
        _showErrorSnackBar(context, 'حدث خطأ');
      }
    } catch (e) {
      Navigator.pop(context); // Dismiss the loading dialog in case of error
      print('Error occurred: $e');
      _showErrorSnackBar(context, 'حدث خطأ');
    }
  }

  // Helper function to show a loading dialog
  void _showLoadingDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  // Helper function to show an error snackbar
  void _showErrorSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
}

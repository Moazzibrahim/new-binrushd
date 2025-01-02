// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'package:binrushd_medical_center/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DeleteAccountProvider with ChangeNotifier {
  bool _isLoading = false;
  String? _errorMessage;
  String? _successMessage;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  String? get successMessage => _successMessage;

  Future<bool> deleteAccount(String token, BuildContext context) async {
    const String url = 'https://binrushd.net/api/auth/delete-account';

    try {
      _isLoading = true;
      _errorMessage = null;
      _successMessage = null;
      notifyListeners();

      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        _successMessage = responseData['message'];
        _showSnackBar(context,
            _successMessage ?? "Account deleted successfully", Colors.green);
        return true;
      } else {
        // Handle error response
        _errorMessage =
            jsonDecode(response.body)['message'] ?? 'An error occurred';
        _showSnackBar(context, _errorMessage!, backgroundColor);
        return false;
      }
    } catch (error) {
      // Handle network or other errors
      _errorMessage = 'An error occurred: $error';
      _showSnackBar(context, _errorMessage!, backgroundColor);
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void _showSnackBar(BuildContext context, String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: color,
      ),
    );
  }
}

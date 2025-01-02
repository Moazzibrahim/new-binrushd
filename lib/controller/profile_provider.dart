import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:binrushd_medical_center/model/profile_model.dart';

class ProfileProvider with ChangeNotifier {
  AuthUserResponse? _authUserResponse;
  AuthUserResponse? get authUserResponse => _authUserResponse;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<void> fetchProfile({
    required String token,
    required BuildContext context,
  }) async {
    final url = Uri.parse('https://binrushd.net/api/auth/profile');

    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        _authUserResponse = AuthUserResponse.fromJson(responseData);
        notifyListeners();
      } else {
        final errorResponse = jsonDecode(response.body);
        _errorMessage = errorResponse['message'] ?? 'An error occurred';
        notifyListeners();
      }
    } catch (e) {
      _errorMessage =
          'Failed to connect to the server. Please try again later.';
      print('Error occurred: $e');
      notifyListeners();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}

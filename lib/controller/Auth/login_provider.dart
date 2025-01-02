// ignore_for_file: avoid_print, use_build_context_synchronously
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:binrushd_medical_center/model/auth/login_model.dart';
import 'package:binrushd_medical_center/view/screens/tabs_screen.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class LoginProvider with ChangeNotifier {
  LoginResponse? _loginResponse;
  LoginResponse? get loginResponse => _loginResponse;
  String? token;
  String? fname;

  bool isLoading = false; // Added to track loading state

  Future<void> login(
      String email, String password, BuildContext context) async {
    final url = Uri.parse(
        'https://binrushd.net/api/auth/login'); // Replace with your BASE_URL
    final headers = {
      'Accept': 'application/json',
    };
    final body = {
      'mode': 'formdata',
      'email': email,
      'password': password,
    };

    isLoading = true; // Set loading to true before making the request
    notifyListeners();

    try {
      final response = await http.post(
        url,
        headers: headers,
        body: body,
      );

      if (response.statusCode == 200) {
        print('Login successful');
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const TabsScreen()));
        final responseBody = json.decode(response.body);
        token = responseBody['data']['user']['token'];
        log(token!);
        print(responseBody);
        _loginResponse = LoginResponse.fromJson(responseBody);
        notifyListeners();
      } else {
        print('Failed to login. Status code: ${response.statusCode}');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text(' الرجاء ادخال ايميل و الرقم السري صحيح')),
        );
      }
    } catch (e) {
      print('Error during login: $e');
    } finally {
      isLoading = false; // Reset loading to false after the request
      notifyListeners();
    }
  }
}


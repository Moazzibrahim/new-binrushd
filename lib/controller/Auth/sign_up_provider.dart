// ignore_for_file: avoid_print, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:binrushd_medical_center/constants/constants.dart';
import 'package:binrushd_medical_center/model/auth/sign_up_model.dart';
import 'package:binrushd_medical_center/view/screens/Auth/forget_password/email_verification_screen.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class SignUpProvider with ChangeNotifier {
  RegistrationResponse? signUpModel;
  String? errorMessage; // Store error messages
  bool isLoading = false; // Store loading state
  String? token;

  Future<void> signUpUser({
    required String fName,
    required String lName,
    required String email,
    required String phone,
    required String password,
    required String confPassword,
    BuildContext? context,
  }) async {
    const String url = 'https://binrushd.net/api/auth/register';
    errorMessage = null; // Reset the error message at the start

    // Prepare the request body
    final Map<String, dynamic> body = {
      'fname': fName,
      'lname': lName,
      'email': email,
      'mobile': phone,
      'password': password,
      'password_confirmation': confPassword,
    };

    isLoading = true; // Set loading to true before the request
    notifyListeners(); // Notify listeners about the loading state change

    try {
      // Make the POST request
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json', // Set the content type to JSON
        },
        body: jsonEncode(body), // Encode the body to JSON format
      );
      // Check the response status
      if (response.statusCode == 200 || response.statusCode == 201) {
        // Successful signup
        final responseData = jsonDecode(response.body);
        signUpModel = RegistrationResponse.fromJson(responseData);
        token = signUpModel!.data.token;
        print('User signed up successfully:');
        print('token: $token');

        showDialog(
            context: context!,
            builder: (BuildContext context) {
              return Dialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset("assets/images/icon.png"),
                      const SizedBox(height: 20),
                      const Text(
                        'تهانينا!',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'تم إنشاء حسابك بنجاح، يمكنك تاكيد الاميل عبر تفقد الرمز عبر حسابك الشخصي.',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black54,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  const EmailConfirmationScreen()));
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: backgroundColor,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 100, vertical: 15),
                          textStyle: const TextStyle(fontSize: 16),
                        ),
                        child: const Text(
                          'تاكيد',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            });
        // Future.delayed(
        //   const Duration(seconds: 2),
        //   () {
        //     Navigator.push(context,
        //         MaterialPageRoute(builder: (context) => const HomePage()));
        //   },
        // );
      } else {
        // Handle errors
        final responseData = jsonDecode(response.body);
        String errorMsg = 'Sign up failed.';

        // Check if there are validation errors
        if (responseData['errors'] != null) {
          // Collect all error messages from the response
          final List<String> errorMessages = [];
          responseData['errors'].forEach((key, value) {
            if (value is List) {
              errorMessages.addAll(value.map((e) => '$key: $e').toList());
            }
          });
          errorMsg = errorMessages.join('\n'); // Join error messages
        }

        errorMessage = errorMsg;
        print('Failed to sign up. Status code: ${response.statusCode}');
        print('Response body: ${response.body}');

        // Show the combined error messages in the Snackbar
        ScaffoldMessenger.of(context!).showSnackBar(
          SnackBar(content: Text(errorMsg)),
        );
      }
    } catch (e) {
      // Handle exceptions
      errorMessage = 'Error occurred during signup: $e';
      print(errorMessage);

      // Show error message in the Snackbar if context is provided
      if (context != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(errorMessage!)),
        );
      }
    } finally {
      isLoading = false; // Set loading to false after the request
      notifyListeners(); // Notify listeners about the loading state change
    }
  }
}

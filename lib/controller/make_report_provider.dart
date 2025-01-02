// ignore_for_file: avoid_print, use_build_context_synchronously

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MakeReportProvider with ChangeNotifier {
  Future<void> sendReportRequest(
      {required String name,
      required String phone,
      required String fileNumber,
      required int doctorId,
      required int branchId,
      required String token,
      BuildContext? context // Pass token directly
      }) async {
    final url = Uri.parse(
        'https://binrushd.net/api/report'); // Replace with your API endpoint

    // Prepare the request body as a JSON
    final Map<String, dynamic> requestBody = {
      'name': name,
      'phone': phone,
      'doctor_id': doctorId,
      'FileNumber': fileNumber,
      'branch_id': branchId,
    };

    try {
      // Send the POST request
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token', // Use token here
        },
        body: jsonEncode(requestBody),
      );

      // Check for a successful response
      if (response.statusCode == 200) {
        print('Request successful: ${response.body}');
        // Handle the response if needed
        ScaffoldMessenger.of(context!).showSnackBar(
            const SnackBar(content: Text("تم تسليم التقرير بنجاح")));
      } else {
        print('Request failed: ${response.statusCode}');
        // Handle error response
      }
    } catch (e) {
      print('Error occurred: $e');
      // Handle error if the request fails (e.g., network issues)
    }
  }
}

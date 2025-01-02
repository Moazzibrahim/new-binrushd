// ignore_for_file: avoid_print, use_build_context_synchronously

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MakeReservationProvider with ChangeNotifier {
  Future<void> sendPostRequest(
      {required String customerName,
      required String email,
      required String phone,
      required int isOffer,
      required int offerId,
      required int branchId,
      required int docId,
      required String survey,
      required String token,
      BuildContext? context // Pass token directly
      }) async {
    final url = Uri.parse(
        'https://binrushd.net/api/reservation'); // Replace with your API endpoint

    // Prepare the request body as a JSON
    final Map<String, dynamic> requestBody = {
      'customerName': customerName,
      'email': email,
      'phone': phone,
      'isOffer': isOffer,
      'offer_id': offerId,
      'branch_id': branchId,
      'doctor_id': docId,
      'survey': survey,
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
        ScaffoldMessenger.of(context!).showSnackBar(const SnackBar(
            content: Text(" تم الحجز بنجاح تفقد حسابك للتأكيد ")));
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

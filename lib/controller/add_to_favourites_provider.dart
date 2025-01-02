// ignore_for_file: avoid_print, use_build_context_synchronously
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AddToFavouritesProvider with ChangeNotifier {
  Future<void> addToFav({
    required int? doctorId,
    required String? token,
    required BuildContext context, // Make context required
  }) async {
    final url = Uri.parse('https://binrushd.net/api/favourites/add');

    // Prepare the request body as JSON
    final Map<String, dynamic> requestBody = {
      'doctor_id': doctorId,
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
          const SnackBar(content: Text("تم اضافة الطبيب للمفضلة بنجاح")),
        );
      } else {
        print('Request failed: ${response.statusCode}');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("فشل في إضافة إلى المفضلة")),
        );
      }
    } catch (e) {
      print('Error occurred: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("حدث خطأ أثناء إضافة إلى المفضلة")),
      );
    }
  }

  Future<void> removeFav({
    required int? doctorId,
    required String? token,
    required BuildContext context, // Make context required
  }) async {
    final url = Uri.parse('https://binrushd.net/api/favourites/remove');

    // Prepare the request body as JSON
    final Map<String, dynamic> requestBody = {
      'doctor_id': doctorId,
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
          const SnackBar(content: Text("تم ازالة الطبيب من للمفضلة بنجاح")),
        );
      } else {
        print('Request failed: ${response.statusCode}');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("فشل في ازالة من المفضلة")),
        );
      }
    } catch (e) {
      print('Error occurred: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("حدث خطأ أثناء ازالة من المفضلة")),
      );
    }
  }
}

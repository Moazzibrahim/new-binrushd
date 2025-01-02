// ignore_for_file: avoid_print, use_rethrow_when_possible

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:binrushd_medical_center/controller/Auth/login_provider.dart';
import 'package:http/http.dart' as http;
import 'package:binrushd_medical_center/model/about_us_model.dart';
import 'package:provider/provider.dart';

class AboutUsProvider with ChangeNotifier {
  AboutUsModel? _aboutUsModel;
  AboutUsModel? get aboutUsModel => _aboutUsModel;

  // Method to fetch data from the API
  Future<void> fetchAboutUsData(BuildContext context) async {
    final url = Uri.parse('https://binrushd.net/api/about-us'); // API URL
    final loginprovider = Provider.of<LoginProvider>(context, listen: false);
    String? token = loginprovider.token;
    try {
      final response = await http.get(url, headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      });

      // Check if the request was successful (status code 200)
      if (response.statusCode == 200) {
        // Parse the JSON response and convert it to an AboutUsModel object
        final responseData = json.decode(response.body);
        _aboutUsModel = AboutUsModel.fromJson(responseData);

        // Notify listeners so the UI can update
        notifyListeners();
      } else {
        // Handle error if the request fails
        throw Exception('Failed to load About Us data');
      }
    } catch (error) {
      // Handle any errors during the request
      print('Error fetching About Us data: $error');
      throw error; // You can also handle errors differently, such as setting an error state
    }
  }
}

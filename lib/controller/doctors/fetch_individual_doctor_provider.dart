// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:binrushd_medical_center/model/individual_doctor_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class FetchIndividualDoctorProvider with ChangeNotifier {
  IndividualDoctorModel? _doctorsResponse;
  IndividualDoctorModel? get doctorsResponse => _doctorsResponse;

  Future<void> fetchDoctorsDataspecial(
      BuildContext context, int? doctorid) async {
    String url = 'https://binrushd.net/api/doctor/$doctorid';

    // Get the token from the LoginProvider

    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Accept': 'application/json',
          // 'Authorization': 'Bearer $token', // Include the token in headers
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        _doctorsResponse = IndividualDoctorModel.fromJson(data);
        notifyListeners(); // Notify listeners to update UI
      } else {
        throw Exception('Failed to load doctors data');
      }
    } catch (error) {
      print('Error fetching data: $error');
      rethrow;
    }
  }
}

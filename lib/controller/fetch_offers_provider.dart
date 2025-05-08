// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:binrushd_medical_center/model/offers_model.dart';

class FetchOffersProvider with ChangeNotifier {
  OffersResponse? _offersResponse;
  OffersResponse? get offersResponse => _offersResponse;

  bool _isFetching = false; // Flag to check if data is already being fetched

  // Function to fetch posts data from the API
  Future<void> fetchOffers(BuildContext context) async {
    // If already fetching or data is already available, return immediately
    if (_isFetching || _offersResponse != null) {
      log('FetchOffers skipped: already fetched or in progress.');
      return;
    }

    _isFetching = true; // Set fetching flag to true
    final url = Uri.parse('https://binrushd.net/api/offer'); // API URL

    try {
      // Sending a GET request to the URL
      final response = await http.get(url, headers: {
        'Accept': 'application/json',
      });

      if (response.statusCode == 200) {
        // Parse the response body into the model
        final jsonResponse = json.decode(response.body);
        _offersResponse = OffersResponse.fromJson(jsonResponse);
        notifyListeners(); // Notify listeners about the change in data
        log('Offers fetched successfully: ${_offersResponse?.message}');
      } else if (response.statusCode == 401) {
        // Handle unauthorized access (token expired or invalid)
        log('Unauthorized access. Please log in again.');
        // ScaffoldMessenger.of(context).showSnackBar(
        //   const SnackBar(
        //       content: Text('Unauthorized access. Please log in again.')),
        // );
      } else {
        log('Failed to fetch offers. Status code: ${response.statusCode}');
        // ScaffoldMessenger.of(context).showSnackBar(
        //   SnackBar(content: Text('Error: ${response.reasonPhrase}')),
        // );
        throw Exception(
            'Failed to fetch offers. Status code: ${response.statusCode}');
      }
    } catch (error) {
      log('Error occurred: $error');
      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(content: Text('An error occurred: $error')),
      // );
      throw Exception('Error occurred: $error');
    } finally {
      _isFetching = false; // Reset fetching flag
    }
  }
}

// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:binrushd_medical_center/model/article_model.dart';
import 'package:http/http.dart' as http;

class FetchPostsProvider with ChangeNotifier {
  PostResponse? _postResponse;
  PostResponse? get postResponse => _postResponse;

  // Function to fetch posts data from the API
  Future<void> fetchPosts(BuildContext context) async {
    final url = Uri.parse('https://binrushd.net/api/post'); // API URL

    try {
      // Sending a GET request to the URL
      final response = await http.get(url, headers: {
        'Accept': 'application/json',
      });

      if (response.statusCode == 200) {
        // Parse the response body into the model
        final jsonResponse = json.decode(response.body);
        _postResponse = PostResponse.fromJson(jsonResponse);
        notifyListeners(); // Notify listeners about the change in data
        log('Posts fetched successfully: ${_postResponse?.message}');
      } else if (response.statusCode == 401) {
        // Handle unauthorized access (token expired or invalid)
        log('Unauthorized access. Please log in again.');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Unauthorized access. Please log in again.')),
        );
      } else {
        log('Failed to fetch posts. Status code: ${response.statusCode}');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${response.reasonPhrase}')),
        );
        throw Exception(
            'Failed to fetch posts. Status code: ${response.statusCode}');
      }
    } catch (error) {
      log('Error occurred: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An error occurred: $error')),
      );
      throw Exception('Error occurred: $error');
    }
  }
}

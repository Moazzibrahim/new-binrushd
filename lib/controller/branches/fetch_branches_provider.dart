import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:binrushd_medical_center/model/branches_model.dart';

class FetchBranchesProvider with ChangeNotifier {
  BranchResponse? _branchResponse;
  BranchResponse? get branchResponse => _branchResponse;

  /// Fetch branch data from API and cache it using Hive
  Future<void> fetchBranches(BuildContext context) async {
    final url = Uri.parse('https://binrushd.net/api/branch');

    try {
      final response = await http.get(url, headers: {
        'Accept': 'application/json',
        // 'Authorization': 'Bearer $token',
      });

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);

        // Convert JSON to BranchResponse
        _branchResponse = BranchResponse.fromJson(jsonResponse);

        // Open Hive box and store branches
        final Box<Branch> branchBox = Hive.box<Branch>('branches');
        await branchBox.clear(); // Clear old data

        for (Branch branch in _branchResponse!.data) {
          await branchBox.put(branch.id, branch);
        }

        notifyListeners();
      } else if (response.statusCode == 401) {
        log('Unauthorized access. Please log in again.');
        // Handle re-authentication if needed
      } else {
        log('Failed to load branches. Status code: ${response.statusCode}');
        throw Exception('Failed to load branches');
      }
    } catch (error) {
      log('Error occurred: $error');
      throw Exception('Error: $error');
    }
  }

  /// Load branches from Hive (cache)
  Future<void> loadCachedBranches() async {
    final branchBox = Hive.box<Branch>('branches');
    final cachedBranches = branchBox.values.toList();

    if (cachedBranches.isNotEmpty) {
      _branchResponse = BranchResponse(
        message: 'Cached branches loaded',
        data: cachedBranches,
      );
      notifyListeners();
    }
  }
}

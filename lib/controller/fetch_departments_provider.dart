import 'dart:convert';
import 'dart:developer';
import 'package:binrushd_medical_center/model/department_specific_model.dart';
import 'package:flutter/material.dart';
import 'package:binrushd_medical_center/model/department_model.dart';
import 'package:http/http.dart' as http;

class FetchDepartmentsProvider with ChangeNotifier {
  DepartmentResponse? _departmentResponse;
  DepartmentResponse? get departmentResponse => _departmentResponse;

  DepartmentResponses? _departmentResponses;
  DepartmentResponses? get departmentResponses => _departmentResponses;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  // Fetch all departments
  Future<void> fetchDepartments(BuildContext context) async {
    _isLoading = true;
    notifyListeners(); // Notify that loading started

    final url = Uri.parse('https://binrushd.net/api/department');

    try {
      final response = await http.get(url, headers: {
        'Accept': 'application/json',
      });

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        _departmentResponse = DepartmentResponse.fromJson(jsonResponse);
      } else if (response.statusCode == 401) {
        log('Unauthorized access. Please log in again.');
      } else {
        log('Failed to load branches. Status code: ${response.statusCode}');
      }
    } catch (error) {
      log('Error occurred: $error');
    } finally {
      _isLoading = false;
      notifyListeners(); // Notify that loading finished
    }
  }

  // Fetch specific department
  Future<void> fetchDepartmentsspecific(BuildContext context, int depId) async {
    _isLoading = true;
    notifyListeners(); // Notify that loading started

    final url = Uri.parse('https://binrushd.net/api/department/$depId');

    try {
      final response = await http.get(url, headers: {
        'Accept': 'application/json',
      });

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        _departmentResponses = DepartmentResponses.fromJson(jsonResponse);
      } else if (response.statusCode == 401) {
        log('Unauthorized access. Please log in again.');
      } else {
        log('Failed to load branches. Status code: ${response.statusCode}');
      }
    } catch (error) {
      log('Error occurred: $error');
    } finally {
      _isLoading = false;
      notifyListeners(); // Notify that loading finished
    }
  }
}

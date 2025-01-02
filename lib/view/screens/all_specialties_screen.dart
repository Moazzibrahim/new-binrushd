// ignore_for_file: file_names

import 'package:binrushd_medical_center/view/screens/specializies/specializies_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:binrushd_medical_center/controller/fetch_departments_provider.dart';
import 'package:provider/provider.dart';

class SpecialistsScreen extends StatelessWidget {
  const SpecialistsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'التخصصات',
          style: TextStyle(
              color: Colors.black, fontSize: 18, fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.arrow_forward_ios, color: Colors.black),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: Consumer<FetchDepartmentsProvider>(
        builder: (context, fetchDepartmentsProvider, child) {
          final departmentResponse =
              fetchDepartmentsProvider.departmentResponse;

          // Show loading indicator while data is being fetched
          if (departmentResponse == null) {
            return const Center(child: CircularProgressIndicator());
          }

          final departments = departmentResponse.data;

          // Display the grid of specialties
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3, // Three icons per row
                mainAxisSpacing: 13,
                crossAxisSpacing: 13,
                childAspectRatio: 0.7, // Adjust to avoid overflow
              ),
              itemCount: departments.length,
              itemBuilder: (context, index) {
                final department = departments[index];

                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SpecializiesDetailsScreen(
                                      depid: department.id,
                                      depimage: department.image,
                                    )));
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          department.image,
                          fit: BoxFit
                              .cover,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Flexible(
                      child: Text(
                        department.name,
                        style: const TextStyle(
                            fontSize: 12,
                            color: Colors.black,
                            fontWeight: FontWeight.w400),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                );
              },
            ),
          );
        },
      ),
    );
  }
}

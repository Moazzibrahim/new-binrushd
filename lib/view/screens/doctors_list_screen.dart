// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:binrushd_medical_center/constants/constants.dart';
import 'package:binrushd_medical_center/controller/Auth/login_provider.dart';
import 'package:binrushd_medical_center/controller/add_to_favourites_provider.dart';
import 'package:binrushd_medical_center/controller/doctors/fetch_doctors_data_provider.dart';
import 'package:binrushd_medical_center/view/screens/doctors/doctor_details_screen.dart';
import 'package:provider/provider.dart';

class DoctorsListScreen extends StatefulWidget {
  const DoctorsListScreen({super.key});

  @override
  State<DoctorsListScreen> createState() => _DoctorsListScreenState();
}

class _DoctorsListScreenState extends State<DoctorsListScreen> {
  final Set<int> _favoriteIndices = {}; // Keep track of favorite doctors

  @override
  Widget build(BuildContext context) {
    final favProvider =
        Provider.of<AddToFavouritesProvider>(context, listen: false);
    final logProvider = Provider.of<LoginProvider>(context, listen: false);
    final token = logProvider.token;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'الأطباء',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.arrow_forward_ios, color: Colors.black),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
      body: Consumer<FetchDoctorsDataProvider>(
        builder: (context, doctorsProvider, child) {
          final doctorsResponse = doctorsProvider.doctorsResponse;

          // Show loading spinner while fetching data
          if (doctorsResponse == null) {
            return const Center(child: CircularProgressIndicator());
          }

          final doctors = doctorsResponse.data;

          // Show a message if no doctors are available
          if (doctors.isEmpty) {
            return const Center(child: Text('لا يوجد أطباء حاليا'));
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16.0),
            itemCount: doctors.length,
            itemBuilder: (context, index) {
              final doctor = doctors[index];
              final isFavorite = _favoriteIndices.contains(index);

              return Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: Card(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  elevation: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Favorite Icon
                            IconButton(
                              icon: Icon(
                                isFavorite
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                color: backgroundColor,
                              ),
                              onPressed: () async {
                                try {
                                  if (isFavorite) {
                                    await favProvider.removeFav(
                                      context: context,
                                      doctorId: doctor.id,
                                      token: token,
                                    );
                                    setState(
                                        () => _favoriteIndices.remove(index));
                                  } else {
                                    await favProvider.addToFav(
                                      context: context,
                                      doctorId: doctor.id,
                                      token: token,
                                    );
                                    setState(() => _favoriteIndices.add(index));
                                  }
                                } catch (e) {
                                  print("Error managing favorites: $e");
                                }
                              },
                            ),
                            const SizedBox(width: 5),
                            // Doctor's Details
                            Directionality(
                              textDirection: TextDirection.rtl,
                              child: Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "دكتور/ ${doctor.fname} ${doctor.lname}",
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        doctor.speciality,
                                        style: const TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            // Doctor's Image
                            ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Image.network(
                                doctor.image,
                                width: 80,
                                height: 100,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) =>
                                    const Icon(
                                  Icons.broken_image,
                                  size: 80,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: backgroundColor,
                            padding: const EdgeInsets.symmetric(
                              vertical: 12,
                              horizontal: 90,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DoctorDetailsScreen(
                                  docid: doctor.id,
                                  isFavourite: isFavorite,
                                ),
                              ),
                            );
                          },
                          child: const Text(
                            "عرض الملف الشخصي",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

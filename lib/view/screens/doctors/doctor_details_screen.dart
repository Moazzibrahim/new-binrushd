// ignore_for_file: library_private_types_in_public_api, avoid_print, unused_local_variable

import 'package:binrushd_medical_center/controller/Auth/login_provider.dart';
import 'package:binrushd_medical_center/controller/add_to_favourites_provider.dart';
import 'package:flutter/material.dart';
import 'package:binrushd_medical_center/constants/constants.dart';
import 'package:binrushd_medical_center/controller/doctors/fetch_individual_doctor_provider.dart';
import 'package:binrushd_medical_center/view/screens/appointments/make_appointments_screen.dart';
import 'package:provider/provider.dart';

class DoctorDetailsScreen extends StatefulWidget {
  final int? docid;
  final bool? isFavourite;

  const DoctorDetailsScreen({super.key, this.docid, this.isFavourite});

  @override
  _DoctorDetailsScreenState createState() => _DoctorDetailsScreenState();
}

class _DoctorDetailsScreenState extends State<DoctorDetailsScreen> {
  late bool isFavourite;
  final Set<int> _favoriteIndices = {}; // Keep track of favorite doctors

  @override
  void initState() {
    super.initState();
    isFavourite = widget.isFavourite ?? false;
  }

  void toggleFavorite() {
    setState(() {
      isFavourite = !isFavourite;
    });
    // Add logic here to update the favorite status on the server if needed.
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = backgroundColor;
    final favProvider =
        Provider.of<AddToFavouritesProvider>(context, listen: false);
    final logProvider = Provider.of<LoginProvider>(context, listen: false);
    final token = logProvider.token;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.arrow_forward_ios, color: Colors.black),
            onPressed: () => Navigator.pop(context),
          ),
        ],
        title: const Text(
          'تفاصيل الطبيب',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: FutureBuilder(
        future:
            Provider.of<FetchIndividualDoctorProvider>(context, listen: false)
                .fetchDoctorsDataspecial(context, widget.docid),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Text('حدث خطأ أثناء تحميل البيانات: ${snapshot.error}'),
            );
          }

          return Consumer<FetchIndividualDoctorProvider>(
            builder: (context, doctorsProvider, child) {
              final doctorsResponse = doctorsProvider.doctorsResponse;

              if (doctorsResponse == null) {
                return const Center(child: Text('لا يوجد بيانات لهذا الطبيب.'));
              }

              final doctor = doctorsResponse.data;

              final isFavorite = _favoriteIndices.contains(doctor.id);

              return Directionality(
                textDirection: TextDirection.rtl,
                child: Padding(
                  padding:
                      const EdgeInsets.only(right: 16.0, left: 16, bottom: 16),
                  child: Card(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 4,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Center(
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      IconButton(
                                        icon: Icon(
                                          isFavourite
                                              ? Icons.favorite
                                              : Icons.favorite_border,
                                          color: isFavourite
                                              ? backgroundColor
                                              : Colors.grey,
                                        ),
                                        onPressed: () async {
                                          try {
                                            if (isFavourite) {
                                              await favProvider.removeFav(
                                                context: context,
                                                doctorId: doctor.id,
                                                token: token,
                                              );
                                              setState(() {
                                                isFavourite =
                                                    false; // Update the favorite state
                                                _favoriteIndices
                                                    .remove(doctor.id);
                                              });
                                            } else {
                                              await favProvider.addToFav(
                                                context: context,
                                                doctorId: doctor.id,
                                                token: token,
                                              );
                                              setState(() {
                                                isFavourite =
                                                    true; // Update the favorite state
                                                _favoriteIndices.add(doctor.id);
                                              });
                                            }
                                          } catch (e) {
                                            print(
                                                "Error managing favorites: $e");
                                          }
                                        },
                                      ),
                                      Text(
                                        "${doctor.fname} ${doctor.lname}",
                                        style: const TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                      CircleAvatar(
                                        radius: 30,
                                        backgroundImage: doctor.image.isNotEmpty
                                            ? NetworkImage(doctor.image)
                                            : const AssetImage(
                                                    'assets/images/default_avatar.png')
                                                as ImageProvider,
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    doctor.speciality,
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: backgroundColor,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                            const Divider(),
                            const SizedBox(height: 6),
                            _buildSectionTitle("نبذة:", primaryColor),
                            const SizedBox(height: 4),
                            Text(
                              doctor.brief,
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.black87,
                              ),
                              textAlign: TextAlign.justify,
                            ),
                            const SizedBox(height: 11),
                            _buildSectionTitle("الخبرة:", primaryColor),
                            const SizedBox(height: 4),
                            Text(
                              "${doctor.experience} سنوات",
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.black87,
                              ),
                            ),
                            const SizedBox(height: 11),
                            _buildSectionTitle("الدرجة العلمية:", primaryColor),
                            const SizedBox(height: 4),
                            Text(
                              doctor.degree,
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.black87,
                              ),
                            ),
                            const SizedBox(height: 11),
                            _buildSectionTitle("الفروع:", primaryColor),
                            const SizedBox(height: 4),
                            Text(
                              doctor.branches.first.name,
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.black87,
                              ),
                              textAlign: TextAlign.justify,
                            ),
                            const SizedBox(height: 11),
                            _buildSectionTitle("المؤهلات:", primaryColor),
                            const SizedBox(height: 4),
                            Text(
                              "${doctor.qualifications}",
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.black87,
                              ),
                              textAlign: TextAlign.justify,
                            ),
                            const SizedBox(height: 11),
                            SizedBox(
                              width: double.infinity,
                              height: 50,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: primaryColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const MakeAppointmentScreen(),
                                    ),
                                  );
                                },
                                child: const Text(
                                  "حجز موعد",
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
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

  Widget _buildSectionTitle(String title, Color color) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: color,
      ),
    );
  }
}

// ignore_for_file: unnecessary_null_comparison

import 'package:binrushd_medical_center/view/screens/tabs_screen.dart';
import 'package:flutter/material.dart';
import 'package:binrushd_medical_center/constants/constants.dart';
import 'package:provider/provider.dart';
import 'package:binrushd_medical_center/controller/Auth/login_provider.dart';
import 'package:binrushd_medical_center/controller/add_to_favourites_provider.dart';

class MyFavouritesScreen extends StatelessWidget {
  const MyFavouritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final loginProvider = Provider.of<LoginProvider>(context, listen: false);
    final token = loginProvider.token;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'المفضلة',
          style: TextStyle(
            fontFamily: 'Arial', // Change to your preferred Arabic font
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        actions: [
          IconButton(
              onPressed: () {
                token == null
                    ? Navigator.pop(context)
                    : Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const TabsScreen()));
              },
              icon: const Icon(
                Icons.arrow_forward_ios,
                color: Colors.black,
              )),
        ],
      ),
      body: token == null
          ? const Center(
              child: Text(
                "يجب التسجيل لتري المفضلة",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
            )
          : Consumer<LoginProvider>(
              builder: (context, provider, child) {
                if (provider.isLoading) {
                  // Show loading indicator
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                final favourites =
                    provider.loginResponse?.data!.user.favourites ?? [];
                if (favourites.isEmpty) {
                  return const Center(
                    child: Text(
                      "لا يوجد  حاليًا",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                    ),
                  );
                }

                return ListView.builder(
                  padding: const EdgeInsets.all(16.0),
                  itemCount: favourites.length,
                  itemBuilder: (context, index) {
                    final favouruite = favourites[index];
                    final doctorName = favouruite != null
                        ? "${favouruite.fname} ${favouruite.lname}"
                        : "Unknown Doctor";
                    final docid = favouruite.id;

                    return Column(
                      children: [
                        DoctorCard(
                          degree: favouruite.degree,
                          doctorname: doctorName,
                          speciality: favouruite.speciality,
                          token: token,
                          docId: docid,
                          image: favouruite.image,
                        ),
                        const SizedBox(height: 16.0),
                      ],
                    );
                  },
                );
              },
            ),
    );
  }
}

class DoctorCard extends StatefulWidget {
  final String degree;
  final String speciality;
  final String? doctorname;
  final String? image;
  final int? docId;
  final String token;

  const DoctorCard({
    super.key,
    required this.degree,
    required this.speciality,
    required this.doctorname,
    required this.image,
    this.docId,
    required this.token,
  });

  @override
  _DoctorCardState createState() => _DoctorCardState();
}

class _DoctorCardState extends State<DoctorCard> {
  bool isFavorite = true;

  @override
  Widget build(BuildContext context) {
    final favprovider =
        Provider.of<AddToFavouritesProvider>(context, listen: false);

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              // Favorite Button
              IconButton(
                icon: Icon(
                  isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: isFavorite ? backgroundColor : Colors.grey,
                ),
                onPressed: () async {
                  if (isFavorite) {
                    // Remove from favorites
                    try {
                      await favprovider.removeFav(
                        context: context,
                        doctorId: widget.docId,
                        token: widget.token,
                      );
                      setState(() {
                        isFavorite = false;
                      });
                    } catch (e) {
                      print("Error removing from favorites: $e");
                    }
                  } else {
                    // Add to favorites
                    try {
                      await favprovider.addToFav(
                        context: context,
                        doctorId: widget.docId,
                        token: widget.token,
                      );
                      setState(() {
                        isFavorite = true;
                      });
                    } catch (e) {
                      print("Error adding to favorites: $e");
                    }
                  }
                },
              ),
              // Doctor Details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Image.network(
                      widget.image!,
                      height: 60,
                      width: 70,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      widget.doctorname ?? '',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.right,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      widget.speciality,
                      style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                          color: Colors.grey),
                      textAlign: TextAlign.right,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      widget.degree,
                      style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                          color: Colors.grey),
                      textAlign: TextAlign.right,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

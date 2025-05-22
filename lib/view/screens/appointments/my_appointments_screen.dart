// ignore_for_file: library_private_types_in_public_api, avoid_print
import 'package:binrushd_medical_center/view/screens/tabs_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:binrushd_medical_center/controller/Auth/login_provider.dart';

class MyAppointmentsScreen extends StatelessWidget {
  const MyAppointmentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final loginProvider = Provider.of<LoginProvider>(context, listen: false);
    final token = loginProvider.token;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'حجوزاتي',
          style: TextStyle(
              fontFamily: 'Arial', // Change to your preferred Arabic font
              fontWeight: FontWeight.w700,
              fontSize: 18),
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
                "يجب التسجيل لتري حجوزاتك",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
            )
          : Consumer<LoginProvider>(
              builder: (context, provider, child) {
                final reservations =
                    provider.loginResponse?.data!.user.reservations ?? [];
                if (reservations.isEmpty) {
                  return const Center(
                    child: Text(
                      "لا توجد حجوزات حاليًا",
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
                  itemCount: reservations.length,
                  itemBuilder: (context, index) {
                    final reservation = reservations[index];
                    final doctor = reservation.doctor;
                    final doctorName = doctor != null
                        ? "${doctor.fname} ${doctor.lname}"
                        : "Unknown Doctor";
                    final docId = doctor?.id ?? 0;

                    return Column(
                      children: [
                        DoctorCard(
                          name: reservation.branch.name,
                          doctorname: doctorName,
                          location: reservation.branch.address,
                          token: token,
                          docId: docId,
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
  final String name;
  final String location;
  final String? doctorname;
  final int? docId;
  final String token;

  const DoctorCard({
    super.key,
    required this.name,
    required this.location,
    required this.doctorname,
    this.docId,
    required this.token,
  });

  @override
  _DoctorCardState createState() => _DoctorCardState();
}

class _DoctorCardState extends State<DoctorCard> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
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
              // Doctor Details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      widget.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.right,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      widget.doctorname ?? '',
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.right,
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            widget.location,
                            style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 12,
                                fontWeight: FontWeight.w400),
                            textAlign: TextAlign.right,
                          ),
                        ),
                      ],
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

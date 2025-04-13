// ignore_for_file: library_private_types_in_public_api, unused_field
import 'package:binrushd_medical_center/controller/Auth/login_provider.dart';
import 'package:binrushd_medical_center/view/screens/appointments/make_appointments_screen.dart';
import 'package:binrushd_medical_center/view/screens/branches/full_map_screen.dart';
import 'package:binrushd_medical_center/view/widgets/show_signup_dialog_widget.dart';
import 'package:flutter/material.dart';
import 'package:binrushd_medical_center/constants/constants.dart';
import 'package:binrushd_medical_center/controller/branches/fetch_individual_branch_provider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class BranchDetailsScreen extends StatefulWidget {
  final int? branchId;
  final String? image;
  const BranchDetailsScreen({super.key, this.branchId, this.image});

  @override
  _BranchDetailsScreenState createState() => _BranchDetailsScreenState();
}

class _BranchDetailsScreenState extends State<BranchDetailsScreen> {
  GoogleMapController? _mapController;
  @override
  void initState() {
    super.initState();
    // Fetch branch data when the screen is initialized
    if (widget.branchId != null) {
      Provider.of<FetchIndividualBranchProvider>(context, listen: false)
          .fetchInduividualBranches(context, widget.branchId);
    }
  }

  @override
  Widget build(BuildContext context) {
    final logprov = Provider.of<LoginProvider>(context, listen: false);
    final token = logprov.token;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Top Image
                Stack(
                  children: [
                    // The top image
                    Image.network(
                      widget.image!, // Replace with your image URL
                      height: 200,
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                    // Back arrow button positioned at the top right
                    Positioned(
                      top: 22.0, // Distance from the top
                      right: 0.0, // Distance from the right
                      child: IconButton(
                        onPressed: () {
                          Navigator.pop(context); // Navigate back
                        },
                        icon: const Icon(Icons.arrow_forward_ios,
                            color: Colors.white),
                      ),
                    ),
                  ],
                ),

                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      // Title
                      Consumer<FetchIndividualBranchProvider>(
                        builder: (context, provider, child) {
                          // Check if the data is loaded
                          if (provider.branchResponse == null) {
                            return const Center(
                                child: CircularProgressIndicator());
                          }

                          final branch = provider.branchResponse!.data;

                          return Center(
                            child: Text(
                              branch.name,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                                color: backgroundColor,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 10),
                      // Working Hours
                      const Text(
                        'ساعات العمل',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 8),
                      // Schedule
                      Consumer<FetchIndividualBranchProvider>(
                        builder: (context, provider, child) {
                          if (provider.branchResponse == null) {
                            return const Center(
                                child: CircularProgressIndicator());
                          }

                          final worktimes =
                              provider.branchResponse!.data.worktimes;
                          final branch = provider.branchResponse!.data;

                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ScheduleItem(
                                  day: 'السبت', time: worktimes.saturday),
                              const SizedBox(
                                height: 8,
                              ),
                              ScheduleItem(
                                  day: 'الأحد', time: worktimes.sunday),
                              const SizedBox(
                                height: 8,
                              ),
                              ScheduleItem(
                                  day: 'الاثنين', time: worktimes.monday),
                              const SizedBox(
                                height: 8,
                              ),
                              ScheduleItem(
                                  day: 'الثلاثاء', time: worktimes.tuesday),
                              const SizedBox(
                                height: 8,
                              ),
                              ScheduleItem(
                                  day: 'الأربعاء', time: worktimes.wednesday),
                              const SizedBox(
                                height: 8,
                              ),
                              ScheduleItem(
                                  day: 'الخميس', time: worktimes.thursday),
                              const SizedBox(
                                height: 8,
                              ),
                              ScheduleItem(
                                  day: 'الجمعة', time: worktimes.friday),
                              const SizedBox(
                                height: 15,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    height: 300,
                                    margin: const EdgeInsets.only(top: 16),
                                    child: GoogleMap(
                                      myLocationEnabled: true,
                                      myLocationButtonEnabled: true,
                                      onMapCreated: (controller) {
                                        _mapController = controller;
                                      },
                                      initialCameraPosition: CameraPosition(
                                        target: LatLng(
                                            branch.latitude, branch.longitude),
                                        zoom: 14,
                                      ),
                                      markers: {
                                        Marker(
                                          markerId:
                                              const MarkerId('branch_location'),
                                          position: LatLng(branch.latitude,
                                              branch.longitude),
                                          infoWindow:
                                              InfoWindow(title: branch.name),
                                        ),
                                      },
                                    ),
                                  ),
                                  Center(
                                    child: TextButton.icon(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                FullScreenMapScreen(
                                              latitude: branch.latitude,
                                              longitude: branch.longitude,
                                              branchName: branch.name,
                                            ),
                                          ),
                                        );
                                      },
                                      icon: const Icon(Icons.fullscreen,
                                          color: Colors.blue),
                                      label: const Text(
                                        'عرض الخريطة بحجم كامل',
                                        style: TextStyle(color: Colors.blue),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: ElevatedButton(
                                    onPressed: () {
                                      if (token == null || token.isEmpty) {
                                        showDialog(
                                          context: context,
                                          builder: (context) =>
                                              const CustomAlertDialog(
                                            title: 'تنبيه',
                                            message:
                                                'يجب التسجيل بحساب لكي تحجز موعد',
                                          ),
                                        );
                                      } else {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const MakeAppointmentScreen(),
                                          ),
                                        );
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color.fromRGBO(
                                          149, 0, 0, 1), // Dark red color
                                      minimumSize: const Size(
                                          200, 50), // Adjust width and height
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                            16), // Rounded corners
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 100, vertical: 12),
                                    ),
                                    child: const Text(
                                      'حجز موعد',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white, // White text color
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Align(
          //   alignment: Alignment.bottomCenter,
          //   child: Padding(
          //     padding: const EdgeInsets.all(10.0),
          //     child: ElevatedButton(
          //       onPressed: () {
          //         Navigator.push(
          //             context,
          //             MaterialPageRoute(
          //                 builder: (context) => const MakeAppointmentScreen()));
          //       },
          //       style: ElevatedButton.styleFrom(
          //         backgroundColor:
          //             const Color.fromRGBO(149, 0, 0, 1), // Dark red color
          //         minimumSize: const Size(200, 50), // Adjust width and height
          //         shape: RoundedRectangleBorder(
          //           borderRadius: BorderRadius.circular(16), // Rounded corners
          //         ),
          //         padding:
          //             const EdgeInsets.symmetric(horizontal: 100, vertical: 12),
          //       ),
          //       child: const Text(
          //         'حجز موعد',
          //         style: TextStyle(
          //           fontSize: 14,
          //           fontWeight: FontWeight.w600,
          //           color: Colors.white, // White text color
          //         ),
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}

class ScheduleItem extends StatelessWidget {
  final String day;
  final String time;

  const ScheduleItem({super.key, required this.day, required this.time});

  @override
  Widget build(BuildContext context) {
    // Split the time into two lines
    final firstLine = time.length > 34 ? time.substring(0, 34) : time;
    final secondLine = time.length > 34 ? time.substring(34) : '';

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment:
            MainAxisAlignment.end, // Align everything to the right
        children: [
          // Display time first for RTL alignment
          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.end, // Align text to the right
              children: [
                Text(
                  firstLine,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                  ),
                  textAlign: TextAlign.right,
                ),
                if (secondLine.isNotEmpty)
                  Text(
                    secondLine,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                    ),
                    textAlign: TextAlign.right,
                  ),
              ],
            ),
          ),
          const SizedBox(width: 16), // Add spacing between time and day
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            reverse: true, // Ensure text scrolling starts from the right
            child: Text(
              day,
              style: const TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                  fontWeight: FontWeight.w500),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }
}

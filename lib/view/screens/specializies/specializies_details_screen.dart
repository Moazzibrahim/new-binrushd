// ignore_for_file: use_build_context_synchronously

import 'package:binrushd_medical_center/controller/Auth/login_provider.dart';
import 'package:binrushd_medical_center/controller/fetch_departments_provider.dart';
import 'package:binrushd_medical_center/view/screens/appointments/make_appointments_screen.dart';
import 'package:binrushd_medical_center/view/widgets/show_signup_dialog_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SpecializiesDetailsScreen extends StatefulWidget {
  final int? depid; // Department ID
  final String? depimage; // Department image URL
  const SpecializiesDetailsScreen({
    super.key,
    required this.depid,
    required this.depimage,
  });

  @override
  State<SpecializiesDetailsScreen> createState() =>
      _SpecializiesDetailsScreenState();
}

class _SpecializiesDetailsScreenState extends State<SpecializiesDetailsScreen> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    // Fetch department data on init
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Provider.of<FetchDepartmentsProvider>(context, listen: false)
          .fetchDepartmentsspecific(context, widget.depid ?? 0);
      setState(() {
        _isLoading = false;
      });
    });
  }

  List<Widget> _buildParagraphs(String text) {
    // Use a regular expression to split the text, retaining the full stop at the end of each sentence
    RegExp regex = RegExp(r'[^.]*\..*?');
    List<String> paragraphs = regex
        .allMatches(text)
        .map((match) => match.group(0)!)
        .where((p) => p.trim().isNotEmpty)
        .toList();

    return paragraphs
        .map(
          (paragraph) => Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: 16.0), // Consistent padding for all texts
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  paragraph.trim(),
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.start, // Align text to the right in RTL
                ),
                const SizedBox(height: 8), // Space between paragraphs
              ],
            ),
          ),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final logProvider = Provider.of<LoginProvider>(context, listen: false);
    final token = logProvider.token;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          _isLoading
              ? const Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Top Image
                      Stack(
                        children: [
                          Image.network(
                            widget.depimage ?? '',
                            height: 200,
                            fit: BoxFit.cover,
                            width: double.infinity,
                          ),
                          Positioned(
                            top: 22.0,
                            right: 0.0,
                            child: IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: const Icon(Icons.arrow_forward_ios,
                                  color: Colors.black),
                            ),
                          ),
                        ],
                      ),

                      // Department-Specific Content
                      Padding(
                        padding: const EdgeInsets.fromLTRB(
                            16.0, 16.0, 16.0, 100.0), // Added bottom padding
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Consumer<FetchDepartmentsProvider>(
                              builder: (context, provider, child) {
                                final departmentData =
                                    provider.departmentResponses;
                                if (departmentData == null) {
                                  return const SizedBox.shrink();
                                }
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    // Title
                                    Center(
                                      child: Text(
                                        departmentData.data.name,
                                        style: const TextStyle(
                                          fontSize: 25,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Directionality(
                                      textDirection: TextDirection.rtl,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment
                                            .start, // Align all paragraphs to the same side
                                        children: _buildParagraphs(
                                            departmentData.data.brief),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                            const SizedBox(height: 10),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
          // Book Appointment Button
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: ElevatedButton(
                onPressed: () {
                  if (token == null || token.isEmpty) {
                    showDialog(
                      context: context,
                      builder: (context) => const CustomAlertDialog(
                        title: 'تنبيه',
                        message: 'يجب التسجيل بحساب لكي تحجز موعد',
                      ),
                    );
                  } else {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const MakeAppointmentScreen(),
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromRGBO(149, 0, 0, 1),
                  minimumSize: const Size(200, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 100, vertical: 12),
                ),
                child: const Text(
                  'حجز موعد',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

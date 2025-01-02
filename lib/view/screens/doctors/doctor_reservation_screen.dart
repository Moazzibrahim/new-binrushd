// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:binrushd_medical_center/constants/constants.dart';
import 'package:binrushd_medical_center/view/screens/home_screen.dart';

class DoctorReservationScreen extends StatefulWidget {
  const DoctorReservationScreen({super.key});

  @override
  _DoctorReservationScreenState createState() =>
      _DoctorReservationScreenState();
}

class _DoctorReservationScreenState extends State<DoctorReservationScreen> {
  String? _selectedTime;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Background image (doctor image)
          Positioned.fill(
            child: Image.asset(
              'assets/images/doctorbig.png', // Replace with your image path
              fit: BoxFit.cover,
            ),
          ),
          // Card with curved top
          Positioned(
            top: MediaQuery.of(context).size.height * 0.20,
            left: 0,
            right: 0,
            bottom: 0,
            child: ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(45.0)),
              child: Container(
                color: Colors.white,
                padding: const EdgeInsets.all(20.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Text(
                        'دكتور/ عبد الله محمد',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'أخصائي جراحة عيون',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 18,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'الرياض - المملكة العربية السعودية',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 18,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 20),
                      Text(
                        'تحديد التاريخ',
                        textAlign: TextAlign.right,
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: backgroundColor),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: List.generate(5, (index) {
                          return Column(
                            children: [
                              const Text('2024 أكتوبر',
                                  style: TextStyle(fontSize: 13)),
                              Text(
                                '${23 + index}',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: index == 2
                                      ? backgroundColor
                                      : Colors.black,
                                ),
                              ),
                              const Text(
                                'الثلاثاء',
                                style: TextStyle(fontSize: 16),
                              ),
                            ],
                          );
                        }),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        'تحديد توقيت',
                        textAlign: TextAlign.right,
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: backgroundColor),
                      ),
                      const SizedBox(height: 10),
                      Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        children: [
                          _timeButton('09:00 صباحا'),
                          _timeButton('11:00 صباحا', isSelected: true),
                          _timeButton('01:00 مساء'),
                          _timeButton('09:00 مساء'),
                          _timeButton('10:00 مساء'),
                        ],
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          // Handle confirmation
                          _showBookingConfirmationDialog(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: backgroundColor,
                          padding: const EdgeInsets.symmetric(
                              vertical: 16.0, horizontal: 40.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        child: const Text(
                          'تأكيد',
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _timeButton(String time, {bool isSelected = false}) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedTime = time;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        decoration: BoxDecoration(
          color: isSelected || _selectedTime == time
              ? backgroundColor
              : Colors.grey[200],
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected || _selectedTime == time
                ? backgroundColor
                : Colors.grey,
          ),
        ),
        child: Text(
          time,
          style: TextStyle(
            fontSize: 16,
            color: isSelected || _selectedTime == time
                ? Colors.white
                : Colors.black,
          ),
        ),
      ),
    );
  }

  void _showBookingConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Container(
            padding: const EdgeInsets.all(20),
            height: 500,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset("assets/images/icon.png"),
                const SizedBox(height: 20),
                const Text(
                  'تهانينا !',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'لقد تم حجز موعد مع دكتور/ عبد الرحمن محمد بنجاح.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16),
                ),
                const Divider(thickness: 1),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        const Text('التوقيت', style: TextStyle(fontSize: 16)),
                        const SizedBox(height: 5),
                        Text(
                          '11:00 صباحا',
                          style: TextStyle(
                            fontSize: 13,
                            color: backgroundColor,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        const Text('التاريخ', style: TextStyle(fontSize: 16)),
                        const SizedBox(height: 5),
                        Text(
                          'الأحد-30 أكتوبر 2024',
                          style: TextStyle(
                            fontSize: 13,
                            color: backgroundColor,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        const Text('رقم الحجز', style: TextStyle(fontSize: 16)),
                        const SizedBox(height: 5),
                        Text(
                          '103',
                          style: TextStyle(
                            fontSize: 13,
                            color: backgroundColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const Spacer(),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const HomePage()));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: backgroundColor,
                    padding: const EdgeInsets.symmetric(
                        vertical: 16.0, horizontal: 40.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  child: const Text(
                    'العودة للرئيسية',
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

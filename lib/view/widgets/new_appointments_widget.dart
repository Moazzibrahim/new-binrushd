// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:binrushd_medical_center/constants/constants.dart';

class AppointmentsFilterWidget extends StatelessWidget {
  const AppointmentsFilterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(25),
          ),
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "فلترة المواعيد",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: backgroundColor,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.arrow_forward_ios),
                      color: Colors.grey,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // Dropdowns
                _buildSection("تحديد فرع"),
                _buildDropdown("اختار التخصص الذي تريده"),
                const SizedBox(height: 10),

                _buildSection("اسم الدكتور"),
                _buildDropdown("اختار التخصص الذي تريده"),
                const SizedBox(height: 10),

                _buildSection("تحديد تخصص"),
                _buildDropdown("اختار التخصص الذي تريده"),
                const SizedBox(height: 20),

                // Date Selection
                _buildSection("تحديد التاريخ"),
                _buildDateSelector(),
                const SizedBox(height: 20),

                // Time Selection
                _buildSection("تحديد توقيت"),
                _buildTimeSelector(),
                const SizedBox(height: 30),

                // Filter Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: backgroundColor,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      "فلترة",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSection(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: backgroundColor,
        ),
      ),
    );
  }

  Widget _buildDropdown(String hintText) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(10),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          items: const [],
          onChanged: (value) {},
          hint: Text(
            hintText,
            style: TextStyle(fontSize: 14, color: Colors.grey.shade500),
          ),
        ),
      ),
    );
  }

  Widget _buildDateSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("<< أكتوبر 2024 >>",
            style: TextStyle(fontSize: 14, color: Colors.grey)),
        const SizedBox(height: 8),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children:
                ["الخميس", "الأربعاء", "الثلاثاء", "الاثنين", "الأحد", "السبت"]
                    .map((day) => Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4.0),
                          child: Column(
                            children: [
                              Text(day, style: const TextStyle(fontSize: 12)),
                              Container(
                                margin: const EdgeInsets.only(top: 5),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: day == "الثلاثاء"
                                      ? backgroundColor
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Text(
                                  "23",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: day == "الثلاثاء"
                                        ? Colors.white
                                        : Colors.black,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ))
                    .toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildTimeSelector() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildTimeCard("11:00 صباحاً", true),
        _buildTimeCard("10:00 صباحاً", false),
        _buildTimeCard("09:00 صباحاً", false),
      ],
    );
  }

  Widget _buildTimeCard(String time, bool isSelected) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isSelected ? backgroundColor : Colors.grey.shade200,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        time,
        style: TextStyle(
          color: isSelected ? Colors.white : Colors.black,
          fontSize: 14,
        ),
      ),
    );
  }
}

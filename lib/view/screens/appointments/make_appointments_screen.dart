// ignore_for_file: library_private_types_in_public_api, unused_field, avoid_print, unused_local_variable

import 'package:flutter/material.dart';
import 'package:binrushd_medical_center/constants/constants.dart';
import 'package:binrushd_medical_center/controller/Auth/login_provider.dart';
import 'package:binrushd_medical_center/controller/branches/fetch_branches_provider.dart';
import 'package:binrushd_medical_center/controller/doctors/fetch_doctors_data_provider.dart';
import 'package:provider/provider.dart';
import 'package:binrushd_medical_center/controller/make_reservation_provider.dart';

class MakeAppointmentScreen extends StatefulWidget {
  const MakeAppointmentScreen({super.key});

  @override
  _MakeAppointmentScreenState createState() => _MakeAppointmentScreenState();
}

class _MakeAppointmentScreenState extends State<MakeAppointmentScreen> {
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  String? _selectedSurvey; // Default value
  String? _selectedBranchId; // Store branch ID here
  String? __selectedDoctorId;

  @override
  void initState() {
    super.initState();
    // Fetch branches when the screen is initialized
    Provider.of<FetchBranchesProvider>(context, listen: false)
        .fetchBranches(context);
    Provider.of<FetchDoctorsDataProvider>(context, listen: false)
        .fetchDoctorsData(context);
  }

  @override
  Widget build(BuildContext context) {
    final branchesProvider = Provider.of<FetchBranchesProvider>(context);
    final branches = branchesProvider.branchResponse?.data ?? [];
    final doctoresprovider = Provider.of<FetchDoctorsDataProvider>(context);
    final doctors = doctoresprovider.doctorsResponse?.data ?? [];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          "حجز موعد",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.arrow_forward_ios),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTextField(
                label: "الاسم بالكامل",
                hint: " اسمك ",
                icon: Icons.person,
                controller: _fullNameController,
              ),
              const SizedBox(height: 16),
              _buildTextField(
                label: "الإيميل",
                hint: " ايميلك",
                icon: Icons.email,
                controller: _emailController,
              ),
              const SizedBox(height: 16),
              _buildTextField(
                label: "رقم الهاتف",
                hint: "رقم هاتفك",
                icon: Icons.phone,
                controller: _phoneController,
              ),
              const SizedBox(height: 16),
              _buildDropdown(
                label: "كيف سمعت عنا؟",
                value: _selectedSurvey,
                onChanged: (value) {
                  setState(() {
                    _selectedSurvey = value;
                  });
                },
                items: const [
                  DropdownMenuItem(value: "internet", child: Text("internet")),
                  DropdownMenuItem(value: "sms", child: Text("sms")),
                  DropdownMenuItem(
                      value: "WordOfMouth", child: Text("WordOfMouth")),
                ],
              ),
              const SizedBox(height: 16),
              _buildDropdown(
                label: "اختار الفرع",
                value: _selectedBranchId,
                onChanged: (value) {
                  setState(() {
                    _selectedBranchId = value;
                  });
                },
                items: branches.map((branch) {
                  return DropdownMenuItem<String>(
                    value: branch.id.toString(), // Store the ID
                    child: Text(branch.name),
                  );
                }).toList(),
              ),
              const SizedBox(height: 16),
              _buildDropdown(
                label: "اختار الطبيب",
                value: __selectedDoctorId,
                onChanged: (value) {
                  setState(() {
                    __selectedDoctorId = value;
                  });
                },
                items: doctors.map((doctor) {
                  return DropdownMenuItem<String>(
                    value: doctor.id.toString(), // Store the ID
                    child: Text("${doctor.fname} ${doctor.lname}"),
                  );
                }).toList(),
              ),
              const SizedBox(height: 32),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    backgroundColor: backgroundColor,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 120, vertical: 15),
                  ),
                  onPressed: _submitForm,
                  child: const Text(
                    "إرسال",
                    style: TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _submitForm() {
    final String customerName = _fullNameController.text.trim();
    final String email = _emailController.text.trim();
    final String phone = _phoneController.text.trim();
    final String survey = _selectedSurvey ?? ""; // Default if null
    final String branch = _selectedBranchId ?? ""; // Use ID from dropdown
    final String doctorr = __selectedDoctorId ?? "";

    // Validate fields
    if (customerName.isEmpty) {
      _showError("الاسم بالكامل مطلوب");
      return;
    }
    if (email.isEmpty || !_isValidEmail(email)) {
      _showError("البريد الإلكتروني غير صالح أو فارغ");
      return;
    }
    if (phone.isEmpty || !_isValidPhone(phone)) {
      _showError("رقم الهاتف غير صالح أو فارغ");
      return;
    }
    if (survey.isEmpty) {
      _showError("يرجى اختيار كيف سمعت عنا");
      return;
    }
    if (branch.isEmpty) {
      _showError("يرجى اختيار الفرع");
      return;
    }
    if (doctorr.isEmpty) {
      _showError("يرجى اختيار الطبيب");
      return;
    }

    final provider =
        Provider.of<MakeReservationProvider>(context, listen: false);
    final loginProvider = Provider.of<LoginProvider>(context, listen: false);
    if (loginProvider.token == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(' يرجي التسجيل بحساب شخصي لكي تحجز معاد '),
        ),
      );
    }

    // Make the API call
    provider.sendPostRequest(
        customerName: customerName,
        email: email,
        phone: phone,
        isOffer: 1, // Example value
        offerId: 10, // Example value
        branchId: int.parse(branch), // Parse the branch ID
        docId: int.parse(__selectedDoctorId!),
        survey: survey,
        context: context,
        token: loginProvider.token!);
  }

// Function to validate email
  bool _isValidEmail(String email) {
    final emailRegex =
        RegExp(r"^[a-zA-Z0-9._%-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$");
    return emailRegex.hasMatch(email);
  }

// Function to validate phone number
  bool _isValidPhone(String phone) {
    final phoneRegex = RegExp(r"^\+?[0-9]{10,15}$");
    return phoneRegex.hasMatch(phone);
  }

// Function to show error message
  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  Widget _buildTextField({
    required String label,
    required String hint,
    required IconData icon,
    required TextEditingController controller,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          textAlign: TextAlign.right,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle:
                const TextStyle(fontSize: 10, fontWeight: FontWeight.w500),
            suffixIcon: Icon(icon),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          ),
        ),
      ],
    );
  }

  Widget _buildDropdown({
    required String label,
    required String? value,
    required Function(String?) onChanged,
    required List<DropdownMenuItem<String>> items,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            contentPadding: const EdgeInsets.symmetric(horizontal: 8),
          ),
          value: value,
          isExpanded: true, // Makes the dropdown take full width
          icon: const Icon(Icons.arrow_drop_down),
          iconSize: 24,
          hint: const Align(
            alignment: Alignment.centerRight,
            child: Text(
              "اختر",
              style: TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                  fontWeight: FontWeight.w500),
            ),
          ),
          items: items,
          onChanged: onChanged,
        ),
      ],
    );
  }
}

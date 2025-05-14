// ignore_for_file: library_private_types_in_public_api
import 'dart:developer';

import 'package:binrushd_medical_center/model/doctors_model.dart';
import 'package:binrushd_medical_center/view/screens/Auth/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:binrushd_medical_center/constants/constants.dart';
import 'package:binrushd_medical_center/controller/Auth/login_provider.dart';
import 'package:binrushd_medical_center/controller/branches/fetch_branches_provider.dart';
import 'package:binrushd_medical_center/controller/doctors/fetch_doctors_data_provider.dart';
import 'package:provider/provider.dart';
import 'package:binrushd_medical_center/controller/make_reservation_provider.dart';

class MakeAppointmentScreen extends StatefulWidget {
  final int? docid;
  final int? branchId;
  final String? doctorName;
  final String? branchName;
  const MakeAppointmentScreen(
      {this.docid, this.branchId, this.doctorName, this.branchName, super.key});

  @override
  _MakeAppointmentScreenState createState() => _MakeAppointmentScreenState();
}

class _MakeAppointmentScreenState extends State<MakeAppointmentScreen> {
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  String? _selectedSurvey;
  String? _selectedBranchId;
  String? __selectedDoctorId;
  List<dynamic> filteredBranches = [];
  List<dynamic> filteredDoctors = [];

  @override
  void initState() {
    super.initState();

    // Initialize selected IDs from widget if they exist
    if (widget.docid != null) {
      __selectedDoctorId = widget.docid.toString();
    }
    if (widget.branchId != null) {
      _selectedBranchId = widget.branchId.toString();
    }
    log("docid: ${widget.docid}");
    log("branchId: ${widget.branchId}");
    // Fetch branches and then filter doctors if branch is preselected
    Provider.of<FetchBranchesProvider>(context, listen: false)
        .fetchBranches(context)
        .then((_) {
      if (mounted && widget.branchId != null) {
        _filterDoctorsByBranch(widget.branchId.toString());
      }
    });

    // Fetch doctors and then filter branches if doctor is preselected
    Provider.of<FetchDoctorsDataProvider>(context, listen: false)
        .fetchDoctorsData(context)
        .then((_) {
      if (mounted && widget.docid != null) {
        _filterBranchesByDoctor(widget.docid.toString());
      }
    });
  }

  void _filterDoctorsByBranch(String branchId) {
    final branchesProvider =
        Provider.of<FetchBranchesProvider>(context, listen: false);
    final branches = branchesProvider.branchResponse?.data ?? [];

    setState(() {
      _selectedBranchId = branchId;
      filteredDoctors = [];

      // Find the selected branch and get its doctors
      for (var branch in branches) {
        if (branch.id.toString() == branchId) {
          filteredDoctors = branch.doctors;
          break;
        }
      }
    });
  }

  void _filterBranchesByDoctor(String doctorId) {
    final doctorsProvider =
        Provider.of<FetchDoctorsDataProvider>(context, listen: false);
    final doctors = doctorsProvider.doctorsResponse?.data ?? [];

    setState(() {
      __selectedDoctorId = doctorId;
      filteredBranches = [];

      // Find the selected doctor and get its branches
      for (var doctor in doctors) {
        if (doctor.id.toString() == doctorId) {
          filteredBranches = doctor.branches;
          break;
        }
      }
    });
  }

  bool _containsItemWithValue(
      List items, String? value, String Function(dynamic) getId) {
    if (value == null) return false;
    return items.any((item) => getId(item) == value);
  }

  @override
  Widget build(BuildContext context) {
    final branchesProvider = Provider.of<FetchBranchesProvider>(context);
    final branches = branchesProvider.branchResponse?.data ?? [];
    final doctorsProvider = Provider.of<FetchDoctorsDataProvider>(context);
    final doctors = doctorsProvider.doctorsResponse?.data ?? [];

    // Get unique doctors (remove duplicates by ID)
    final uniqueDoctors = doctors
        .fold<Map<int, dynamic>>({}, (map, doctor) {
          map[doctor.id] = doctor;
          return map;
        })
        .values
        .toList();

    // Get unique branches (remove duplicates by ID)
    final uniqueBranches = branches
        .fold<Map<int, dynamic>>({}, (map, branch) {
          map[branch.id] = branch;
          return map;
        })
        .values
        .toList();

    // Determine which lists to use for dropdowns
    final branchesToShow =
        filteredBranches.isNotEmpty ? filteredBranches : uniqueBranches;
    final doctorsToShow =
        filteredDoctors.isNotEmpty ? filteredDoctors : uniqueDoctors;

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
            onPressed: () => Navigator.pop(context),
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
                  DropdownMenuItem(value: "internet", child: Text("الانترنت")),
                  DropdownMenuItem(value: "sms", child: Text("رسايل الجوال")),
                  DropdownMenuItem(
                      value: "friends", child: Text(" الاهل والاصدقاء")),
                ],
              ),
              const SizedBox(height: 16),
              _buildDropdown(
                label: "اختار الفرع",
                value: _containsItemWithValue(branchesToShow, _selectedBranchId,
                        (item) => item.id.toString())
                    ? _selectedBranchId
                    : null,
                onChanged: (value) {
                  _selectedBranchId = value;
                  _filterDoctorsByBranch(value!);
                },
                items: branchesToShow.map((branch) {
                  return DropdownMenuItem<String>(
                    value: branch.id.toString(),
                    child: Text(branch.name),
                  );
                }).toList(),
              ),
              const SizedBox(height: 16),
              if (doctorsToShow.isNotEmpty)
                _buildDropdown(
                  label: "اختار الطبيب",
                  value: _containsItemWithValue(doctorsToShow,
                          __selectedDoctorId, (item) => item.id.toString())
                      ? __selectedDoctorId
                      : null,

                  onChanged: widget.docid != null
                      ? (_) {} // Disable dropdown if doctor is preselected
                      : (value) {
                          __selectedDoctorId = value;
                          _filterBranchesByDoctor(value!);
                        },
                  items: doctorsToShow.map((doctor) {
                    String doctorName;
                    if (doctor is Doctors) {
                      doctorName = "${doctor.fname} ${doctor.lname}".trim();
                    } else {
                      doctorName = doctor.name;
                    }
                    return DropdownMenuItem<String>(
                      value: doctor.id.toString(),
                      child: Text(doctorName),
                    );
                  }).toList(),
                  isEnabled:
                      widget.docid == null, // Disable if doctor is preselected
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
    // if (!_isValidEmail(email)) {
    //   _showError("البريد الإلكتروني غير صالح  ");
    //   return;
    // }
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
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("تنبيه"),
            content: const Text('يرجي التسجيل بحساب شخصي لكي تحجز معاد'),
            actions: <Widget>[
              TextButton(
                child: const Text("حسناً"),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              const LoginScreen())); // Close the dialog
                },
              ),
            ],
          );
        },
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

// // Function to validate email
//   bool _isValidEmail(String email) {
//     final emailRegex =
//         RegExp(r"^[a-zA-Z0-9._%-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$");
//     return emailRegex.hasMatch(email);
//   }

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
    bool isEnabled = true,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        AbsorbPointer(
          absorbing: !isEnabled, // disables interaction if false
          child: DropdownButtonFormField<String>(
            decoration: InputDecoration(
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
              contentPadding: const EdgeInsets.symmetric(horizontal: 8),
            ),
            value: value,
            isExpanded: true,
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
            onChanged: isEnabled ? onChanged : (_) {},
          ),
        ),
      ],
    );
  }
}

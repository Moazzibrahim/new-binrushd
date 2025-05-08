import 'package:binrushd_medical_center/view/screens/tabs_screen.dart';
import 'package:flutter/material.dart';
import 'package:binrushd_medical_center/controller/Auth/login_provider.dart';
import 'package:binrushd_medical_center/controller/profile_provider.dart';
import 'package:provider/provider.dart';

class MyProfileScreen extends StatelessWidget {
  const MyProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final profileProvider = Provider.of<ProfileProvider>(context);
    final logprov = Provider.of<LoginProvider>(context, listen: false);

    // ✅ Check if token is null BEFORE using it
    if (logprov.token == null) {
      return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text(
            'حسابي',
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
                  logprov.token == null
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
        body: const Center(
          child: Text(
            "يجب التسجيل لتري حسابك",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
        ),
      );
    }

    final token = logprov.token!;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (profileProvider.authUserResponse == null) {
        profileProvider.fetchProfile(
          token: token,
          context: context,
        );
      }
    });

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text(
            'البيانات الشخصية',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: profileProvider.authUserResponse != null
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 20),
                              buildTextField(
                                label: 'الاسم بالكامل',
                                hint:
                                    '${profileProvider.authUserResponse!.data.fname} ${profileProvider.authUserResponse!.data.lname}',
                                icon: Icons.person,
                              ),
                              const SizedBox(height: 10),
                              buildTextField(
                                label: 'الإيميل',
                                hint: profileProvider
                                    .authUserResponse!.data.email,
                                icon: Icons.email,
                              ),
                              const SizedBox(height: 10),
                              buildTextField(
                                label: 'رقم الهاتف',
                                hint: profileProvider
                                    .authUserResponse!.data.mobile,
                                icon: Icons.phone,
                              ),
                            ],
                          )
                        : const Center(child: CircularProgressIndicator()),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget buildTextField({
    required String label,
    required String hint,
    required IconData icon,
    bool obscureText = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        TextField(
          enabled: false, // Makes the TextField read-only
          obscureText: obscureText,
          textDirection: TextDirection.rtl,
          decoration: InputDecoration(
            hintText: hint,
            hintTextDirection: TextDirection.rtl,
            prefixIcon: Icon(icon, color: Colors.grey),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
        ),
      ],
    );
  }
}

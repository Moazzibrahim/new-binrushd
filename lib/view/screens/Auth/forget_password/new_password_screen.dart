// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:binrushd_medical_center/constants/constants.dart';
import 'package:binrushd_medical_center/controller/Auth/reset_password_provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class NewPasswordScreen extends StatefulWidget {
  final String? tokens;
  const NewPasswordScreen({super.key, this.tokens});

  @override
  _NewPasswordScreenState createState() => _NewPasswordScreenState();
}

class _NewPasswordScreenState extends State<NewPasswordScreen> {
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  bool _isPasswordVisible = false;
  bool _isConfPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'انشاء كلمة سر جديدة',
          style: TextStyle(
              color: backgroundColor,
              fontWeight: FontWeight.w700,
              fontSize: 20),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.arrow_forward_ios, color: Colors.grey),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset("assets/images/newp.svg"),
            const SizedBox(height: 20),
            const Text(
              'إنشاء كلمة سر جديدة',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.grey,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            buildLabeledTextField(
              label: 'ادخل كلمة سر جديدة',
              controller: passwordController,
              icon: Icons.visibility,
              obscureText: !_isPasswordVisible,
              onToggleVisibility: () {
                setState(() {
                  _isPasswordVisible = !_isPasswordVisible;
                });
              },
            ),
            const SizedBox(height: 20),
            buildLabeledTextField(
              label: 'تأكيد كلمة السر',
              controller: confirmPasswordController,
              icon: Icons.visibility,
              obscureText: !_isConfPasswordVisible,
              onToggleVisibility: () {
                setState(() {
                  _isConfPasswordVisible = !_isConfPasswordVisible;
                });
              },
            ),
            const SizedBox(height: 120),
            ElevatedButton(
              onPressed: () async {
                final password = passwordController.text.trim();
                final confirmPassword = confirmPasswordController.text.trim();

                if (password.isEmpty || confirmPassword.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('يرجى إدخال كلمة المرور وتأكيدها.'),
                    ),
                  );
                  return;
                }

                if (password != confirmPassword) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('كلمتا المرور غير متطابقتين.'),
                    ),
                  );
                  return;
                }

                // Call ResetPasswordProvider
                await Provider.of<ResetPasswordProvider>(context, listen: false)
                    .resetPasswordP(
                  password: password,
                  confPassword: confirmPassword,
                  token: widget.tokens,
                  context: context,
                );
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                backgroundColor: backgroundColor,
                padding:
                    const EdgeInsets.symmetric(horizontal: 140, vertical: 10),
                textStyle: const TextStyle(fontSize: 16),
              ),
              child: const Text(
                'حفظ',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildLabeledTextField({
    required String label,
    required TextEditingController controller,
    required IconData icon,
    bool obscureText = false,
    required VoidCallback onToggleVisibility,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 5),
        TextField(
          controller: controller,
          textAlign: TextAlign.right,
          obscureText: obscureText,
          decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15), // Rounded border
              borderSide: const BorderSide(color: Colors.grey, width: 1),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(color: Colors.grey, width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(color: Colors.grey, width: 1.5),
            ),
            hintText: '●●●●●●●',
            hintStyle: const TextStyle(color: Colors.grey),
            prefixIcon: IconButton(
              icon: Icon(
                obscureText ? Icons.visibility : Icons.visibility_off,
                color: Colors.grey,
              ),
              onPressed: onToggleVisibility,
            ),
          ),
        ),
      ],
    );
  }
}

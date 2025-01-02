import 'package:flutter/material.dart';
import 'package:binrushd_medical_center/constants/constants.dart';
import 'package:binrushd_medical_center/controller/Auth/forget_password_provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  int?
      _selectedOption; // Holds the selected card index (0 for phone, 1 for email)
  final TextEditingController _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _sendForgetPasswordRequest(BuildContext context) async {
    final email = _emailController.text.trim();

    if (email.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('يرجى إدخال البريد الإلكتروني.'),
        ),
      );
      return;
    }

    await Provider.of<ForgetPasswordProvider>(context, listen: false)
        .forgetPassword(email: email, context: context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.arrow_forward_ios, color: Colors.grey),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
        title: Text(
          'نسيت كلمة السر؟',
          style: TextStyle(
              color: backgroundColor,
              fontWeight: FontWeight.w700,
              fontSize: 20),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 30),
            // Lock Icon
            SvgPicture.asset("assets/images/forgetsvg.svg"),
            const SizedBox(height: 20),
            // Instruction Text
            Text(
              'قم بتحديد الطريقة التي تريد أن تسترد بها كلمة السر الخاصة بك.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Colors.grey[700],
              ),
            ),
            const SizedBox(height: 20),
            // Email Option Card
            GestureDetector(
              onTap: () {
                setState(() {
                  _selectedOption = 1; // Select the email option
                });
              },
              child: Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                color: backgroundColor,
                child: ListTile(
                  leading: Icon(Icons.email,
                      color: _selectedOption == 1
                          ? Colors.white
                          : backgroundColor),
                  title: Text(
                    'إرسال رمز عبر الإيميل الخاص بك',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: _selectedOption == 1 ? Colors.white : Colors.black,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Directionality(
              textDirection: TextDirection.rtl,
              child: TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'ادخل البريد الإلكتروني',
                  hintText: 'example@domain.com',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  prefixIcon: const Icon(Icons.email),
                ),
                keyboardType: TextInputType.emailAddress,
              ),
            ),
            const SizedBox(height: 60),
            // Send Button
            ElevatedButton(
              onPressed: () {
                _sendForgetPasswordRequest(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: backgroundColor,
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 135),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                'إرسال',
                style: TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                    fontWeight: FontWeight.w400),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

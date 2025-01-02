// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:binrushd_medical_center/constants/constants.dart';
import 'package:binrushd_medical_center/controller/Auth/login_provider.dart';
import 'package:binrushd_medical_center/view/screens/Auth/forget_password/forget_password_screen.dart';
import 'package:binrushd_medical_center/view/screens/Auth/sign_up_screen.dart';
import 'package:binrushd_medical_center/view/screens/home_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isChecked = false;
  int _selectedButtonIndex = -1;
  bool _isPasswordVisible =
      false; // State variable to toggle password visibility

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>(); // Form key for validation

  @override
  void initState() {
    super.initState();
    _loadSavedLoginInfo(); // Load saved email and password on start
  }

  Future<void> _loadSavedLoginInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? savedEmail = prefs.getString('saved_email');
    String? savedPassword = prefs.getString('saved_password');
    bool? isChecked = prefs.getBool('remember_me') ?? false;

    if (isChecked) {
      _emailController.text = savedEmail ?? '';
      _passwordController.text = savedPassword ?? '';
    }
    setState(() {
      _isChecked = isChecked;
    });
  }

  Future<void> _saveLoginInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (_isChecked) {
      await prefs.setString('saved_email', _emailController.text);
      await prefs.setString('saved_password', _passwordController.text);
      await prefs.setBool('remember_me', true);
    } else {
      await prefs.remove('saved_email');
      await prefs.remove('saved_password');
      await prefs.setBool('remember_me', false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Form(
          key: _formKey, // Wrap form for validation
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 55.h),
              SvgPicture.asset(
                'assets/images/illustation.svg',
                height: 200,
              ),
              SizedBox(height: 32.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.0.w),
                child: Text(
                  ' البريد الالكتروني',
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.end,
                ),
              ),
              SizedBox(height: 10.h),
              TextFormField(
                controller: _emailController,
                textAlign: TextAlign.right,
                decoration: InputDecoration(
                  hintText: 'ادخل بريدك الالكتروني بالكامل',
                  hintStyle: const TextStyle(
                    color: Color.fromRGBO(159, 159, 159, 1),
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                  suffixIcon: SizedBox(
                    width: 24, // Adjust the width to resize the icon
                    height: 24, // Adjust the height to resize the icon
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 2.0,
                        right: 12,
                      ), // Add padding for better alignment
                      child: FittedBox(
                        fit: BoxFit.none,
                        child: Image.asset(
                          "assets/images/vh.png",
                        ), // Ensures the image scales proportionally
                      ),
                    ),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 16,
                  ).copyWith(
                      left: 40), // Add extra space to the left for spacing
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
                    borderSide: const BorderSide(
                        color: Color.fromRGBO(231, 231, 231, 1), width: 1.5),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'الرجاء إدخال اسم المستخدم';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 16),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.0),
                child: Text(
                  'كلمة السر',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.end,
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _passwordController,
                textAlign: TextAlign.right,
                obscureText: !_isPasswordVisible,
                decoration: InputDecoration(
                  hintText: "●●●●●●●",
                  hintStyle: const TextStyle(color: Colors.grey),
                  prefixIcon: IconButton(
                    icon: Icon(
                      _isPasswordVisible
                          ? Icons.visibility_off
                          : Icons.visibility,
                      color: Colors.grey,
                      size: 20.0, // Set the desired size for the icon
                    ),
                    onPressed: () {
                      setState(() {
                        _isPasswordVisible =
                            !_isPasswordVisible; // Toggle the state
                      });
                    },
                  ),
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15), // Rounded border
                    borderSide: const BorderSide(
                        color: Color.fromRGBO(231, 231, 231, 1), width: 1),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: const BorderSide(color: Colors.grey, width: 1),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: const BorderSide(
                        color: Color.fromRGBO(231, 231, 231, 1), width: 1.5),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'الرجاء إدخال كلمة السر';
                  } else if (value.length < 6) {
                    return 'يجب أن تكون كلمة السر مكونة من 6 أحرف على الأقل';
                  }
                  return null;
                },
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // "نسيت كلمة السر؟" aligned closer to the left
                  Align(
                    alignment: Alignment.centerLeft,
                    child: TextButton(
                      style: TextButton.styleFrom(
                        padding: EdgeInsets
                            .zero, // Removes extra padding around the button
                        minimumSize: const Size(
                            0, 0), // Ensures minimal size for the button
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const ForgetPasswordScreen()),
                        );
                      },
                      child: Text(
                        'نسيت كلمة السر؟',
                        style: TextStyle(
                          fontSize: 14,
                          color: backgroundColor,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                  // "تذكرني" and checkbox
                  Row(
                    mainAxisSize: MainAxisSize.min, // Shrinks to fit content
                    crossAxisAlignment:
                        CrossAxisAlignment.center, // Aligns vertically
                    children: [
                      const Text(
                        "تذكرني",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Checkbox(
                          activeColor: backgroundColor,
                          value: _isChecked,
                          onChanged: (val) {
                            setState(() {
                              _isChecked = val!;
                            });
                          },
                          materialTapTargetSize: MaterialTapTargetSize
                              .shrinkWrap, // Shrinks checkbox
                          visualDensity: VisualDensity.compact),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 16),
              // Buttons as Column
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  buildSelectableButton('تسجيل الدخول', 0),
                  const SizedBox(height: 10),
                  buildSelectableButton('الدخول كزائر', 1),
                  const SizedBox(height: 10),
                  buildSelectableButton('إنشاء حساب', 2),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: [
                  //     IconButton(
                  //       icon: Image.asset('assets/images/google.png'),
                  //       onPressed: () {
                  //         // Handle Google login
                  //       },
                  //     ),
                  //     IconButton(
                  //       icon: Image.asset('assets/images/apple.png'),
                  //       onPressed: () {
                  //         // Handle Apple login
                  //       },
                  //     ),
                  //     IconButton(
                  //       icon: Image.asset(
                  //         'assets/images/Facebook.png',
                  //         height: 25,
                  //       ),
                  //       onPressed: () {
                  //         // Handle Facebook login
                  //       },
                  //     ),
                  //   ],
                  // ),
                ],
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildSelectableButton(String text, int index) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10), // Rounded corners
        border: Border.all(
          color: index == 0
              ? Colors.transparent // No border for the first button
              : (_selectedButtonIndex == index
                  ? Colors.transparent
                  : backgroundColor),
          width: 2,
        ),
        color: index == 0
            ? const Color(0xFF950000) // Always red for the first button
            : (_selectedButtonIndex == index
                ? const Color(0xFF950000)
                : Colors.white),
      ),
      child: ElevatedButton(
        onPressed: () async {
          setState(() {
            _selectedButtonIndex = index;
          });

          if (index == 0) {
            // Validate form before proceeding
            if (_formKey.currentState!.validate()) {
              final email = _emailController.text;
              final password = _passwordController.text;

              await _saveLoginInfo(); // Save login info

              // Call the login function from LoginProvider
              Provider.of<LoginProvider>(context, listen: false)
                  .login(email, password, context);
            }
          } else if (index == 1) {
            // Guest login action
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const HomePage()));
          } else if (index == 2) {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const SignUpScreen()));
          }
        },
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(
              vertical: 15), // Increased padding for height
          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(10), // Match container's border radius
          ),
          elevation: 0, // Remove shadow
          backgroundColor: Colors.transparent, // Transparent for better control
        ),
        child: Text(
          text,
          style: TextStyle(
            color: index == 0
                ? Colors.white // Always white text for the first button
                : (_selectedButtonIndex == index ? Colors.white : Colors.black),
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

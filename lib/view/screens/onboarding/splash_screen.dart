// ignore_for_file: use_build_context_synchronously

import 'package:binrushd_medical_center/controller/Auth/login_provider.dart';
import 'package:binrushd_medical_center/view/screens/tabs_screen.dart';
import 'package:flutter/material.dart';
import 'package:binrushd_medical_center/constants/constants.dart';
import 'package:binrushd_medical_center/view/screens/onboarding/first_onboarding.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  final bool isLoggedIn;
  const SplashScreen({super.key, required this.isLoggedIn});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    // ✅ تحميل التوكن داخل LoginProvider
    Future.delayed(Duration.zero, () {
      final loginProvider = Provider.of<LoginProvider>(context, listen: false);
      loginProvider.loadToken();
    });

    // Navigate to the next screen after 2 seconds
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => widget.isLoggedIn
              ? const TabsScreen() // ✅ لو مسجل دخول يروح Tabs
              : const OnboardingScreen(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(
            height: 140,
          ),
          Center(child: Image.asset('assets/images/logo.png')),
          const SizedBox(
            height: 20,
          ),
          Stack(
            alignment:
                Alignment.center, // Centers the second image on the first
            children: [
              Image.asset("assets/images/Group.png"),
              Image.asset("assets/images/Frame.png"),
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          Center(
            child: Text(
              "مرحبا بكم في تطبيقنا الطبي",
              style: TextStyle(
                  color: backgroundColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 15),
            ),
          ),
        ],
      ),
    );
  }
}

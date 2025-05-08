// ignore_for_file: use_build_context_synchronously

import 'package:binrushd_medical_center/controller/delete_account_provider.dart';
import 'package:binrushd_medical_center/view/screens/Auth/login_screen.dart';
import 'package:binrushd_medical_center/view/screens/about_us_screen.dart';
import 'package:binrushd_medical_center/view/screens/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:binrushd_medical_center/constants/constants.dart';
import 'package:binrushd_medical_center/controller/Auth/login_provider.dart';
import 'package:binrushd_medical_center/controller/Auth/logout_provider.dart';
import 'package:binrushd_medical_center/controller/profile_provider.dart';
import 'package:binrushd_medical_center/view/screens/appointments/my_appointments_screen.dart';
import 'package:binrushd_medical_center/view/screens/contact_us_screen.dart';
import 'package:binrushd_medical_center/view/screens/my_favourites_screen.dart';
import 'package:binrushd_medical_center/view/screens/profile/my_profile_screen.dart';
import 'package:provider/provider.dart';

class ProfileScreens extends StatefulWidget {
  const ProfileScreens({super.key});

  @override
  State<ProfileScreens> createState() => _ProfileScreensState();
}

class _ProfileScreensState extends State<ProfileScreens> {
  @override
  void initState() {
    super.initState();
    final profileProvider =
        Provider.of<ProfileProvider>(context, listen: false);
    final logprov = Provider.of<LoginProvider>(context, listen: false);
    final token = logprov.token;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (profileProvider.authUserResponse == null && token != null) {
        profileProvider.fetchProfile(
          token: token,
          context: context,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final profileProvider = Provider.of<ProfileProvider>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 40), // Top padding
            profileProvider.authUserResponse == null
                ? const SizedBox() // Show loading indicator
                : Text(
                    ' ${profileProvider.authUserResponse!.data.fname} ${profileProvider.authUserResponse!.data.lname}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
            const SizedBox(height: 20),
            buildProfileMenuItem(
              icon: Icons.person,
              text: 'البيانات الشخصية',
              color: backgroundColor,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const MyProfileScreen()),
                );
              },
            ),
            buildProfileMenuItem(
              icon: Icons.phone,
              text: 'تواصل معنا',
              color: backgroundColor,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ContactUsScreen()),
                );
              },
            ),
            buildProfileMenuItem(
              icon: Icons.calendar_today,
              text: 'الحجوزات',
              color: backgroundColor,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const MyAppointmentsScreen()),
                );
              },
            ),
            buildProfileMenuItem(
              icon: Icons.favorite,
              text: 'المفضلة',
              color: backgroundColor,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const MyFavouritesScreen()),
                );
              },
            ),
            buildProfileMenuItem(
              icon: Icons.settings,
              text: ' الاعدادات و الخصوصية',
              color: backgroundColor,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const SettingsScreen()),
                );
              },
            ),
            buildProfileMenuItem(
              icon: Icons.question_answer,
              text: ' من نحن',
              color: backgroundColor,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const AboutUsScreen()),
                );
              },
            ),
            const SizedBox(height: 20),
            buildLogoutButton(context),
          ],
        ),
      ),
    );
  }

  Widget buildProfileMenuItem({
    required IconData icon,
    required String text,
    required Color color,
    required VoidCallback onTap,
  }) {
    return ListTile(
      onTap: onTap,
      leading: Icon(Icons.arrow_back_ios, color: color),
      contentPadding: const EdgeInsets.symmetric(
          horizontal: 12), // Reduce horizontal padding
      title: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            text,
            style: const TextStyle(
              fontSize: 14, // Adjust font size as needed
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
            textAlign: TextAlign.right,
          ),
          CircleAvatar(
            backgroundColor: Colors.white,
            radius: 15, // Adjust size as needed
            child: Icon(icon, color: color, size: 18), // Adjust icon size
          ),
        ],
      ),
    );
  }

  Widget buildLogoutButton(BuildContext context) {
    final loginProvider = Provider.of<LoginProvider>(context, listen: false);
    final token = loginProvider.token;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 9.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end, // Adjusts alignment
        children: [
          token != null
              ? Text(
                  'تسجيل الخروج',
                  style: TextStyle(
                    color: backgroundColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                )
              : Text(
                  "تسجيل الدخول او انشاء حساب",
                  style: TextStyle(
                    color: backgroundColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
          InkWell(
            onTap: () {
              token != null
                  ? showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text(
                            'تسجيل الخروج',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 18),
                          ),
                          content: const Text(
                            'هل انت متأكد انك تريد تسجيل الخروج من حسابك؟',
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize: 14,
                                fontWeight: FontWeight.w400),
                            textAlign: TextAlign.center,
                          ),
                          actions: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Flexible(
                                  child: OutlinedButton(
                                    onPressed: () {
                                      Provider.of<LogoutProvider>(context,
                                              listen: false)
                                          .logOut(
                                        token: loginProvider.token!,
                                        context: context,
                                      );
                                      Navigator.of(context)
                                          .pop(); // Close the dialog
                                    },
                                    style: OutlinedButton.styleFrom(
                                      backgroundColor: backgroundColor,
                                      side:
                                          const BorderSide(color: Colors.grey),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16,
                                          vertical: 9), // Adjust padding
                                    ),
                                    child: const Text(
                                      'نعم، الخروج',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white,
                                        fontSize: 16,
                                      ),
                                      maxLines: 1, // Ensure single-line text
                                      overflow: TextOverflow
                                          .ellipsis, // Prevent text overflow
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Flexible(
                                  child: OutlinedButton(
                                    onPressed: () {
                                      Navigator.of(context)
                                          .pop(); // Close the dialog
                                    },
                                    style: OutlinedButton.styleFrom(
                                      side:
                                          const BorderSide(color: Colors.grey),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                    child: const Text(
                                      'لا، الغاء',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black,
                                          fontSize: 16),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        );
                      },
                    )
                  : Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginScreen()));
            },
            child: CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(Icons.logout, color: backgroundColor),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildLdeleteAccountButton(BuildContext context) {
    final loginProvider = Provider.of<LoginProvider>(context, listen: false);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 9.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end, // Adjusts alignment
        children: [
          Text(
            'حذف الحساب',
            style: TextStyle(
              color: backgroundColor,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
          InkWell(
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text(
                      ' حذف الحساب',
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                    ),
                    content: const Text(
                      'هل انت متأكد انك تريد حذف الحساب',
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                          fontWeight: FontWeight.w400),
                      textAlign: TextAlign.center,
                    ),
                    actions: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Flexible(
                            child: OutlinedButton(
                              onPressed: () async {
                                Provider.of<DeleteAccountProvider>(context,
                                        listen: false)
                                    .deleteAccount(
                                        loginProvider.token!, context);
                                Future.delayed(
                                  const Duration(seconds: 2),
                                  () {
                                    setState(() {}); // Trigger UI refresh
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const LoginScreen())); //
                                  },
                                );
                              },
                              style: OutlinedButton.styleFrom(
                                backgroundColor: backgroundColor,
                                side: const BorderSide(color: Colors.grey),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: const Text(
                                ' حذف',
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                    fontSize: 16),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Flexible(
                            child: OutlinedButton(
                              onPressed: () {
                                Navigator.of(context).pop(); // Close the dialog
                              },
                              style: OutlinedButton.styleFrom(
                                side: const BorderSide(color: Colors.grey),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: const Text(
                                'لا، الغاء',
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black,
                                    fontSize: 16),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                },
              );
            },
            child: CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(Icons.delete, color: backgroundColor),
            ),
          ),
        ],
      ),
    );
  }
}

// ignore_for_file: use_build_context_synchronously

import 'package:binrushd_medical_center/controller/delete_account_provider.dart';
import 'package:binrushd_medical_center/view/screens/Auth/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:binrushd_medical_center/constants/constants.dart';
import 'package:binrushd_medical_center/controller/Auth/login_provider.dart';
import 'package:binrushd_medical_center/controller/profile_provider.dart';
import 'package:binrushd_medical_center/view/screens/privacy_policy_screen.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final profileProvider = Provider.of<ProfileProvider>(context);
    final logprov = Provider.of<LoginProvider>(context, listen: false);
    final token = logprov.token;

    // Call the API to fetch profile data when the screen is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (profileProvider.authUserResponse == null) {
        profileProvider.fetchProfile(
          token: token!, // Replace with the actual token
          context: context,
        );
      }
    });

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 40), // Top padding
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                profileProvider.authUserResponse == null
                    ? const CircularProgressIndicator() // Show loading indicator
                    : Text(
                        ' ${profileProvider.authUserResponse!.data.fname} ${profileProvider.authUserResponse!.data.lname}',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                const SizedBox(width: 100),
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: InkWell(
                    child: const Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                )
              ],
            ),
            const SizedBox(height: 20),
            buildProfileMenuItem(
              icon: Icons.privacy_tip,
              text: ' سياسة الخصوصية',
              color: backgroundColor,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const PrivacyPolicyScreen()),
                );
              },
            ),
            const SizedBox(height: 10),
            buildLdeleteAccountButton(
              context,
            ),
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

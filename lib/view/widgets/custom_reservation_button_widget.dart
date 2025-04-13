import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomElevatedButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final String? token;

  const CustomElevatedButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.token,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF8C0000), // Red Color
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.r),
        ),
        padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 18.w),
      ),
      onPressed: () {
        if (token == null || token!.isEmpty) {
          showDialog(
            context: context,
            builder: (context) => const AlertDialog(
              title: Text('تنبيه'),
              content: Text('يجب التسجيل بحساب لكي تحجز موعد'),
            ),
          );
        } else {
          onPressed();
        }
      },
      child: Text(
        text,
        style: TextStyle(
          fontSize: 12.sp,
          color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

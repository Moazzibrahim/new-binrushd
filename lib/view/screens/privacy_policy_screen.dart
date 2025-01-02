import 'package:flutter/material.dart';
import 'package:binrushd_medical_center/constants/constants.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text(
            'سياسة الخصوصية',
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.w700, fontSize: 18),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0,
          actions: [
            IconButton(
              icon: const Icon(Icons.arrow_forward_ios, color: Colors.black),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ]),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'المعلومات المقدمة عنك',
                style: TextStyle(
                  color: backgroundColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'يمكننا استخدام خدماتنا بطرق شق خصوصيتك، على سبيل المثال، يمكنك الاشتراك في حساب Google إذا أردت إنشاء محتوى وإدارته، مثل الرسائل الإلكترونية والصور، أو إذا أردت عرض مزيد من المحتوى ذات الصلة.',
                textAlign: TextAlign.justify,
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'حقوق الملكية والقوانين',
                style: TextStyle(
                  color: backgroundColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'يمكنك استخدام خدماتنا بطرق شتى لإدارة خصوصيتك. على سبيل المثال، يمكنك الاشتراك في حساب Google إذا أردت إنشاء محتوى وإدارته، مثل الرسائل الإلكترونية والصور، أو إذا أردت عرض مزيد من نتائج البحث ذات الصلة . يمكنك استخدام خدماتنا بطرق شتى لإدارة خصوصيتك. على سبيل المثال، يمكنك الاشتراك في حساب Google إذا أردت إنشاء محتوى وإدارته، مثل الرسائل الإلكترونية والصور، أو إذا أردت عرض مزيد من نتائج البحث ذات الصلة .يمكنك استخدام خدماتنا بطرق شتى لإدارة خصوصيتك. على سبيل المثال، يمكنك الاشتراك في حساب Google إذا أردت إنشاء محتوى وإدارته، مثل الرسائل الإلكترونية والصور، أو إذا أردت عرض مزيد.',
                textAlign: TextAlign.justify,
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:binrushd_medical_center/constants/constants.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text(
            'الإشعارات',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          actions: [
            IconButton(
              icon: const Icon(Icons.arrow_forward_ios),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ]),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              // Today Section
              const NotificationSection(
                sectionTitle: 'اليوم',
                notifications: [
                  NotificationItem(
                    title: 'تعيين كمقروء',
                    message: 'استمتع معنا بكشوفات مجانية في اليوم الوطني!',
                    details: '25% خصومات على كل قوائم الكشوفات',
                    timeAgo: 'منذ 3 د',
                  ),
                ],
              ),
              const SizedBox(height: 16),
              // Yesterday Section
              NotificationSection(
                sectionTitle: 'أمس',
                notifications: List.generate(
                  5,
                  (index) => const NotificationItem(
                    title: 'تعيين كمقروء',
                    message: 'استمتع معنا بكشوفات مجانية في اليوم الوطني!',
                    details: '25% خصومات على كل قوائم الكشوفات',
                    timeAgo: 'منذ 3 د',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class NotificationSection extends StatelessWidget {
  final String sectionTitle;
  final List<NotificationItem> notifications;

  const NotificationSection({
    super.key,
    required this.sectionTitle,
    required this.notifications,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          sectionTitle,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 8),
        ...notifications.map((item) => item),
      ],
    );
  }
}

class NotificationItem extends StatelessWidget {
  final String title;
  final String message;
  final String details;
  final String timeAgo;

  const NotificationItem({
    super.key,
    required this.title,
    required this.message,
    required this.details,
    required this.timeAgo,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: ListTile(
          contentPadding: const EdgeInsets.all(16),
          leading: Icon(
            Icons.card_giftcard,
            color: backgroundColor,
            size: 30,
          ),
          title: Text(
            message,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
              color: Colors.black,
            ),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                details,
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                timeAgo,
                style: const TextStyle(
                  fontSize: 10,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
          trailing: Text(
            title,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: backgroundColor,
            ),
          ),
        ),
      ),
    );
  }
}

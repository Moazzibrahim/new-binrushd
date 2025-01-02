import 'package:binrushd_medical_center/constants/constants.dart';
import 'package:binrushd_medical_center/controller/about_us_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  List<Widget> _buildParagraphs(String text) {
    // Use a regular expression to split the text, retaining the full stop at the end of each sentence
    RegExp regex = RegExp(r'[^.]*\..*?');
    List<String> paragraphs = regex
        .allMatches(text)
        .map((match) => match.group(0)!)
        .where((p) => p.trim().isNotEmpty)
        .toList();

    return paragraphs
        .map(
          (paragraph) => Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: 16.0), // Consistent padding for all texts
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  paragraph.trim(),
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.start, // Align text to the right in RTL
                ),
                const SizedBox(height: 8), // Space between paragraphs
              ],
            ),
          ),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final aboutUsProvider =
        Provider.of<AboutUsProvider>(context, listen: false);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'من نحن',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.arrow_forward_ios, color: Colors.black),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
      body: FutureBuilder(
        future: aboutUsProvider.fetchAboutUsData(context),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }

          // If data is fetched successfully
          final aboutUsData = aboutUsProvider.aboutUsModel?.data;
          if (aboutUsData == null) {
            return const Center(child: Text('No data available.'));
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Display Image
                Center(
                  child: aboutUsData.image.isNotEmpty
                      ? Image.asset(
                          'assets/images/who.png',
                          height: 200,
                          width: 200,
                          fit: BoxFit.cover,
                        )
                      : const SizedBox.shrink(),
                ),
                const SizedBox(height: 20),

                // Description
                Directionality(
                  textDirection: TextDirection.rtl,
                  child: Column(
                    children: _buildParagraphs(aboutUsData.description),
                  ),
                ),
                const SizedBox(height: 20),

                // Email
                Directionality(
                  textDirection: TextDirection.rtl,
                  child: Row(
                    children: [
                      Icon(Icons.email, color: backgroundColor),
                      const SizedBox(width: 10),
                      Text(
                        aboutUsData.email,
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                // Phone Number
                Directionality(
                  textDirection: TextDirection.rtl,
                  child: Row(
                    children: [
                      Icon(Icons.phone, color: backgroundColor),
                      const SizedBox(width: 10),
                      Text(
                        aboutUsData.phoneNumber,
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                // Address
                Directionality(
                  textDirection: TextDirection.rtl,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.location_on, color: backgroundColor),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          aboutUsData.address,
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

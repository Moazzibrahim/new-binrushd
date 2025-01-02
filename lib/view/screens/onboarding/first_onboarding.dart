import 'package:flutter/material.dart';
import 'package:binrushd_medical_center/constants/constants.dart';
import 'package:binrushd_medical_center/view/screens/Auth/login_screen.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final PageController pageController = PageController();

    return Scaffold(
      backgroundColor: Colors.white,
      body: PageView(
        controller: pageController,
        children: [
          // First Onboarding Screen
          OnboardingContent(
            image: 'assets/images/first.png',
            title: 'ابحث عن طبيبك',
            subtitle: 'ابحث عن طبيبك الذي يقدم لك الرعاية الكاملة',
            activeIndex: 0,
            pageController: pageController,
          ),
          // Second Onboarding Screen
          OnboardingContent(
            image: 'assets/images/second.png',
            title: 'الكثير من التخصصات',
            subtitle: 'ابحث عن طبيبك الذي يقدم لك الرعاية الكاملة',
            activeIndex: 1,
            pageController: pageController,
          ),
          // Third Onboarding Screen
          OnboardingContent(
            image: 'assets/images/third.png',
            title: 'ابدأ الآن',
            subtitle: 'استمتع بتجربة أفضل في البحث عن الأطباء',
            activeIndex: 2,
            pageController: pageController,
            isLast: true,
          ),
        ],
      ),
    );
  }
}

class OnboardingContent extends StatelessWidget {
  final String image;
  final String title;
  final String subtitle;
  final int activeIndex;
  final PageController pageController;
  final bool isLast;

  const OnboardingContent({
    required this.image,
    required this.title,
    required this.subtitle,
    required this.activeIndex,
    required this.pageController,
    this.isLast = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Image.asset(image),
            ),
            const SizedBox(height: 50),
            Stack(
              alignment: Alignment.topCenter,
              children: [
                // Main Card
                Container(
                  margin: const EdgeInsets.only(top: 30),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
                  decoration: BoxDecoration(
                    color: backgroundColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(height: 40),
                      // Title
                      Text(
                        title,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 10),
                      // Subtitle
                      Text(
                        subtitle,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(height: 40),
                      // Pagination Dots
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          3,
                          (index) => Container(
                            margin: const EdgeInsets.symmetric(horizontal: 4),
                            width: index == activeIndex ? 20 : 8,
                            height: 5,
                            decoration: BoxDecoration(
                              color: index == activeIndex
                                  ? Colors.white
                                  : Colors.white38,
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      // Skip Button
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LoginScreen(),
                            ),
                          );
                        },
                        child: const Text(
                          'تخطى',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Arrow Button
                CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.white,
                  child: IconButton(
                    onPressed: () {
                      if (isLast) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginScreen(),
                          ),
                        );
                      } else {
                        pageController.nextPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      }
                    },
                    icon: const Icon(
                      Icons.arrow_forward,
                      color: Color(0xFF950000),
                      size: 30,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

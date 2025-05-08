// ignore_for_file: use_build_context_synchronously, unnecessary_null_comparison, library_private_types_in_public_api, deprecated_member_use
import 'package:binrushd_medical_center/controller/Auth/login_provider.dart';
import 'package:binrushd_medical_center/controller/profile_provider.dart';
import 'package:binrushd_medical_center/view/screens/branches/branch_details_screen.dart';
import 'package:binrushd_medical_center/view/screens/doctors/doctor_details_screen.dart';
import 'package:binrushd_medical_center/view/screens/specializies/specializies_details_screen.dart';
import 'package:binrushd_medical_center/view/widgets/filter_button_widget.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:binrushd_medical_center/constants/constants.dart';
import 'package:binrushd_medical_center/controller/branches/fetch_branches_provider.dart';
import 'package:binrushd_medical_center/controller/doctors/fetch_doctors_data_provider.dart';
import 'package:binrushd_medical_center/controller/fetch_departments_provider.dart';
import 'package:binrushd_medical_center/controller/fetch_offers_provider.dart';
import 'package:binrushd_medical_center/controller/fetch_posts_provider.dart';
import 'package:binrushd_medical_center/view/screens/all_Specialties_screen.dart';
import 'package:binrushd_medical_center/view/screens/all_articles_screen.dart';
import 'package:binrushd_medical_center/view/screens/appointments/make_appointments_screen.dart';
import 'package:binrushd_medical_center/view/screens/branches/all_branches_screen.dart';
import 'package:binrushd_medical_center/view/screens/doctors_list_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isDoctorsSelected = true;
  int selectionindex = 0;
  int _currentIndex = 0;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();

    // Run after the first build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initializeData();
    });
  }

  void _initializeData() {
    final contextRead = context;

    // Fetch static data
    Provider.of<FetchDoctorsDataProvider>(contextRead, listen: false)
        .fetchDoctorsData(contextRead);
    Provider.of<FetchBranchesProvider>(contextRead, listen: false)
        .fetchBranches(contextRead);
    Provider.of<FetchDepartmentsProvider>(contextRead, listen: false)
        .fetchDepartments(contextRead);
    Provider.of<FetchPostsProvider>(contextRead, listen: false)
        .fetchPosts(contextRead);
    Provider.of<FetchOffersProvider>(contextRead, listen: false)
        .fetchOffers(contextRead);

    // Fetch profile if token exists
    final loginProvider =
        Provider.of<LoginProvider>(contextRead, listen: false);
    final profileProvider =
        Provider.of<ProfileProvider>(contextRead, listen: false);

    final token = loginProvider.token;
    if (!_isInitialized && token != null && token.isNotEmpty) {
      _isInitialized = true;
      profileProvider.fetchProfile(token: token, context: contextRead);
    }
  }

  @override
  Widget build(BuildContext context) {
    final contextRead = context;
    final profileProvider =
        Provider.of<ProfileProvider>(contextRead, listen: false);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        toolbarHeight: 70.h,
        elevation: 0,
        titleSpacing: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Button on the left
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 14.w),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF8C0000), // Red Color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  padding:
                      EdgeInsets.symmetric(vertical: 5.h, horizontal: 18.w),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MakeAppointmentScreen(),
                    ),
                  );
                },
                child: Text(
                  'حجز موعد',
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            const Spacer(), // Push content to the end
            // User greeting on the right
            profileProvider.authUserResponse == null
                ? Padding(
                    padding: EdgeInsets.only(right: 10.w),
                    child: Text(
                      'مرحبًا!',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                      ),
                    ),
                  )
                : Padding(
                    padding: EdgeInsets.only(right: 10.w),
                    child: Text(
                      ' ${profileProvider.authUserResponse!.data.fname}  مرحبًا',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                      ),
                    ),
                  ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(right: 16, left: 16, bottom: 16, top: 5),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image Banner
              Consumer<FetchOffersProvider>(
                builder: (context, provider, child) {
                  if (provider.offersResponse == null) {
                    provider.fetchOffers(context);
                    return const Center(child: CircularProgressIndicator());
                  }

                  final posts = provider.offersResponse!.data;
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CarouselSlider(
                        options: CarouselOptions(
                          height: 170.0,
                          enlargeCenterPage:
                              false, // Disable enlarging the center page
                          autoPlay: true,
                          viewportFraction:
                              1.0, // Each image takes the full width
                          autoPlayInterval: const Duration(seconds: 3),
                          autoPlayAnimationDuration:
                              const Duration(milliseconds: 800),
                          autoPlayCurve: Curves.fastOutSlowIn,
                          pauseAutoPlayOnTouch: true,
                          scrollDirection: Axis.horizontal,
                          onPageChanged: (index, reason) {
                            setState(() {
                              _currentIndex = index;
                            });
                          },
                        ),
                        items: posts
                            .map(
                              (item) => Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  image: DecorationImage(
                                    image: NetworkImage(item.image!),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: posts.asMap().entries.map((entry) {
                          return GestureDetector(
                            onTap: () => setState(() {
                              _currentIndex = entry.key;
                            }),
                            child: Container(
                              width: 8.0,
                              height: 8.0,
                              margin: const EdgeInsets.symmetric(
                                  vertical: 8.0, horizontal: 4.0),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: (Theme.of(context).brightness ==
                                            Brightness.dark
                                        ? Colors.white
                                        : backgroundColor)
                                    .withOpacity(
                                        _currentIndex == entry.key ? 0.9 : 0.4),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  );
                },
              ),

              const SizedBox(
                height: 10,
              ),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const SpecialistsScreen()));
                        },
                        child: Text(
                          "استعراض الكل",
                          style: TextStyle(
                              color: backgroundColor,
                              fontSize: 10,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      const Text(
                        "التخصصات",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 18),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Consumer<FetchDepartmentsProvider>(
                    builder: (context, fetchDepartmentsProvider, child) {
                      final departmentResponse =
                          fetchDepartmentsProvider.departmentResponse;
                      if (departmentResponse == null) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      final departments = departmentResponse.data;

                      return SizedBox(
                        height: 80,
                        child: ListView.builder(
                          reverse: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: departments.length,
                          itemBuilder: (context, index) {
                            final department = departments[index];

                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Column(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                          10), // Adjust the value for the desired roundness
                                    ),
                                    height: 50,
                                    width: 70,
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    SpecializiesDetailsScreen(
                                                      depid: department.id,
                                                      depimage:
                                                          department.image,
                                                    )));
                                      },
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(
                                            10), // Match the container's border radius
                                        child: Image.network(
                                          department.image,
                                          fit: BoxFit
                                              .cover, // Ensure the image fits well within the container
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    department.name,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 12),
                                  ), // Use index to get the text
                                ],
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      textDirection: TextDirection.rtl,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        FilterButton(
                          image: "assets/images/plane.png",
                          label: 'الأطباء',
                          backgroundColor: Colors.grey[200],
                          isSelected:
                              isDoctorsSelected, // Use current selection state
                          onTap: () {
                            setState(() {
                              isDoctorsSelected = true;
                              selectionindex = 0;
                            });
                          },
                        ),
                        const SizedBox(width: 5),
                        FilterButton(
                          image: "assets/images/building.png",
                          label: 'الفروع',
                          backgroundColor: Colors.grey[200],
                          isSelected: !isDoctorsSelected, // Invert the state
                          onTap: () {
                            setState(() {
                              isDoctorsSelected = false;
                              selectionindex = 1;
                            });
                          },
                        ),
                        const SizedBox(width: 60),
                        AnimatedSwitcher(
                          duration: const Duration(milliseconds: 300),
                          transitionBuilder:
                              (Widget child, Animation<double> animation) {
                            return ScaleTransition(
                                scale: animation, child: child);
                          },
                          child: isDoctorsSelected
                              ? InkWell(
                                  key:
                                      const ValueKey<String>('استعراض الأطباء'),
                                  onTap: () {
                                    // Navigate to Doctors List Screen
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const DoctorsListScreen(),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: backgroundColor,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: const Text(
                                      "استعراض الأطباء",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                )
                              : InkWell(
                                  key: const ValueKey<String>('استعراض الفروع'),
                                  onTap: () {
                                    // Navigate to All Branches Screen
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const AllBranchesScreen(),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: backgroundColor,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: const Text(
                                      "استعراض الفروع",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  selectionindex == 0
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment
                              .end, // Align content to the right
                          children: [
                            RichText(
                              textAlign:
                                  TextAlign.right, // Align text to the right
                              textDirection: TextDirection
                                  .rtl, // Set text direction to right-to-left
                              text: const TextSpan(
                                children: [
                                  TextSpan(
                                    text:
                                        'نقدم لكم في مركز بن رشد نخبة من\n الأطباء المتخصصين. ',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )
                      // or any other widget you need for other cases
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            RichText(
                              textAlign: TextAlign.right,
                              text: const TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'اختر الفرع الاقرب لك ',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              selectionindex == 0
                  ? SizedBox(
                      height: 265,
                      child: Consumer<FetchDoctorsDataProvider>(
                        builder: (context, doctorsProvider, child) {
                          // Check if the data is still being fetched
                          if (doctorsProvider.doctorsResponse == null) {
                            return const Center(
                              child:
                                  CircularProgressIndicator(), // Show loading spinner
                            );
                          }

                          // Get the list of doctors
                          final doctors = doctorsProvider.doctorsResponse!.data;
                          if (doctors.isEmpty) {
                            return const Center(
                              child: Text('No doctors available'),
                            );
                          }

                          return ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: doctors.length,
                            itemBuilder: (context, index) {
                              final doctor = doctors[index];

                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0),
                                child: Card(
                                  elevation: 5,
                                  color: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: SizedBox(
                                    width:
                                        180, // Adjust width to match the design
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        // Display doctor image, fallback to placeholder if null
                                        doctor.image != null
                                            ? InkWell(
                                                onTap: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          DoctorDetailsScreen(
                                                        docid: doctor.id,
                                                      ),
                                                    ),
                                                  );
                                                },
                                                child: CircleAvatar(
                                                  backgroundColor: Colors.white,
                                                  radius: 50,
                                                  backgroundImage: NetworkImage(
                                                      doctor.image),
                                                ),
                                              )
                                            : CircleAvatar(
                                                backgroundColor:
                                                    Colors.grey.shade200,
                                                radius: 50,
                                                child: const Icon(
                                                  Icons.person,
                                                  size: 50,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                        const SizedBox(height: 10),
                                        // Display doctor name
                                        Text(
                                          "دكتور/ ${doctor.fname} ${doctor.lname}",
                                          style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                        const SizedBox(height: 5),
                                        // Display doctor specialty
                                        Directionality(
                                          textDirection: TextDirection.rtl,
                                          child: Text(
                                            doctor.degree,
                                            style: const TextStyle(
                                              fontSize: 10,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.grey,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: backgroundColor,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 20,
                                              vertical: 8,
                                            ),
                                          ),
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    MakeAppointmentScreen(
                                                  docid: doctor.id,
                                                ),
                                              ),
                                            );
                                          },
                                          child: const Text(
                                            'حجز موعد',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    )
                  : SizedBox(
                      height: 280, // Adjusted height to fit the design
                      child: Consumer<FetchBranchesProvider>(
                        builder: (context, fetchBranchesProvider, child) {
                          if (fetchBranchesProvider.branchResponse == null) {
                            return const Center(
                              child:
                                  CircularProgressIndicator(), // Show loading spinner
                            );
                          }
                          final branches =
                              fetchBranchesProvider.branchResponse!.data;
                          if (branches.isEmpty) {
                            return const Center(
                              child: Text('No branches available'),
                            );
                          }
                          return ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: branches.length,
                            itemBuilder: (context, index) {
                              final branch = branches[index];
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Card(
                                  elevation: 5,
                                  color: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: SizedBox(
                                    width: 250, // Adjust width as needed
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    BranchDetailsScreen(
                                                  branchId: branch.id,
                                                  image: branch.image,
                                                ),
                                              ),
                                            );
                                          },
                                          child: ClipRRect(
                                            borderRadius:
                                                const BorderRadius.vertical(
                                              top: Radius.circular(15),
                                            ),
                                            child: Image.network(
                                              branch.image,
                                              height:
                                                  140, // Adjust height for the image
                                              width: double.infinity,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        Directionality(
                                          textDirection: TextDirection.rtl,
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8.0),
                                            child: Text(
                                              branch
                                                  .name, // Assuming you have a branch name
                                              style: const TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 5),
                                        Directionality(
                                          textDirection: TextDirection.rtl,
                                          child: Text.rich(
                                            TextSpan(
                                              children: branch.address
                                                      .contains(',')
                                                  ? [
                                                      TextSpan(
                                                        text: branch.address
                                                            .split(',')
                                                            .first
                                                            .trim(),
                                                      ),
                                                      const TextSpan(
                                                          text: '\n'),
                                                      TextSpan(
                                                        text: branch.address
                                                            .split(',')
                                                            .last
                                                            .trim(),
                                                      ),
                                                    ]
                                                  : [
                                                      TextSpan(
                                                          text: branch.address)
                                                    ],
                                            ),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                              fontSize: 11,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.grey,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                        const Spacer(),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(bottom: 10),
                                          child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: backgroundColor,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              minimumSize: const Size(100, 40),
                                            ),
                                            onPressed: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      const MakeAppointmentScreen(),
                                                ),
                                              );
                                            },
                                            child: const Text(
                                              'حجز موعد',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),

              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const AllArticlesScreen()));
                    },
                    child: Text(
                      "استعراض الكل",
                      style: TextStyle(
                        fontSize: 10,
                        color: backgroundColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const Text(
                    "مقالات صحية ",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                  ),
                ],
              ),
              Consumer<FetchPostsProvider>(
                builder: (context, fetchPostsProvider, child) {
                  final articles = fetchPostsProvider.postResponse?.data ?? [];

                  if (fetchPostsProvider.postResponse == null) {
                    // Show a loading spinner if the data is still being fetched
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (articles.isEmpty) {
                    // Show a message if there are no articles
                    return const Center(
                      child: Text(
                        'لا توجد مقالات حالياً.',
                        style: TextStyle(fontSize: 18),
                      ),
                    );
                  }

                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView.builder(
                      shrinkWrap:
                          true, // Prevents the ListView from taking infinite space
                      // Disables scrolling
                      itemCount: articles.length,
                      itemBuilder: (context, index) {
                        final article = articles[index];

                        return Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Article Content
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    article.title,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 1),
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const AllArticlesScreen()));
                                    },
                                    child: Text.rich(
                                      TextSpan(
                                        children: [
                                          TextSpan(
                                            text: article.content.length > 100
                                                ? article.content
                                                    .substring(0, 100)
                                                : article.content,
                                            style: const TextStyle(
                                              fontSize: 12,
                                              color: Colors.grey,
                                            ),
                                          ),
                                          TextSpan(
                                            text: '... المزيد',
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: backgroundColor,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                      textAlign: TextAlign.right,
                                      maxLines: 4,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            const SizedBox(width: 12),
                            // Article Image
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12.0),
                              child: Image.network(
                                article
                                    .image, // Use the real image URL from API
                                width: 80,
                                height: 80,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:binrushd_medical_center/controller/delete_account_provider.dart';
import 'package:flutter/material.dart';
import 'package:binrushd_medical_center/controller/Auth/check_forget_pass_provider.dart';
import 'package:binrushd_medical_center/controller/Auth/forget_password_provider.dart';
import 'package:binrushd_medical_center/controller/Auth/login_provider.dart';
import 'package:binrushd_medical_center/controller/Auth/logout_provider.dart';
import 'package:binrushd_medical_center/controller/Auth/reset_password_provider.dart';
import 'package:binrushd_medical_center/controller/Auth/send_otp_provider.dart';
import 'package:binrushd_medical_center/controller/Auth/sign_up_provider.dart';
import 'package:binrushd_medical_center/controller/about_us_provider.dart';
import 'package:binrushd_medical_center/controller/add_to_favourites_provider.dart';
import 'package:binrushd_medical_center/controller/branches/fetch_branches_provider.dart';
import 'package:binrushd_medical_center/controller/branches/fetch_individual_branch_provider.dart';
import 'package:binrushd_medical_center/controller/doctors/fetch_doctors_data_provider.dart';
import 'package:binrushd_medical_center/controller/doctors/fetch_individual_doctor_provider.dart';
import 'package:binrushd_medical_center/controller/fetch_departments_provider.dart';
import 'package:binrushd_medical_center/controller/fetch_offers_provider.dart';
import 'package:binrushd_medical_center/controller/fetch_posts_provider.dart';
import 'package:binrushd_medical_center/controller/make_report_provider.dart';
import 'package:binrushd_medical_center/controller/make_reservation_provider.dart';
import 'package:binrushd_medical_center/controller/profile_provider.dart';
import 'package:binrushd_medical_center/view/screens/onboarding/splash_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:binrushd_medical_center/model/branches_model.dart'; // Ensure this is the correct path to the file defining BranchResponseAdapter
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('token');

  await Hive.initFlutter();

  Hive.registerAdapter(BranchResponseAdapter());
  Hive.registerAdapter(BranchAdapter());
  Hive.registerAdapter(WorkTimesAdapter());
  await Hive.openBox<Branch>('branches');

  runApp(MyApp(isLoggedIn: token != null));
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;
  const MyApp({super.key, required this.isLoggedIn});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LoginProvider()),
        ChangeNotifierProvider(create: (_) => SignUpProvider()),
        ChangeNotifierProvider(create: (_) => SendOtpProvider()),
        ChangeNotifierProvider(create: (_) => FetchDoctorsDataProvider()),
        ChangeNotifierProvider(create: (_) => FetchBranchesProvider()),
        ChangeNotifierProvider(create: (_) => FetchDepartmentsProvider()),
        ChangeNotifierProvider(create: (_) => FetchPostsProvider()),
        ChangeNotifierProvider(create: (_) => FetchOffersProvider()),
        ChangeNotifierProvider(create: (_) => MakeReservationProvider()),
        ChangeNotifierProvider(create: (_) => LogoutProvider()),
        ChangeNotifierProvider(create: (_) => MakeReportProvider()),
        ChangeNotifierProvider(create: (_) => AddToFavouritesProvider()),
        ChangeNotifierProvider(create: (_) => FetchIndividualDoctorProvider()),
        ChangeNotifierProvider(create: (_) => FetchIndividualBranchProvider()),
        ChangeNotifierProvider(create: (_) => AboutUsProvider()),
        ChangeNotifierProvider(create: (_) => ProfileProvider()),
        ChangeNotifierProvider(create: (_) => ResetPasswordProvider()),
        ChangeNotifierProvider(create: (_) => ForgetPasswordProvider()),
        ChangeNotifierProvider(create: (_) => CheckForgetPassProvider()),
        ChangeNotifierProvider(create: (_) => MakeReportProvider()),
        ChangeNotifierProvider(create: (_) => DeleteAccountProvider()),
      ],
      child: ScreenUtilInit(
        designSize: const Size(375, 812), // Base design dimensions
        builder: (context, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Binrushd',
            theme: ThemeData(
              fontFamily: 'IBM Plex Sans Arabic', // Set your global font family
              // You can also customize other theme properties here if needed
            ),
            home: SplashScreen(
              isLoggedIn: isLoggedIn,
            ),
          );
        },
      ),
    );
  }
}

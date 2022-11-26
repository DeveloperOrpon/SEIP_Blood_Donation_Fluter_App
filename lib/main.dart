import 'package:blood_donation/pages/Login_page.dart';
import 'package:blood_donation/pages/LauncherPage.dart';
import 'package:blood_donation/pages/donar_history_page.dart';
import 'package:blood_donation/pages/registration_page.dart';
import 'package:blood_donation/pages/welcome_page.dart';
import 'package:blood_donation/provider/comment_provider.dart';
import 'package:blood_donation/provider/navigation_provider.dart';
import 'package:blood_donation/provider/user_provider.dart';
import 'package:blood_donation/widget/donor_profile_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:provider/provider.dart';
import 'pages/home_page.dart';

void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UserProvider()),
        ChangeNotifierProvider(create: (context) => NavigationProvider()),
        ChangeNotifierProvider(create: (context) => CommentProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    FlutterNativeSplash.remove();
    return MaterialApp(
      builder: EasyLoading.init(),
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      initialRoute: OnboardingPage.routeName,
      routes: {
        HomePage.routeName: (context) => const HomePage(),
        OnboardingPage.routeName: (context) => const OnboardingPage(),
        LoginPage.routeName: (context) => const LoginPage(),
        LauncherPage.routeName: (context) => const LauncherPage(),
        RegistrationPage.routeName: (context) => const RegistrationPage(),
        DonorHistoryPage.routePage:(context) => const DonorHistoryPage(),
        DonorProfilePreViewPage.routeName:(context) => const DonorProfilePreViewPage()
      },
    );
  }
}

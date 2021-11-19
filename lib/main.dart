import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_babycare/module/sample/view/sample_view.dart';
import 'package:flutter_babycare/utils/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'module/home/view/home_view.dart';
import 'module/login/view/login_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  HttpOverrides.global = MyHttpOverrides();

  // vertical only
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp();
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: Size(414, 736),
        builder: () => MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Baby Care',
              theme: ThemeData(
                brightness: Brightness.light,
                primaryColor: AppColors.primary,
                textTheme: GoogleFonts.dosisTextTheme(
                  TextTheme(
                    caption: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 24.sp,
                      color: AppColors.text,
                    ),
                    headline1: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 22.sp,
                      color: AppColors.text,
                    ),
                    headline2: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 18.sp,
                      color: AppColors.text,
                    ),
                    bodyText1: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 16.sp,
                      color: AppColors.text,
                    ),
                    bodyText2: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 14.sp,
                      color: AppColors.text,
                    ),
                    button: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 22.sp,
                      color: AppColors.whiteBackground,
                    ),
                  ),
                ),
              ),

              builder: (context, widget) {
                return MediaQuery(
                  data: MediaQuery.of(context).copyWith(textScaleFactor: 1),
                  child: widget,
                );
              },
              initialRoute: '/',

              //routes as shortcuts for Navigator
              routes: {
                '/': (BuildContext context) => LoginView(),
                '/home': (BuildContext context) => HomeView(),
              },
            ));
  }
}

//Accept HTTPS://Host:Port without a trusted certificate
class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

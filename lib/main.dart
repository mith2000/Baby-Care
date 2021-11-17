import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_babycare/module/sample/view/sample_view.dart';
import 'package:flutter_babycare/utils/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
        designSize: Size(375, 812),
        builder: () => MaterialApp(
              supportedLocales: [
                const Locale.fromSubtags(languageCode: 'vi'),
                const Locale.fromSubtags(languageCode: 'en'),
              ],
              locale: const Locale('vi', 'VN'),
              debugShowCheckedModeBanner: false,
              title: 'Baby Care',
              theme: ThemeData(
                  brightness: Brightness.light,
                  dialogTheme: DialogTheme(
                      titleTextStyle: TextStyle(color: AppColors.appBlue)),
                  appBarTheme: Theme.of(context).appBarTheme.copyWith(
                      brightness: Brightness.light,
                      actionsIconTheme: IconThemeData(color: Colors.white),
                      iconTheme: IconThemeData(color: Colors.white)),
                  primarySwatch: Colors.blue,
                  primaryColor: Colors.white),

              builder: (context, widget) {
                return MediaQuery(
                  data: MediaQuery.of(context).copyWith(textScaleFactor: 1),
                  child: widget,
                );
              },
              initialRoute: '/',

              //routes as shortcuts for Navigator
              routes: {
                '/': (BuildContext context) => SampleView(),
                '/home': (BuildContext context) => SampleView(),
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

import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_babycare/module/baby/create/view/create_view.dart';
import 'package:flutter_babycare/utils/UI_components/loading_widget.dart';
import 'package:flutter_babycare/utils/app_colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'data/source/baby_repository.dart';
import 'data/source/user_repository.dart';
import 'module/authentication/authentication_bloc/authentication_bloc.dart';
import 'module/authentication/authentication_bloc/authentication_event.dart';
import 'module/authentication/authentication_bloc/authentication_state.dart';
import 'module/authentication/simple_bloc_observer.dart';
import 'module/home/bloc/baby_bloc.dart';
import 'module/home/view/home_view.dart';
import 'module/login/bloc/login_bloc.dart';
import 'module/login/view/login_view.dart';
import 'module/register/bloc/register_bloc.dart';
import 'module/register/view/register_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  HttpOverrides.global = MyHttpOverrides();

  // vertical only
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await Firebase.initializeApp();
  Bloc.observer = SimpleBlocObserver();
  final UserRepository userRepository = UserRepository();
  runApp(
    BlocProvider(
      create: (context) => AuthenticationBloc(
        userRepository: userRepository,
      )..add(AuthenticationStarted()),
      child: MyApp(
        userRepository: userRepository,
      ),
    ),
  );
}

class MyApp extends StatefulWidget {
  final UserRepository _userRepository;

  MyApp({UserRepository userRepository}) : _userRepository = userRepository;

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  BabyRepository babyRepository;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => RegisterBloc(
            userRepository: widget._userRepository,
          ),
        ),
        BlocProvider(
          create: (_) => LoginBloc(
            userRepository: widget._userRepository,
          ),
        ),
        BlocProvider(
          create: (_) => BabyBloc(
            babyRepository: BabyRepository()
          ),
        ),
      ],
      child: ScreenUtilInit(
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
                  '/': (BuildContext context) =>
                      BlocBuilder<AuthenticationBloc, AuthenticationState>(
                        builder: (context, state) {
                          if (state is AuthenticationFailure) {
                            return LoginView();
                          }

                          if (state is AuthenticationSuccess) {
                            return HomeView(widget
                                ._userRepository.firebaseAuth.currentUser);
                          }

                          return Scaffold(body: CustomLoadingWidget());
                        },
                      ),
                  '/home': (BuildContext context) =>
                      HomeView(widget._userRepository.firebaseAuth.currentUser),
                  '/register': (BuildContext context) => RegisterView(),
                  '/create-baby': (BuildContext context) => CreateBabyView(),
                },
              )),
    );
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

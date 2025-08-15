import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'dart:math' as math;

import 'screens/login.dart';
import 'screens/home_page.dart';

void main() {
  runApp(const MyApp());
}

double kW = 1.0, kH = 1.0, s = 1.0;

void initScale(BuildContext context) {
  final mq = MediaQuery.of(context);
  final size = mq.size;
  kW = size.width / 390.0;
  kH = size.height / 844.0;
  s  = math.min(kW, kH);
}

extension SizerNum on num {
  double get w  => this * kW;    //width
  double get h  => this * kH;    //height
  double get sp => this * s;     //safe
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  bool _authorized = false;
  final _loginPageKey = GlobalKey<LoginPageState>();
  final _homePageKey = GlobalKey<HomePageState>();

  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      HomePage(key: _homePageKey, top: 844, logout: _logout,),
      LoginPage(key: _loginPageKey, authorize: authorize)
    ];

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_authorized) {
        animationAuthorize();
      }
    });
  }

  void _logout() {
    _homePageKey.currentState?.moveToY(-844);
    _loginPageKey.currentState?.moveToY(0);
    _homePageKey.currentState?.clear();
    setState(() {
      _authorized = false;
    });
  }

  void authorize (String email, String password) {
    FocusScope.of(context).unfocus();
    bool authorized = checkAuthorize(email, password);
    if (authorized) {
      animationAuthorize();
      setState(() {
        _authorized = true;
      });
      _loginPageKey.currentState?.clear();
    }
  }

  void animationAuthorize() {
    _homePageKey.currentState?.showStartPage();
    _homePageKey.currentState?.moveToY(0);
    _loginPageKey.currentState?.moveToY(-844);
  }

  bool checkAuthorize(String email, String password) {
    print(email);
    print(password);
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 390.w,
      height: 844.h,
      decoration: BoxDecoration(
        color: Colors.white
      ),
      child: MaterialApp(
        builder: (context, child) {
          initScale(context);
          return child!;
        },
        title: 'PKI_UL Frontend',
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('ru'),
          Locale('en'),
        ],
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(95, 255, 255, 255)),
          useMaterial3: true,
          appBarTheme: AppBarTheme(
            elevation: 0,
            scrolledUnderElevation: 0,
            surfaceTintColor: Colors.transparent,
            shadowColor: Colors.transparent,
            backgroundColor: Colors.white,
          ),
        ),
        home: Stack(children: _pages),
      )
    );
  }
}

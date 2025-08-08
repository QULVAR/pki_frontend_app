import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'screens/login.dart';
import 'screens/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  bool _authorized = true;
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
    _loginPageKey.currentState?.clear();
    _homePageKey.currentState?.moveToY(-844);
    _loginPageKey.currentState?.moveToY(0);
    setState(() {
      _authorized = false;
    });
  }

  void authorize (String email, String password) {
    bool authorized = checkAuthorize(email, password);
    if (authorized) {
      animationAuthorize();
      setState(() {
        _authorized = true;
      });
    }
  }

  void animationAuthorize() {
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
      width: 390,
      height: 844,
      decoration: BoxDecoration(
        color: Colors.white
      ),
      child: MaterialApp(
        title: 'PKI_UL Demo',
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
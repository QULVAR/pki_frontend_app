import 'package:flutter/material.dart';

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

  bool _authorized = false;

  final _loginPageKey = GlobalKey<LoginPageState>();
  final _homePageKey = GlobalKey<HomePageState>();

  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      HomePage(key: _homePageKey, top: 844),
      LoginPage(key: _loginPageKey, authorize: authorize)
    ];
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
    if (_authorized) {
      animationAuthorize();
    }
    return Container(
      width: 390,
      height: 844,
      decoration: BoxDecoration(
        color: Colors.white
      ),
      child: MaterialApp(
        title: 'PKI_UL Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(95, 255, 255, 255)),
        ),
        home: Stack(children: _pages),
      )
    );
  }
}
import 'package:flutter/material.dart';
import 'package:pki_frontend_app/main.dart';

import '../widgets/global/bottom_navigation_bar.dart';
import '../widgets/global/app_bar.dart';

import 'pages/add_program.dart';
import 'pages/statistics.dart';
import 'pages/program_control.dart';
import 'pages/menu.dart';


class HomePage extends StatefulWidget {
  final VoidCallback logout;
  final double top;
  const HomePage({
    super.key,
    required this.top,
    required this.logout
  });

  @override
  State<HomePage> createState() => HomePageState();
}


class HomePageState extends State<HomePage> {
  int _selected = 0;

  final _addProgramPageKey = GlobalKey<AddProgramPageState>();
  final _statisticsPageKey = GlobalKey<StatisticsPageState>();
  final _programControlPageKey = GlobalKey<ProgramControlPageState>();
  final _menuPageKey = GlobalKey<MenuPageState>();
  late final List<Widget> _pages;

  late double _top;
  int _teleportSeq = 0;

  @override
  void initState() {
    super.initState();
    _pages = [
      AddProgramPage(key: _addProgramPageKey),
      StatisticsPage(key: _statisticsPageKey),
      ProgramControlPage(key: _programControlPageKey),
      MenuPage(key: _menuPageKey, logout: widget.logout,)
    ];
    _top = widget.top;
  }

  void clear() {
    _addProgramPageKey.currentState?.resetForm();
    _statisticsPageKey.currentState?.clear();
    _programControlPageKey.currentState?.clear();
  }

  void showStartPage() {
    _onTap(0);
  }

  void moveToY(double top) {
    setState(() => _top = top);
  }

  Future<void> _onTap(int index) async {
    if (index == _selected) return;
    final previousIndex = _selected;
    setState(() {
      _selected = index;
    });
    final w = MediaQuery.of(context).size.width;
    const animDuration = Duration(milliseconds: 300);
    final mySeq = ++_teleportSeq;
    final forward = _selected > previousIndex;
    switch (previousIndex) {
      case 0:
        _addProgramPageKey.currentState?.moveToX(forward ? -w : w);
        break;
      case 1:
        _statisticsPageKey.currentState?.moveToX(forward ? -w : w);
        break;
      case 2:
        _programControlPageKey.currentState?.moveToX(forward ? -w : w);
        break;
      case 3:
        _menuPageKey.currentState?.moveToX(forward ? -w : w);
        break;
    }
    switch (_selected) {
      case 0:
        _addProgramPageKey.currentState?.moveToX(0);
        break;
      case 1:
        _statisticsPageKey.currentState?.moveToX(0);
        break;
      case 2:
        _programControlPageKey.currentState?.moveToX(0);
        break;
      case 3:
        _menuPageKey.currentState?.moveToX(0);
        break;
    }
    await Future.delayed(animDuration);
    if (!mounted || previousIndex != _selected || _teleportSeq != mySeq) {
      return;
    }

    switch (_selected) {
      case 0:
        _statisticsPageKey.currentState?.moveToXWithoutAnimation(w);
        _programControlPageKey.currentState?.moveToXWithoutAnimation(w);
        _menuPageKey.currentState?.moveToXWithoutAnimation(w);
        break;
      case 1:
        _addProgramPageKey.currentState?.moveToXWithoutAnimation(-w);
        _programControlPageKey.currentState?.moveToXWithoutAnimation(w);
        _menuPageKey.currentState?.moveToXWithoutAnimation(w);
        break;
      case 2:
        _addProgramPageKey.currentState?.moveToXWithoutAnimation(-w);
        _statisticsPageKey.currentState?.moveToXWithoutAnimation(-w);
        _menuPageKey.currentState?.moveToXWithoutAnimation(w);
        break;
      case 3:
        _addProgramPageKey.currentState?.moveToXWithoutAnimation(-w);
        _statisticsPageKey.currentState?.moveToXWithoutAnimation(-w);
        _programControlPageKey.currentState?.moveToXWithoutAnimation(-w);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AnimatedPositioned(
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOutQuint,
          top: _top.h,
          left: 0,
          child: SizedBox(
            width: 390.w,
            height: 844.h,
            child: Scaffold(
              resizeToAvoidBottomInset: false,
              backgroundColor: Color(0xFFF5F5F5),
              appBar: getAppBar(_selected),
              body: GestureDetector(
                onTap: () => FocusScope.of(context).unfocus(),
                child: Stack(children: _pages),
              ),
              bottomNavigationBar: BottomNavigationBarCustom(
                currentIndex: _selected,
                onTap: _onTap,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
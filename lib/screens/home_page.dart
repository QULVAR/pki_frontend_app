import 'package:flutter/material.dart';

import '../widgets/bottom_navigation_bar.dart';
import '../widgets/app_bar.dart';

import 'pages/add_program.dart';
import 'pages/statistics.dart';
import 'pages/program_control.dart';
import 'pages/menu.dart';


class HomePage extends StatefulWidget {
  final double top;
  const HomePage({super.key, required this.top});

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

  @override
  void initState() {
    super.initState();
    _pages = [
      AddProgramPage(key: _addProgramPageKey),
      StatisticsPage(key: _statisticsPageKey),
      ProgramControlPage(key: _programControlPageKey),
      MenuPage(key: _menuPageKey)
    ];
    _top = widget.top;
  }


  void moveToY(double top) {
    setState(() => _top = top);
  }

  void _onTap(int index) {
    if (index == _selected) return;

    final forward = index > _selected;

    switch (_selected) {
      case 0:
        _addProgramPageKey.currentState?.moveToX(forward ? -MediaQuery.of(context).size.width : MediaQuery.of(context).size.width);
      case 1:
        _statisticsPageKey.currentState?.moveToX(forward ? -MediaQuery.of(context).size.width : MediaQuery.of(context).size.width);
      case 2:
        _programControlPageKey.currentState?.moveToX(forward ? -MediaQuery.of(context).size.width : MediaQuery.of(context).size.width);
      case 3:
        _menuPageKey.currentState?.moveToX(forward ? -MediaQuery.of(context).size.width : MediaQuery.of(context).size.width);
    }

    switch (index) {
      case 0:
        _addProgramPageKey.currentState?.moveToX(0);
      case 1:
        _statisticsPageKey.currentState?.moveToX(0);
      case 2:
        _programControlPageKey.currentState?.moveToX(0);
      case 3:
        _menuPageKey.currentState?.moveToX(0);
    }

    setState(() {
      _selected = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AnimatedPositioned(
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOutQuint,
          top: _top,
          left: 0,
          child: SizedBox(
            width: 390,
            height: 844,
            child: Scaffold(
              backgroundColor: Color(0xFFF5F5F5),
              appBar: getAppBar(_selected),
              body: Stack(children: _pages),
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
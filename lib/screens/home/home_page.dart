import 'package:flutter/material.dart';

import '../../widgets/bottom_navigation_bar.dart';
import '../../widgets/app_bar.dart';

import 'pages/add_program.dart';
import 'pages/statistics.dart';
import 'pages/program_control.dart';
import 'pages/menu.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}


class _HomePageState extends State<HomePage> {
  int _selected = 0;
  bool _flag = true;

  final _addProgramPageKey = GlobalKey<AddProgramPageState>();
  final _statisticsPageKey = GlobalKey<StatisticsPageState>();
  final _programControlPageKey = GlobalKey<ProgramControlPageState>();
  final _menuPageKey = GlobalKey<MenuPageState>();
  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      AddProgramPage(key: _addProgramPageKey),
      StatisticsPage(key: _statisticsPageKey),
      ProgramControlPage(key: _programControlPageKey),
      MenuPage(key: _menuPageKey)
    ];

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_flag) {
        _addProgramPageKey.currentState?.moveToY(0);
        _flag = false;
      }
    });
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
    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5),
      appBar: getAppBar(_selected),
      body:
        Stack(children: _pages),
      bottomNavigationBar: BottomNavigationBarCustom(
        currentIndex: _selected,
        onTap: _onTap
      ),
    );
  }
}
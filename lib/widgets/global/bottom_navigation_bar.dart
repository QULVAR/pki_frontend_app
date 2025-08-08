import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BottomNavigationBarCustom extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const BottomNavigationBarCustom({super.key, required this.currentIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 16, right: 16, left: 16, bottom: 40),
      width: 390,
      height: 104,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Color.fromARGB(5, 0, 0, 0),
            offset: const Offset(0, -2),
            blurRadius: 2.6,
            spreadRadius: 1,
          )
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(child: _navigationItem(0, 'assets/icons/menu_button_add', currentIndex == 0)),
          Expanded(child: _navigationItem(1, 'assets/icons/menu_button_statistic', currentIndex == 1)),
          Expanded(child: _navigationItem(2, 'assets/icons/menu_button_control', currentIndex == 2)),
          Expanded(child: _navigationItem(3, 'assets/icons/menu_button_menu', currentIndex == 3)),
        ],
      ),
    );
  }

  Widget _navigationItem(int index, String icon, bool active) {
    return GestureDetector(
      onTap: () => onTap(index),
      child: Container(
        decoration: BoxDecoration(
          color: active ? const Color(0xFFE6F4FF) : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: AnimatedSwitcher(
          duration: Duration(milliseconds: 300),
          child: SvgPicture.asset(
            active ? '${icon}_selected.svg' : '$icon.svg',
            key: ValueKey(active ? '${icon}_selected.svg' : '$icon.svg'),
            width: 86,
            height: 48,
          ),
        )
      ),
    );
  }
}
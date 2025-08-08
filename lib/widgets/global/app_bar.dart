import 'package:flutter/material.dart';

PreferredSizeWidget getAppBar(int selected) {
  String title = "";
  switch (selected) {
    case 0:
      title = "Добавление программы";
    case 1:
      title = "Статистика по пользователям";
    case 2:
      title = "Управление программами";
    case 3:
      title = "Меню";
  }
  return AppBar(
        backgroundColor: Colors.white,
        title: AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          transitionBuilder: (child, animation) =>
              FadeTransition(opacity: animation, child: child),
          child: Text(
            title,
            key: ValueKey<String>(title),
            style: const TextStyle(
              fontFamily: 'Rubik',
              fontWeight: FontWeight.w400,
              fontStyle: FontStyle.normal,
              fontSize: 20,
            ),
          ),
        ),
        toolbarHeight: 54,
      );
}
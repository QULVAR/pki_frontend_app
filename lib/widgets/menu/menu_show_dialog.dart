import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

void showLogoutConfirm(BuildContext context, VoidCallback onLogout) {
  showCupertinoDialog(
    context: context,
    builder: (ctx) => CupertinoAlertDialog(
      title: const Text('Подтверждение'),
      content: const Text('Вы уверены, что хотите выйти из аккаунта?'),
      actions: [
        CupertinoDialogAction(
          onPressed: () {
            Navigator.of(ctx).pop();
            onLogout();
          },
          textStyle: TextStyle(
            color: CupertinoColors.activeBlue,
            fontSize: 17,
            fontWeight: FontWeight.w500
          ),
          child: const Text('Выход'),
        ),
        const Divider(
          height: 1.0,
          thickness: 0.0,
          color: CupertinoColors.separator,
        ),
        CupertinoDialogAction(
          onPressed: () => Navigator.of(ctx).pop(),
          textStyle: TextStyle(
            color: CupertinoColors.activeBlue,
            fontSize: 17,
          ),
          child: const Text('Отмена'),
        ),
      ],
    ),
  );
}
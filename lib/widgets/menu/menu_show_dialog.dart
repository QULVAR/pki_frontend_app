import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:pki_frontend_app/main.dart';

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
            fontSize: 17.sp,
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
            fontSize: 17.sp,
          ),
          child: const Text('Отмена'),
        ),
      ],
    ),
  );
}
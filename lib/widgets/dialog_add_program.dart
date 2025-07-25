import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';


void showSuccessDialog(BuildContext context, VoidCallback onResetForm) {
  showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
    barrierColor: Color.fromRGBO(0, 0, 0, 0.4),
    transitionDuration: const Duration(milliseconds: 300),
    pageBuilder: (BuildContext buildContext, Animation<double> animation1, Animation<double> animation2) {
      return Align(
        alignment: Alignment.bottomCenter,
        child: Material(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          elevation: 8,
          child: Container(
            width: 390,
            height: 366,
            padding: EdgeInsets.only(top: 36),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Lottie.asset(
                  'assets/animations/checkmark success.json',
                  width: 96,
                  height: 96,
                  repeat: false,
                  options: LottieOptions(enableMergePaths: true),
                  frameRate: FrameRate(120),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Успешно!',
                  style: TextStyle(
                    fontFamily: 'Rubik',
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    height: 1,
                    color: Color(0xFF4DABEE),
                  ),
                ),
                const SizedBox(height: 18),
                SizedBox(
                  width: 228,
                  height: 36,
                  child: const Text(
                    'Пользователь успешно добавлен в\u00A0программу',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Rubik',
                      fontSize: 14,
                      height: (18/14),
                      letterSpacing: 0,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF777777),
                    ),
                  ),
                ),
                SizedBox(height: 46),
                TextButton(
                  onPressed: () {
                    onResetForm();
                    Navigator.of(buildContext).pop();
                  },
                  style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    minimumSize: Size(366, 48),
                    backgroundColor: Color(0xFF4DABEE),
                    shadowColor: Colors.transparent,
                  ),
                  child: Text(
                    'Продолжить',
                    style: TextStyle(
                      fontFamily: 'Rubik',
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      fontStyle: FontStyle.normal,
                      height: 1.25,
                      letterSpacing: 0.0,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.start,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
    transitionBuilder: (BuildContext buildContext, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
      final curved = CurvedAnimation(parent: animation, curve: Curves.easeOutBack);
      return FadeTransition(
        opacity: animation,
        child: ScaleTransition(
          scale: curved,
          child: child,
        ),
      );
    },
  );
}
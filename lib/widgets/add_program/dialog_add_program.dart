import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:pki_frontend_app/main.dart';


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
          borderRadius: BorderRadius.circular(10.sp),
          elevation: 8,
          child: Container(
            width: 390.w,
            height: 366.h,
            padding: EdgeInsets.only(top: 36.h),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Lottie.asset(
                  'assets/animations/checkmark success.json',
                  width: 96.sp,
                  height: 96.sp,
                  repeat: false,
                  options: LottieOptions(enableMergePaths: true),
                  frameRate: FrameRate(120),
                ),
                SizedBox(height: 16.h),
                Text(
                  'Успешно!',
                  style: TextStyle(
                    fontFamily: 'Rubik',
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w500,
                    height: 1,
                    color: Color(0xFF4DABEE),
                  ),
                ),
                SizedBox(height: 18.h),
                SizedBox(
                  width: 228.w,
                  height: 36.h,
                  child: Text(
                    'Пользователь успешно добавлен в\u00A0программу',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Rubik',
                      fontSize: 14.sp,
                      height: (18/14),
                      letterSpacing: 0,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF777777),
                    ),
                  ),
                ),
                SizedBox(height: 46.h),
                TextButton(
                  onPressed: () {
                    onResetForm();
                    Navigator.of(buildContext).pop();
                    FocusScope.of(context).unfocus();
                  },
                  style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    minimumSize: Size(366.w, 48.h),
                    backgroundColor: Color(0xFF4DABEE),
                    shadowColor: Colors.transparent,
                  ),
                  child: Text(
                    'Продолжить',
                    style: TextStyle(
                      fontFamily: 'Rubik',
                      fontWeight: FontWeight.w400,
                      fontSize: 16.sp,
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
      final curved = CurvedAnimation(parent: animation, curve: Curves.easeOutCubic);
      return SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0, 1), // снизу экрана
          end: Offset.zero,
        ).animate(curved),
        child: FadeTransition(
          opacity: curved,
          child: child,
        ),
      );
    },
  );
}
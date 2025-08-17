import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../../scripts/resizer.dart';
import '../../scripts/text_styles.dart';


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
                  style: AppText.addProgramDialog20W500,
                ),
                SizedBox(height: 18.h),
                SizedBox(
                  width: 228.w,
                  height: 36.h,
                  child: Text(
                    'Пользователь успешно добавлен в\u00A0программу',
                    textAlign: TextAlign.center,
                    style: AppText.addProgramDialo14W400
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
                    style: context.menuBody16W400(Colors.white),
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
          begin: const Offset(0, 1),
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
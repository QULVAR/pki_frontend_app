import 'package:flutter/material.dart';
import 'package:pki_frontend_app/main.dart';

import '../global/fields and alerts/email_field.dart';
import '../global/fields and alerts/password_field.dart';


class LoginForm extends StatefulWidget {
  final Function authorize;

  const LoginForm({
    super.key,
    required this.authorize,
  });

  @override
  LoginFormState createState() => LoginFormState();
}

class LoginFormState extends State<LoginForm> {
  String _email = '', _password = '';
  final _emailKey = GlobalKey<EmailInputWidgetState>();
  final _passwordKey = GlobalKey<PasswordInputWidgetState>();
  Color backgroundButtonColor = Color(0xFFE6E6E6);
  bool isFormValid = false;

  void _onEmailChanged(String? email) {
    _email = email ?? '';
    checkFormSetState();
  }

  void _onPasswordChanged(String? password) {
    _password = password ?? '';
    checkFormSetState();
  }

  void clear() {
    _emailKey.currentState?.clear();
    _passwordKey.currentState?.clear();
  }

  void checkFormSetState() {
    isFormValid = _email != '' && _password != '';
    if (isFormValid) {
      setState(() {
        backgroundButtonColor = Color(0xFF4DABEE);
      });
    }
    else {
      setState(() {
        backgroundButtonColor = Color(0xFFE6E6E6);
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 342.w,
      height: 232.h,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'E-mail',
            textAlign: TextAlign.left,
            style: TextStyle(
              fontFamily: 'Rubik',
              fontWeight: FontWeight.w300,
              fontSize: 14.sp,
              height: (18/14),
              letterSpacing: 0,
              color: Color(0xFF404040)
            ),
          ),
          SizedBox(height: 8.h),
          EmailInputWidget(
            key: _emailKey,
            onFilledChanged: _onEmailChanged
          ),
          SizedBox(height: 16.h),
          Text(
            'Пароль',
            textAlign: TextAlign.left,
            style: TextStyle(
              fontFamily: 'Rubik',
              fontWeight: FontWeight.w300,
              fontSize: 14.sp,
              height: (18/14),
              letterSpacing: 0,
              color: Color(0xFF404040)
            ),
          ),
          SizedBox(height: 8.h),
          PasswordInputWidget(
            key: _passwordKey,
            onFilledChanged: _onPasswordChanged
          ),
          SizedBox(height: 20.h),
          AnimatedContainer(
            duration: Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            width: 342.w,
            height: 48.h,
            decoration: BoxDecoration(
              color: backgroundButtonColor,
              borderRadius: BorderRadius.circular(10.sp)
            ),
            child:TextButton(
              key: Key('$backgroundButtonColor'),
              onPressed: () => isFormValid ? widget.authorize(_email, _password) : null,
              style: TextButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.sp),
                ),
                fixedSize: Size(342.w, 48.h),
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
              ),
              child: Text(
                'Войти',
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
              )
            )
          )
        ]
      )
    );
  }
}
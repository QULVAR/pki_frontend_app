import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pki_frontend_app/main.dart';


import '../widgets/login/login_form.dart';



class LoginPage extends StatefulWidget {
  final Function authorize;
  
  const LoginPage({
    super.key,
    required this.authorize,
  });

  @override
  State<LoginPage> createState() => LoginPageState();
}


class LoginPageState extends State<LoginPage> {
  final _loginPageFormKey = GlobalKey<LoginFormState>();
  double _top = 0;

  @override
  void initState() {
    super.initState();
  }

  void clear() {
    _loginPageFormKey.currentState?.clear();
  }

  void moveToY(double top) {
    setState(() => _top = top);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AnimatedPositioned(
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOutQuint,
          top: _top.h,
          left: 0,
          child: SizedBox(
            width: 390.w,
            height: 844.h,
            child: Scaffold(
              resizeToAvoidBottomInset: true,
              backgroundColor: Colors.white,
              body: GestureDetector(
                onTap: () => FocusScope.of(context).unfocus(),
                child: SingleChildScrollView(
                  padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom,
                  ),
                  child: Stack(
                    children: [
                      Column(
                        children: [
                          SizedBox(height: 111.h),
                          Center(
                            child: SvgPicture.asset(
                              "assets/icons/pki_ul_logo.svg",
                              width: 340.sp,
                              height: 68.sp,
                            ),
                          ),
                          SizedBox(height: 12.h),
                          Text(
                            'Личный кабинет для юр. лиц',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'Rubik',
                              fontWeight: FontWeight.w400,
                              fontSize: 18.sp,
                              height: (22/18),
                              letterSpacing: 0,
                              color: Color(0xFF404040)
                            ),
                          ),
                          SizedBox(height: 151.h),
                          LoginForm(
                            key: _loginPageFormKey,
                            authorize: widget.authorize
                          ),
                        ]
                      )
                    ]
                  ),
                ),
              )
            ),
          ) 
        )
      ]
    );
  }
}
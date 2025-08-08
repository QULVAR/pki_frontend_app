import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


import '../widgets/login/login_form.dart';
import '../widgets/global/fields and alerts/email_field.dart';
import '../widgets/global/fields and alerts/password_field.dart';



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
  final _emailKey = GlobalKey<EmailInputWidgetState>();
  final _passwordKey = GlobalKey<PasswordInputWidgetState>();

  double _top = 0;

  @override
  void initState() {
    super.initState();
  }

  void clear() {
    _emailKey.currentState?.clear();
    _passwordKey.currentState?.clear();
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
          top: _top,
          left: 0,
          child: SizedBox(
            width: 390,
            height: 844,
            child: Scaffold(
              backgroundColor: Colors.white,
              body: Stack(
                children: [
                Column(
                    children: [
                      SizedBox(height: 111),
                      Center(
                        child: SvgPicture.asset(
                          "assets/icons/pki_ul_logo.svg",
                          width: 340,
                          height: 68,
                        ),
                      ),
                      SizedBox(height: 12),
                      Text(
                        'Личный кабинет для юр. лиц',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Rubik',
                          fontWeight: FontWeight.w400,
                          fontSize: 18,
                          height: (22/18),
                          letterSpacing: 0,
                          color: Color(0xFF404040)
                        ),
                      ),
                      SizedBox(height: 151),
                      LoginForm(
                        authorize: widget.authorize,
                        emailKey: _emailKey,
                        dropDownButtonKey: _passwordKey
                      ),
                    ]
                  )
                ]
              ),
            ),
          ) 
        )
      ]
    );
  }
}
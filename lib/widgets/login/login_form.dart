import 'package:flutter/material.dart';

import '../global/fields and alerts/email_field.dart';
import '../global/fields and alerts/password_field.dart';
import 'login_button.dart';


class LoginForm extends StatefulWidget {
  final Function authorize;
  final GlobalKey<EmailInputWidgetState> emailKey;
  final GlobalKey<PasswordInputWidgetState> dropDownButtonKey;

  const LoginForm({
    super.key,
    required this.authorize,
    required this.emailKey,
    required this.dropDownButtonKey
  });

  @override
  LoginFormState createState() => LoginFormState();
}

class LoginFormState extends State<LoginForm> {
  String _email = '', _password = '';

  void _onEmailChanged(String? email) => setState(() => _email = email ?? '');
  void _onPasswordChanged(String? password) => setState(() => _password = password ?? '');


  @override
  Widget build(BuildContext context) {
    final isFormValid = _email != '' && _password != '';
    return SizedBox(
      width: 342,
      height: 232,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'E-mail',
            textAlign: TextAlign.left,
            style: TextStyle(
              fontFamily: 'Rubik',
              fontWeight: FontWeight.w300,
              fontSize: 14,
              height: (18/14),
              letterSpacing: 0,
              color: Color(0xFF404040)
            ),
          ),
          SizedBox(height: 8),
          EmailInputWidget(onFilledChanged: _onEmailChanged),
          SizedBox(height: 16),
          Text(
            'Пароль',
            textAlign: TextAlign.left,
            style: TextStyle(
              fontFamily: 'Rubik',
              fontWeight: FontWeight.w300,
              fontSize: 14,
              height: (18/14),
              letterSpacing: 0,
              color: Color(0xFF404040)
            ),
          ),
          SizedBox(height: 8),
          PasswordInputWidget(onFilledChanged: _onPasswordChanged),
          SizedBox(height: 20),
          getButton(widget.authorize, isFormValid, _email, _password)
        ]
      )
    );
  }
}
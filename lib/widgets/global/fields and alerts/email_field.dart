import 'package:flutter/material.dart';
import 'package:pki_frontend_app/main.dart';


class EmailInputWidget extends StatefulWidget {

  final ValueChanged<String?> onFilledChanged;

  const EmailInputWidget({
    super.key,
    required this.onFilledChanged,
  });

  @override
  State<EmailInputWidget> createState() => EmailInputWidgetState();
}

class EmailInputWidgetState extends State<EmailInputWidget> {
  bool isFilled = false;
  final TextEditingController _emailController = TextEditingController();
  final _emailRegExp = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');

  void _onEmailChanged() {
    final valid = _emailRegExp.hasMatch(_emailController.text);
    if (valid != isFilled) {
      setState(() {
        isFilled = valid;
        widget.onFilledChanged(isFilled ? _emailController.text : null);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _emailController.addListener(_onEmailChanged);
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void clear() {
    setState(() {
      _emailController.clear();
      widget.onFilledChanged(null);
      isFilled = false;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      width: 342.w,
      height: 48.h,
      padding: EdgeInsets.only(bottom: 14.h, top: 15.h, left: 12.w, right: 12.w),
      decoration: BoxDecoration(
        color: Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(8.sp),
      ),
      child: TextField(
        controller: _emailController,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: 'Ваш e-mail',
          hintStyle: TextStyle(
            fontFamily: 'Rubik',
            fontWeight: FontWeight.w300,
            fontSize: 16.sp,
            height: (20/16),
            letterSpacing: 0,
            color: Color(0xFFA7A7A7)
          ),
          hintFadeDuration: Duration(milliseconds: 300)
        ),
        style: TextStyle(
          fontFamily: 'Rubik',
          fontWeight: FontWeight.w400,
          fontSize: 16.sp,
          height: (20/16),
          letterSpacing: 0,
          color: Color(0xFF404040)
        ),
        maxLines: 1,
        keyboardType: TextInputType.emailAddress,
      ),
    );
  }
}
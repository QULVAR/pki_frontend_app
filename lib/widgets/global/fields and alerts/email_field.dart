import 'package:flutter/material.dart';


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
        widget.onFilledChanged(_emailController.text);
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
    _emailController.clear();
    widget.onFilledChanged(null);
    isFilled = false;
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      width: 342,
      height: 48,
      padding: EdgeInsets.only(bottom: 14, top: 15, left: 12, right: 12),
      decoration: BoxDecoration(
        color: Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextField(
        controller: _emailController,
        decoration: const InputDecoration(
          border: InputBorder.none,
          hintText: 'Ваш e-mail',
          hintStyle: TextStyle(
            fontFamily: 'Rubik',
            fontWeight: FontWeight.w300,
            fontSize: 16,
            height: (20/16),
            letterSpacing: 0,
            color: Color(0xFFA7A7A7)
          ),
        ),
        style: TextStyle(
          fontFamily: 'Rubik',
          fontWeight: FontWeight.w400,
          fontSize: 16,
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
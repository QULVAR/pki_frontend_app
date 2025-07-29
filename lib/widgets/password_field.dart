import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


class PasswordInputWidget extends StatefulWidget {

  final ValueChanged<String?> onFilledChanged;

  const PasswordInputWidget({
    super.key,
    required this.onFilledChanged,
  });

  @override
  State<PasswordInputWidget> createState() => PasswordInputWidgetState();
}

class PasswordInputWidgetState extends State<PasswordInputWidget> {
  bool isFilled = false;
  final TextEditingController _passwordController = TextEditingController();
  String _addedPathToPasswordFieldIcon = '_with_line';
  bool _obscureText = true;

  @override
  void initState() {
    super.initState();
    _passwordController.addListener(() {
      if (_passwordController.text.length >= 7) {
        setState(() {
          isFilled = true;
          widget.onFilledChanged(_passwordController.text);
        });
      } else {
        setState(() {
          isFilled = false;
          widget.onFilledChanged(null);
        });
      }
    });
  }

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  void clear() {
    _passwordController.clear();
    widget.onFilledChanged(null);
    isFilled = false;
    _addedPathToPasswordFieldIcon = '_with_line';
    _obscureText = true;
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      width: 342,
      height: 48,
      padding: EdgeInsets.only(bottom: 14, top: 14, left: 12, right: 0),
      decoration: BoxDecoration(
        color: Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextField(
        controller: _passwordController,
        decoration: InputDecoration(
          suffixIcon: IconButton(
            padding: EdgeInsets.zero,
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            hoverColor: Colors.transparent,
            focusColor: Colors.transparent,
            splashRadius: null,
            onPressed: () {
              setState(() {
                _obscureText = !_obscureText;
                _addedPathToPasswordFieldIcon = _obscureText ? '_with_line' : '';
              });
            },
            icon: LayoutBuilder(
              builder: (context, constraints) {
                return AnimatedSwitcher(
                  duration: Duration(milliseconds: 300),
                  child: AnimatedSwitcher(
                    duration: Duration(milliseconds: 300),
                    child: SvgPicture.asset(
                      'assets/icons/eye$_addedPathToPasswordFieldIcon.svg',
                      key: ValueKey(_addedPathToPasswordFieldIcon),
                      width: 21,
                      height: _addedPathToPasswordFieldIcon != '' ? 18 : 16,
                    ),
                  ),
                );
              },
            ),
          ),
          border: InputBorder.none,
          hintText: 'Ваш пароль',
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
        obscureText: _obscureText,
        maxLines: 1,
      ),
    );
  }
}
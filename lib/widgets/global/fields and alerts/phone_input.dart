import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class PhoneInputWidget extends StatefulWidget {
  final ValueChanged<bool> onFilledChanged;

  const PhoneInputWidget({super.key, required this.onFilledChanged});

  @override
  State<PhoneInputWidget> createState() => PhoneInputWidgetState();
}

class PhoneInputWidgetState extends State<PhoneInputWidget> {
  bool isFilled = false;
  Color fieldColor = Color(0xFFF5F5F5);
  Color textPreviousField = Color.fromARGB(255, 167, 167, 167);
  final TextEditingController _phoneController = TextEditingController();
  final _phoneFormatter = MaskTextInputFormatter(
    mask: '###) ###-##-##',
    filter: {"#": RegExp(r'\d')},
  );
  String _phoneIcon = "assets/icons/phone.svg";

  @override
  void initState() {
    super.initState();
    _phoneController.addListener(() {
      final digitsOnly = _phoneFormatter.getUnmaskedText();
      if (digitsOnly.length == 10) {
        setState(() {
          fieldColor = Color(0xFFEDF7FD);
          _phoneIcon = "assets/icons/phone_blue.svg";
          isFilled = true;
          widget.onFilledChanged(isFilled);
        });
      } else {
        setState(() {
          fieldColor = Color(0xFFF5F5F5);
          textPreviousField = Color.fromARGB(255, 167, 167, 167);
          _phoneIcon = "assets/icons/phone.svg";
          isFilled = false;
          widget.onFilledChanged(isFilled);
        });
        // ignore: prefer_is_empty
        if (digitsOnly.length != 0) {
          setState(() {
            textPreviousField = Colors.black;
          });
        }
      }
    });
  }

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  void clear() {
    _phoneController.clear();
    widget.onFilledChanged(false);
    isFilled = false;
    fieldColor = Color(0xFFF5F5F5);
    _phoneIcon = "assets/icons/phone.svg";
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      padding: EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: fieldColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          AnimatedSwitcher(
            duration: Duration(milliseconds: 300),
            child: SvgPicture.asset(
              _phoneIcon,
              key: ValueKey(_phoneIcon),
              width: 24,
              height: 24,
            ),
          ),
          SizedBox(width: 8,),
          Text(
            '+7 (',
            style: TextStyle(
              fontFamily: 'Rubik',
              fontWeight: FontWeight.w300,
              fontSize: 16,
              color: textPreviousField,
              letterSpacing: 0.0,
            ),
          ),
          SizedBox(
            width: 259,
            height: 48,
            child: TextField(
              keyboardType: TextInputType.phone,
              controller: _phoneController,
              inputFormatters: [_phoneFormatter],
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: '___) ___-__-__',
                hintStyle: TextStyle(
                  fontFamily: 'Rubik',
                  fontWeight: FontWeight.w300,
                  fontSize: 16,
                  color: Color.fromARGB(255, 167, 167, 167),
                  letterSpacing: 0.0,
                ),
              ),
              style: TextStyle(
                fontFamily: 'Rubik',
                fontSize: 16
              ),
            ),
          ),
        ],
      ),
    );
  }
}

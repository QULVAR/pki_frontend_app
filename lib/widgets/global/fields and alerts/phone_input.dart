import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:pki_frontend_app/main.dart';

class PhoneInputWidget extends StatefulWidget {
  final ValueChanged<bool> onFilledChanged;

  const PhoneInputWidget({super.key, required this.onFilledChanged});

  @override
  State<PhoneInputWidget> createState() => PhoneInputWidgetState();
}

class PhoneInputWidgetState extends State<PhoneInputWidget> {
  bool isFilled = false;
  Color fieldColor = Color(0xFFF5F5F5);
  final TextEditingController _phoneController = TextEditingController();
  final _phoneFormatter = MaskTextInputFormatter(
    mask: '+7 (###) ###-##-##',
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
          _phoneIcon = "assets/icons/phone.svg";
          isFilled = false;
          widget.onFilledChanged(isFilled);
        });
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
      width: 342.w,
      height: 48.h,
      padding: EdgeInsets.only(top: 12.h, bottom: 12.h, right: 12.w, left: 12.w),
      decoration: BoxDecoration(
        color: fieldColor,
        borderRadius: BorderRadius.circular(12.sp),
      ),
      child: Row(
        children: [
          AnimatedSwitcher(
            duration: Duration(milliseconds: 300),
            child: SvgPicture.asset(
              _phoneIcon,
              key: ValueKey(_phoneIcon),
              width: 24.sp,
              height: 24.sp,
            ),
          ),
          SizedBox(width: 8.w,),
          SizedBox(
            height: 48.h,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                SizedBox(
                  width: 259.w,
                  height: 48.h,
                  child: TextField(
                    keyboardType: TextInputType.phone,
                    controller: _phoneController,
                    inputFormatters: [_phoneFormatter],
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      isCollapsed: true,
                      contentPadding: EdgeInsets.only(bottom: 0),
                      hintText: '+7 (___) ___-__-__',
                      hintStyle: TextStyle(
                        fontFamily: 'Rubik',
                        fontWeight: FontWeight.w300,
                        fontSize: 16.sp,
                        color: Color.fromARGB(255, 167, 167, 167),
                        letterSpacing: 0.0,
                      ),
                      hintFadeDuration: Duration(milliseconds: 300)
                    ),
                    style: TextStyle(
                      fontFamily: 'Rubik',
                      fontWeight: FontWeight.w300,
                      fontSize: 16.sp,
                      color: Colors.black,
                      letterSpacing: 0.0,
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

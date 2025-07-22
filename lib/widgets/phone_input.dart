import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';


class PhoneInputWidget extends StatefulWidget {

  final ValueChanged<bool> onFilledChanged;

  const PhoneInputWidget({
    Key? key,
    required this.onFilledChanged,
  }) : super(key: key);

  @override
  State<PhoneInputWidget> createState() => PhoneInputWidgetState();
}

class PhoneInputWidgetState extends State<PhoneInputWidget> {
  bool isFilled = false;
  Color fieldColor = Color(0xFFF5F5F5);
  final TextEditingController _phoneController = TextEditingController();
  final _phoneFormatter = MaskTextInputFormatter(
    mask: '+7 (###) ###-##-##',
    filter: { "#": RegExp(r'\d') },
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


  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300), // ← тут задаётся плавность
      curve: Curves.easeInOut, // можно поменять на другую анимацию
      padding: EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: fieldColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextField(
        keyboardType: TextInputType.phone,
        controller: _phoneController,
        inputFormatters: [_phoneFormatter],
        decoration: InputDecoration(
          icon: LayoutBuilder(
            builder: (context, constraints) {
              return AnimatedSwitcher(
                duration: Duration(milliseconds: 300),
                child: SvgPicture.asset(
                  _phoneIcon,
                  key: ValueKey(_phoneIcon),
                  width: 24,
                  height: 24,
                ),
              );
            },
          ),
          border: InputBorder.none,
          hintText: '+7 (___) ___-__-__',
          hintStyle: TextStyle(
            fontFamily: 'Rubik',
            fontWeight: FontWeight.w300,
            fontSize: 16,
            color: Color.fromARGB(255, 167, 167, 167),
            letterSpacing: 0.0
          ),
        ),
        style: TextStyle(
          fontFamily: 'Rubik',
          fontSize: 16,
        ),
      ),
    );
  }
}
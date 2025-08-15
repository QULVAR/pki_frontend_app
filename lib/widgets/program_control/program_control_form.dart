import 'package:flutter/material.dart';
import 'package:pki_frontend_app/main.dart';

import '../global/fields and alerts/drop_down_button.dart';


class ProgramControlForm extends StatefulWidget {
  final ValueChanged<String?> onSelectedChanged;
  const ProgramControlForm({
    super.key,
    required this.onSelectedChanged,
  });

  @override
  ProgramControlFormState createState() => ProgramControlFormState();
}

class ProgramControlFormState extends State<ProgramControlForm> {
  final _dropDownButtonKey = GlobalKey<DropDownButtonState>();

  void clear() {
    _dropDownButtonKey.currentState?.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Управление существующими программами',
          style: TextStyle(
            fontFamily: 'Rubik',
            fontWeight: FontWeight.w400,
            fontSize: 20.sp,
            height: 1,
            letterSpacing: 0,
            color: Color(0xFF404040)
          ),
        ),
        SizedBox(height: 24.h),
        Text(
          'Выберите программу:',
          style: TextStyle(
            fontFamily: 'Rubik',
            fontWeight: FontWeight.w300,
            fontSize: 14.sp,
            height: 1.0,
            letterSpacing: 0.0,
          ),
          textAlign: TextAlign.start,
        ),
        SizedBox(height: 8.h),
        DropDownButton(key: _dropDownButtonKey, onSelectedChanged: widget.onSelectedChanged),
      ]
    );
  }
}
import 'package:flutter/material.dart';

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
            fontSize: 20,
            height: 1,
            letterSpacing: 0,
            color: Color(0xFF404040)
          ),
        ),
        SizedBox(height: 24),
        Text(
          'Выберите программу:',
          style: const TextStyle(
            fontFamily: 'Rubik',
            fontWeight: FontWeight.w300,
            fontSize: 14,
            height: 1.0,
            letterSpacing: 0.0,
          ),
          textAlign: TextAlign.start,
        ),
        SizedBox(height: 8),
        DropDownButton(key: _dropDownButtonKey, onSelectedChanged: widget.onSelectedChanged),
        SizedBox(height: 24),
        SizedBox(
          height: 1,
          width: 342,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: Color(0xFFF2F2F2)
            )
          ),
        ),
        SizedBox(height: 24,),
        Row(
          children: [
            Container(
              width: 253,
              height: 26,
              padding: EdgeInsets.only(top: 4, left: 4, bottom: 8),
              child: Text(
                'Номер телефона',
                style: TextStyle(
                  fontFamily: 'Rubik',
                  fontWeight: FontWeight.w300,
                  fontSize: 12,
                  height: 1,
                  letterSpacing: 0,
                  color: Color(0xFF404040)
                ),
              ),
            ),
            SizedBox(
              height: 26,
              width: 1,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: Color(0xFFF2F2F2)
                )
              ),
            ),
            Container(
              width: 88,
              height: 26,
              padding: EdgeInsets.only(top: 4, left: 4, bottom: 8, right: 4),
              child: Text(
                'Статус',
                style: TextStyle(
                  fontFamily: 'Rubik',
                  fontWeight: FontWeight.w300,
                  fontSize: 12,
                  height: 1,
                  letterSpacing: 0,
                  color: Color(0xFF404040)
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ]
    );
  }
}
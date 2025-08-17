import 'package:flutter/material.dart';

import '../global/fields and alerts/drop_down_button.dart';
import '../../../scripts/text_styles.dart';
import '../../../scripts/resizer.dart';


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
          style: context.addProgramFormHeader(Color(0xFF404040)),
        ),
        SizedBox(height: 24.h),
        Text(
          'Выберите программу:',
          style: AppText.programControlFormText,
          textAlign: TextAlign.start,
        ),
        SizedBox(height: 8.h),
        DropDownButton(key: _dropDownButtonKey, onSelectedChanged: widget.onSelectedChanged),
      ]
    );
  }
}
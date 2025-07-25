import 'package:flutter/material.dart';

import 'phone_input.dart';
import 'drop_down_button.dart';

class AddProgramForm extends StatefulWidget {
  final VoidCallback onSubmit;
  final GlobalKey<PhoneInputWidgetState> phoneKey;
  final GlobalKey<DropDownButtonState> dropDownButtonKey;
  const AddProgramForm({
    super.key,
    required this.onSubmit,
    required this.phoneKey,
    required this.dropDownButtonKey
  });

  @override
  AddProgramFormState createState() => AddProgramFormState();
}

class AddProgramFormState extends State<AddProgramForm> {
  bool _phoneOk = false, _progOk = false;

  void _onPhoneChanged(bool ok) => setState(() => _phoneOk = ok);
  void _onProgChanged(String? val) => setState(() => _progOk = val != null);

  @override
  Widget build(BuildContext context) {
    final isFormValid = _phoneOk && _progOk;
    return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        width: 366,
        height: 256,
        margin: EdgeInsets.only(top: 16, right: 12, left: 12, bottom: 18),
        padding: EdgeInsets.only(top: 12, right: 12, left: 12, bottom: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(6),
        ),
        child:
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Добавление пользователя в\u00A0программу',
              style: const TextStyle(
                fontFamily: 'Rubik',
                fontWeight: FontWeight.w400,
                fontStyle: FontStyle.normal,
                fontSize: 20,
                height: 1,
                letterSpacing: 0.0,
              ),
              textAlign: TextAlign.start,
            ),
            SizedBox(height: 26),
            Text(
              'Введите номер телефона:',
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
            PhoneInputWidget(key: widget.phoneKey, onFilledChanged: _onPhoneChanged),
            SizedBox(height: 18),
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
            SizedBox(height: 12),
            DropDownButton(key: widget.dropDownButtonKey, onSelectedChanged: _onProgChanged),
          ],
        ),
      ),
      AnimatedContainer(
        width: 366,
        height: 44,
        margin: EdgeInsets.only(top: 2, right: 12, left: 12, bottom: 0),
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          color: isFormValid ? Color(0xFF4DABEE) : Color(0xFFE6E6E6),
          borderRadius: BorderRadius.circular(10),
        ),
        child: TextButton(
          onPressed: isFormValid ? widget.onSubmit : null,
          style: TextButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            minimumSize: Size(366, 44),
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
          ),
          child: Text(
            'Применить',
            style: TextStyle(
              fontFamily: 'Rubik',
              fontWeight: FontWeight.w400,
              fontSize: 16,
              fontStyle: FontStyle.normal,
              height: 1.25,
              letterSpacing: 0.0,
              color: Colors.white,
            ),
            textAlign: TextAlign.start,
          ),
        ),
      )
    ]
  );
}
}
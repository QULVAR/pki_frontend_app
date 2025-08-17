import 'package:flutter/material.dart';
import '../../scripts/resizer.dart';
import '../../scripts/text_styles.dart';

import '../global/fields and alerts/phone_input.dart';
import '../global/fields and alerts/drop_down_button.dart';

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
        width: 366.w,
        height: 256.h,
        margin: EdgeInsets.only(top: 16.h, right: 12.w, left: 12.w, bottom: 18.h),
        padding: EdgeInsets.only(top: 12.h, right: 12.w, left: 12.w, bottom: 15.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(6.sp),
        ),
        child:
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Добавление пользователя в\u00A0программу',
              style: AppText.addProgramFormHeader,
              textAlign: TextAlign.start,
            ),
            SizedBox(height: 26.h),
            Text(
              'Введите номер телефона:',
              style: AppText.addProgramFormFieldsText,
              textAlign: TextAlign.start,
            ),
            SizedBox(height: 8.h),
            PhoneInputWidget(key: widget.phoneKey, onFilledChanged: _onPhoneChanged),
            SizedBox(height: 18.h),
            Text(
              'Выберите программу:',
              style: AppText.addProgramFormFieldsText,
              textAlign: TextAlign.start,
            ),
            SizedBox(height: 12.h),
            DropDownButton(key: widget.dropDownButtonKey, onSelectedChanged: _onProgChanged),
          ],
        ),
      ),
      AnimatedContainer(
        width: 366.w,
        height: 44.h,
        margin: EdgeInsets.only(top: 2.h, right: 12.w, left: 12.w, bottom: 0),
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          color: isFormValid ? Color(0xFF4DABEE) : Color(0xFFE6E6E6),
          borderRadius: BorderRadius.circular(10.sp),
        ),
        child: TextButton(
          onPressed: isFormValid ? widget.onSubmit : null,
          style: TextButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.sp),
            ),
            minimumSize: Size(366.w, 44.h),
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
          ),
          child: Text(
            'Применить',
            style: AppText.buttonText16W400,
            textAlign: TextAlign.start,
          ),
        ),
      )
    ]
  );
}
}
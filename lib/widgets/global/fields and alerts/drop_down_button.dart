import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

import '../../../scripts/resizer.dart';
import '../../../scripts/text_styles.dart';


class DropDownButton extends StatefulWidget {

  final ValueChanged<String?> onSelectedChanged;


  const DropDownButton({
    super.key,
    required this.onSelectedChanged,
  });

  @override
  State<DropDownButton> createState() => DropDownButtonState();
}

class DropDownButtonState extends State<DropDownButton> {
  bool isSelected = false;

  final List<String> _programs = [
    'Заряд 80',
    'Тариф ООО «ПКИ»',
    'Заряд 120', 
  ];
  String? _selectedProgram;

  void clear() {
    _selectedProgram = null;
    widget.onSelectedChanged(null);
    isSelected = false;
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      width: 342.w,
      height: 48.h,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.sp),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: _selectedProgram != null
              ? [Color(0xFFEDF7FD), Color(0xFFE6F4FF)]
              : [Color(0xFFF5F5F5), Color(0xFFF5F5F5)],
        ),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton2<String>(
          isExpanded: true,
          hint: Text(
            'Выбрать программу',
            style: AppText.dropDownButtonPlaceholder,
          ),
          items: _programs.map((program) => DropdownMenuItem<String>(
            value: program,
            child: Text(
              program,
              style: AppText.dropDownButtonItem,
            ),
          )).toList(),
          value: _selectedProgram,
          onChanged: (value) {
            setState(() {
              _selectedProgram = value;
              isSelected = true;
              widget.onSelectedChanged(value);
            });
          },
          buttonStyleData: ButtonStyleData(
            padding: EdgeInsets.only(right: 12.w),
            height: 56.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(8.sp)),
            ),
          ),
          dropdownStyleData: DropdownStyleData(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(8.sp)),
              color: Colors.white,
            ),
            offset: Offset(0, -4),
          ),
          iconStyleData: IconStyleData(
            icon: Icon(Icons.keyboard_arrow_down),
            iconSize: 24.sp,
          ),
        ),
      ),
    );
  }
}
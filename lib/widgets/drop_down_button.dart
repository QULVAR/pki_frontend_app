import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';


class DropDownButton extends StatefulWidget {

  final ValueChanged<String?> onSelectedChanged;

  const DropDownButton({
    Key? key,
    required this.onSelectedChanged,
  }) : super(key: key);

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

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      width: 342,
      height: 48,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
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
            style: TextStyle(
              fontFamily: 'Rubik',
              fontWeight: FontWeight.w300,
              fontSize: 16,
              color: Color.fromARGB(255, 167, 167, 167),
            ),
          ),
          items: _programs.map((program) => DropdownMenuItem<String>(
            value: program,
            child: Text(
              program,
              style: TextStyle(
                fontFamily: 'Rubik',
                fontSize: 16,
              ),
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
            padding: EdgeInsets.only(right: 12),
            height: 56,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(12)),
            ),
          ),
          dropdownStyleData: const DropdownStyleData(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(12)),
              color: Colors.white,
            ),
            offset: Offset(0, -4),
          ),
          iconStyleData: const IconStyleData(
            icon: Icon(Icons.keyboard_arrow_down),
            iconSize: 24,
          ),
        ),
      ),
    );
  }
}
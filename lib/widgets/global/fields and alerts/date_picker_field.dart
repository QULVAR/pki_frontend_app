import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import 'calendar_pop_up.dart';


class DatePickerField extends StatefulWidget {
  final void Function(DateTime?) onChanged;

  const DatePickerField({
    super.key,
    required this.onChanged,
  });

  @override
  DatePickerFieldState createState() => DatePickerFieldState();
}

class DatePickerFieldState extends State<DatePickerField> {
  final TextEditingController _controller = TextEditingController();
  final _dateFormatter = MaskTextInputFormatter(
    mask: '##.##.#### ##:##',
    filter: { "#": RegExp(r'\d') },
  );
  Color fieldColor = Color(0xFFF5F5F5);
  String _calendarIcon = "assets/icons/calendar_icon.svg";
  DateTime? selectedDate;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      final digitsOnly = _dateFormatter.getUnmaskedText();
      final maskedDateTime = _dateFormatter.getMaskedText();
      final maskedDateTimeSplitted = maskedDateTime.split(' ');
      final maskedDateSplitted = maskedDateTimeSplitted[0].split('.');
      late final List<String> maskedTimeSplitted;
      try {
        maskedTimeSplitted = maskedDateTimeSplitted[1].split(':');
      } catch (_) {
        maskedTimeSplitted = [];
      }
      bool flag = false;
      if (maskedDateSplitted.isNotEmpty) {
        // ignore: prefer_is_empty
        if ((maskedDateSplitted.length >= 1)
          && (maskedDateSplitted[0].length == 2)
          && (int.parse(maskedDateSplitted[0]) > 31)) {
          maskedDateSplitted[0] = '31';
          flag = true;
        } else if ((maskedDateSplitted.length >= 2)
                && (maskedDateSplitted[1].length == 2)
                && (int.parse(maskedDateSplitted[1]) > 12)) {
          maskedDateSplitted[1] = '12';
          flag = true;
        } else if ((maskedDateSplitted.length == 3)
                && (maskedDateSplitted[2].length == 4)
                && (int.parse(maskedDateSplitted[2]) < 1970)) {
          maskedDateSplitted[2] = '1970';
          flag = true;
          //ignore: prefer_is_empty
        } else if ((maskedTimeSplitted.length >= 1)
                && (maskedTimeSplitted[0].length == 2)
                && (int.parse(maskedTimeSplitted[0]) > 23)) {
          maskedTimeSplitted[0] = '23';
          flag = true;
        } else if ((maskedTimeSplitted.length == 2)
                && (maskedTimeSplitted[1].length == 2)
                && (int.parse(maskedTimeSplitted[1]) > 59)) {
          maskedTimeSplitted[1] = '59';
          flag = true;
        } else {
          if (digitsOnly.length == 12) {
            DateTime? candidate = DateTime(
              int.parse(maskedDateSplitted[2]),
              int.parse(maskedDateSplitted[1]),
              int.parse(maskedDateSplitted[0]),
              int.parse(maskedTimeSplitted[0]),
              int.parse(maskedTimeSplitted[1])
            );
            if (!(candidate.year == int.parse(maskedDateSplitted[2])
                && candidate.month == int.parse(maskedDateSplitted[1])
                && candidate.day == int.parse(maskedDateSplitted[0])
                && candidate.hour == int.parse(maskedTimeSplitted[0])
                && candidate.minute == int.parse(maskedTimeSplitted[1]))) {
              flag = true;
              maskedDateSplitted[2] = '${candidate.year}';
              maskedDateSplitted[1] = candidate.month.toString().padLeft(2, '0');
              maskedDateSplitted[0] = candidate.day.toString().padLeft(2, '0');
              maskedTimeSplitted[0] = candidate.hour.toString().padLeft(2, '0');
              maskedTimeSplitted[1] = candidate.minute.toString().padLeft(2, '0');
            }
            setState(() {
              fieldColor = Color(0xFFEDF7FD);
              _calendarIcon = "assets/icons/calendar_icon_blue.svg";
              widget.onChanged(candidate);
              selectedDate = candidate;
            });
          } else {
            setState(() {
              fieldColor = Color(0xFFF5F5F5);
              _calendarIcon = "assets/icons/calendar_icon.svg";
              widget.onChanged(null);
              selectedDate = null;
            });
          }
        }
      }
      if (flag) {
        final newText = '${maskedDateSplitted.join('.')} ${maskedTimeSplitted.join(':')}';
        _dateFormatter.clear(); 
        final formatted = _dateFormatter.formatEditUpdate(
          TextEditingValue.empty,
          TextEditingValue(text: newText),
        );
        _controller.value = formatted;
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _pickDate() {
    showDialog(
      context: context,
      barrierColor: Colors.black.withValues(alpha: 0.2),
      builder: (_) => DatePickerCalendar(
        mode: 'single',
        selectedDateSingle: selectedDate,
        showDateSingle: showPickedDate,
      ),
    );
  }

  void showPickedDate(DateTime value) {
    String newText = '';
    newText += value.day.toString().padLeft(2, '0');
    newText += '.';
    newText += value.month.toString().padLeft(2, '0');
    newText += '.';
    newText += '${value.year}';
    newText += ' ';
    newText += value.hour.toString().padLeft(2, '0');
    newText += ':';
    newText += value.minute.toString().padLeft(2, '0');
    _dateFormatter.clear(); 
    final formatted = _dateFormatter.formatEditUpdate(
      TextEditingValue.empty,
      TextEditingValue(text: newText),
    );
    _controller.value = formatted;
  }


  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      padding: EdgeInsets.only(top: 12, bottom: 12, left: 12),
      height: 48,
      width: 342,
      decoration: BoxDecoration(
        color: fieldColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextField(
        keyboardType: TextInputType.datetime,
        controller: _controller,
        inputFormatters: [_dateFormatter],
        decoration: InputDecoration(
          suffixIcon: IconButton(
            padding: EdgeInsets.zero,
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            hoverColor: Colors.transparent,
            focusColor: Colors.transparent,
            splashRadius: null,
            onPressed: _pickDate,
            icon: LayoutBuilder(
              builder: (context, constraints) {
                return AnimatedSwitcher(
                  duration: Duration(milliseconds: 300),
                  child: SvgPicture.asset(
                    _calendarIcon,
                    key: ValueKey(_calendarIcon),
                    width: 24,
                    height: 24,
                  ),
                );
              },
            ),
          ),
          border: InputBorder.none,
          hintText: 'дд.мм.гггг чч:мм',
          hintStyle: TextStyle(
            fontFamily: 'Rubik',
            fontWeight: FontWeight.w300,
            fontSize: 16,
            height: (20/16),
            letterSpacing: 0,
            color: Color(0xFFA7A7A7)
          ),
        ),
        style: TextStyle(
          fontFamily: 'Rubik',
          fontWeight: FontWeight.w400,
          fontSize: 16,
          height: (20/16),
          letterSpacing: 0,
          color: Color(0xFF404040)
        ),
      ),
    );
  }
}

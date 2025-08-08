import 'package:flutter/material.dart';

import '../../widgets/global/fields and alerts/date_picker_field.dart';
import '../../widgets/global/fields and alerts/calendar_pop_up.dart';


class StatisticsPageForm extends StatefulWidget {

  final void Function(List<DateTime>) findInfo;
  
  const StatisticsPageForm({
    super.key,
    required this.findInfo
  });

  @override
  State<StatisticsPageForm> createState() => StatisticsPageFormState();
}

class StatisticsPageFormState extends State<StatisticsPageForm> {
  final _datePickerKey1 = GlobalKey<DatePickerFieldState>();
  final _datePickerKey2 = GlobalKey<DatePickerFieldState>();
  DateTime? _datePickerValue1;
  DateTime? _datePickerValue2;
  Color backgroundColorButton = Color(0xFFE6E6E6);

  void showDateRange(List<DateTime> dateRange) {
    _datePickerKey1.currentState?.showPickedDate(dateRange[0]);
    _datePickerKey2.currentState?.showPickedDate(dateRange[1]);
  }

  void dateChanged1(DateTime? val) {
    _datePickerValue1 = val;
    buttonColorSelector();
  }

  void dateChanged2(DateTime? val) {
    _datePickerValue2 = val;
    buttonColorSelector();
  }

  void buttonColorSelector() {
    final Color buttonColor;
    if (_datePickerValue1 != null && _datePickerValue2 != null && _datePickerValue1!.isBefore(_datePickerValue2!)) {
      buttonColor = Color(0xFF4DABEE);
    } else {
      buttonColor = Color(0xFFE6E6E6);
    }
    if (buttonColor != backgroundColorButton) {
      setState(() {
        backgroundColorButton = buttonColor;
      });
    }
  }

  void _pickDate() {
    showDialog(
      context: context,
      barrierColor: Colors.black.withValues(alpha: 0.2),
      builder: (_) => DatePickerCalendar(
        mode: 'range',
        selectedDateRange: [
          _datePickerKey1.currentState?.selectedDate,
          _datePickerKey2.currentState?.selectedDate
        ],
        showDateRange: showDateRange,
      ),
    );
  }

  @override
  Widget build(BuildContext) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: 171,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Поиск по датам',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontFamily: 'Rubik',
                      fontWeight: FontWeight.w400,
                      fontSize: 20,
                      height: 1,
                      letterSpacing: 0,
                      color: Color(0xFF404040)
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 171,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    style: ButtonStyle(
                      padding: WidgetStateProperty.all(EdgeInsets.zero),
                      minimumSize: WidgetStateProperty.all(Size.zero),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      alignment: Alignment.center,
                      overlayColor: WidgetStateProperty.all(Colors.transparent),
                      splashFactory: NoSplash.splashFactory,
                      enableFeedback: false,
                    ),
                    onPressed: _pickDate,
                    child: Text(
                      'Выбрать отрезок',
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        fontFamily: 'Rubik',
                        fontWeight: FontWeight.w300,
                        fontSize: 20,
                        height: 1,
                        letterSpacing: 0,
                        color: Color(0xFF4DABEE)
                      ),
                    ),
                  )
                ],
              )
            ),
          ],
        ),
        SizedBox(height: 24,),
        Text(
          'Дата начала:',
          textAlign: TextAlign.start,
          style: TextStyle(
            fontFamily: 'Rubik',
            fontWeight: FontWeight.w300,
            fontSize: 14,
            height: (18/14),
            letterSpacing: 0,
            color: Color(0xFF404040)
          ),
        ),
        SizedBox(height: 8,),
        DatePickerField(
          key: _datePickerKey1,
          onChanged: dateChanged1
        ),
        SizedBox(height: 16,),
        Text(
          'Дата окончания:',
          textAlign: TextAlign.start,
          style: TextStyle(
            fontFamily: 'Rubik',
            fontWeight: FontWeight.w300,
            fontSize: 14,
            height: (18/14),
            letterSpacing: 0,
            color: Color(0xFF404040)
          ),
        ),
        SizedBox(height: 8,),
        DatePickerField(
          key: _datePickerKey2,
          onChanged: dateChanged2
        ),
        SizedBox(height: 16,),
        TextButton(
          onPressed: () {
            if (backgroundColorButton == Color(0xFF4DABEE)) {
              widget.findInfo([
                _datePickerValue1!,
                _datePickerValue2!
              ]);
            }
          },
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
            minimumSize: Size(342, 44),
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          child: AnimatedContainer(
            duration: Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            width: 342,
            height: 44,
            padding: EdgeInsets.only(top: 12, bottom: 12),
            decoration: BoxDecoration(
              color: backgroundColorButton,
              borderRadius: BorderRadius.circular(10)
            ),
            child: Text(
              'Найти',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Rubik',
                fontWeight: FontWeight.w400,
                fontSize: 16,
                height: (20/16),
                letterSpacing: 0,
                color: Colors.white
              ),
            ),
          ),
        )
      ]
    );
    
  }
}
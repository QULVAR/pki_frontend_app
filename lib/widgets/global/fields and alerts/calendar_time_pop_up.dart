import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../scripts/resizer.dart';
import '../../../scripts/text_styles.dart';


class CalendarTimePopUp extends StatefulWidget {
  final DateTime startTime;
  final DateTime selectedDate;
  final Function selectedTime;
  CalendarTimePopUp({
    super.key,
    required this.selectedTime,
    required this.selectedDate,
    DateTime? time
  }): startTime = time ?? DateTime.now();

  @override
  CalendarTimePopUpState createState() => CalendarTimePopUpState();
}

class CalendarTimePopUpState extends State<CalendarTimePopUp> {
  
  String _hours = '09';
  String _minutes = '41';

  DateTime maximumDate = DateTime(2000, 1, 1, 23, 59);
  DateTime minimumDate = DateTime(2000, 1, 1, 0, 0);

  @override
  void initState() {
    super.initState();
    final formattedValue = getFormattedTime(widget.startTime);
    _hours = formattedValue[0];
    _minutes = formattedValue[1];
  }

  List<String> getFormattedTime(DateTime value) {
    String hours = '${value.hour}';
    String minutes = '${value.minute}';
    hours = hours.length == 1 ? '0$hours' : hours;
    minutes = minutes.length == 1 ? '0$minutes' : minutes;
    widget.selectedTime(value);
    return [hours, minutes];
  }

  @override
  Widget build(BuildContext context) {
    final nowDate = DateTime.now();
    if ((widget.selectedDate.year == nowDate.year)
      && (widget.selectedDate.month == nowDate.month)
      && (widget.selectedDate.day == nowDate.day)) {
        maximumDate = DateTime(2000, 1, 1, nowDate.hour, nowDate.minute);
      }
    return Container(
      width: 86.w,
      height: 36.h,
      margin: EdgeInsets.zero,
      padding: EdgeInsets.only(top: 5.h, bottom: 3.h),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Color(0xFFEDF7FD),
        borderRadius: BorderRadius.circular(6.sp)
      ),
      child: TextButton(
        style: ButtonStyle(
          padding: WidgetStateProperty.all(EdgeInsets.zero),
          minimumSize: WidgetStateProperty.all(Size.zero),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          alignment: Alignment.center,
          overlayColor: WidgetStateProperty.all(Colors.transparent),
          splashFactory: NoSplash.splashFactory,
          enableFeedback: false,
        ),
        onPressed: () {
          showCupertinoModalPopup<void>(
            context: context,
            barrierColor: Colors.black.withValues(alpha: 0.2),
            builder: (BuildContext context) => Container(
              height: 216.h,
              padding: EdgeInsets.only(top: 6.h),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.sp),
                color: Color(0xFFF5F5F5),
              ),
              child: SafeArea(
                top: false,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 358.w,
                        height: 216.h,
                        child: CupertinoDatePicker(
                          mode: CupertinoDatePickerMode.time,
                          initialDateTime: DateTime(2000, 1, 1, int.parse(_hours), int.parse(_minutes)),
                          use24hFormat: true,
                          minimumDate: minimumDate,
                          maximumDate: maximumDate,
                          onDateTimeChanged: (DateTime value) {
                            final formattedValue = getFormattedTime(value);
                            setState(() {
                              _hours = formattedValue[0];
                              _minutes = formattedValue[1];
                            });
                          }
                        )
                      )
                    ]
                  ),
                ),
              ),
            ),
          );
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              _hours,
              textAlign: TextAlign.right,
              style: AppText.calendarTimePopUp,
            ),
            SizedBox(width: 3.h,),
            Text(
              ':',
              textAlign: TextAlign.right,
              style: AppText.calendarTimePopUp,
            ),
            SizedBox(width: 5.w,),
            Text(
              _minutes,
              textAlign: TextAlign.right,
              style: AppText.calendarTimePopUp,
            ),
          ],
        )
      )
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pki_frontend_app/main.dart';

import '../global/fields and alerts/date_picker_field.dart';
import '../global/fields and alerts/calendar_pop_up.dart';


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
  Color fieldColor = Color(0xFFF5F5F5);
  String calendarIcon = 'calendar_icon';

  void showDateRange(List<DateTime> dateRange) {
    _datePickerKey1.currentState?.showPickedDate(dateRange[0]);
    _datePickerKey2.currentState?.showPickedDate(dateRange[1]);
  }

  void clear() {
    setState(() {
      _datePickerKey1.currentState?.clear();
      _datePickerKey2.currentState?.clear();
      _datePickerValue1 = null;
      _datePickerValue2 = null;
      backgroundColorButton = Color(0xFFE6E6E6);
      fieldColor = Color(0xFFF5F5F5);
      calendarIcon = 'calendar_icon';
    });
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
    final Color fieldColorLocal;
    if (_datePickerValue1 != null && _datePickerValue2 != null && _datePickerValue1!.isBefore(_datePickerValue2!)) {
      fieldColorLocal = Color(0xFFEDF7FD);
      buttonColor = Color(0xFF4DABEE);
      calendarIcon = 'calendar_icon_blue';
    } else {
      buttonColor = Color(0xFFE6E6E6);
      fieldColorLocal = Color(0xFFF5F5F5);
      calendarIcon = 'calendar_icon';
    }
    if (buttonColor != backgroundColorButton) {
      setState(() {
        backgroundColorButton = buttonColor;
        fieldColor = fieldColorLocal;
      });
    }
  }

  void _pickDate() {
  showGeneralDialog(
    context: context,
    barrierColor: Colors.black.withValues(alpha: 0.2),
    barrierDismissible: true,
    barrierLabel: "Закрыть", 
    transitionDuration: const Duration(milliseconds: 300),
    pageBuilder: (context, _, __) {
      return Align(
        alignment: Alignment.bottomCenter,
        child: DatePickerCalendar(
          mode: 'range',
          selectedDateRange: [
            _datePickerKey1.currentState?.selectedDate,
            _datePickerKey2.currentState?.selectedDate
          ],
          showDateRange: showDateRange,
        ),
      );
    },
    transitionBuilder: (context, animation, _, child) {
      final curved = CurvedAnimation(parent: animation, curve: Curves.easeOutCubic);
      return SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0, 1),
          end: Offset.zero,
        ).animate(curved),
        child: FadeTransition(opacity: curved, child: child),
      );
    },
  );
}

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Поиск по датам',
          textAlign: TextAlign.start,
          style: TextStyle(
            fontFamily: 'Rubik',
            fontWeight: FontWeight.w400,
            fontSize: 20.sp,
            height: 1,
            letterSpacing: 0,
            color: Color(0xFF404040)
          ),
        ),
        SizedBox(height: 24.h,),
        Text(
          'Выберите отрезок',
          textAlign: TextAlign.start,
          style: TextStyle(
            fontFamily: 'Rubik',
            fontWeight: FontWeight.w300,
            fontSize: 14.sp,
            height: (18/14),
            letterSpacing: 0,
            color: Color(0xFF404040)
          ),
        ),
        SizedBox(height: 8.h,),
        AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          padding: EdgeInsets.only(top: 12.h, bottom: 12.h, right: 14.w),
          height: 48.h,
          width: 342.w,
          decoration: BoxDecoration(
            color: fieldColor,
            borderRadius: BorderRadius.circular(12.sp),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                width: 304.w,
                height: 48.h,
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    DatePickerField(
                      key: _datePickerKey1,
                      onChanged: dateChanged1,
                      right: true,
                    ),Text(
                      ' - ',
                      style: TextStyle(
                        fontFamily: 'Rubik',
                        fontWeight: FontWeight.w400,
                        fontSize: 16.sp,
                        height: (20/16),
                        letterSpacing: 0,
                        color: Color(0xFF404040)
                      ),
                    ),
                    DatePickerField(
                      key: _datePickerKey2,
                      onChanged: dateChanged2,
                      right: false,
                    ),
                  ]
                ),
              ),
              SizedBox(
                width: 24.sp,
                height: 24.sp,
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: _pickDate,
                  child: SvgPicture.asset(
                    'assets/icons/$calendarIcon.svg',
                    width: 24.sp,
                    height: 24.sp,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 16.h,),
        TextButton(
          onPressed: () {
            if (backgroundColorButton == Color(0xFF4DABEE)) {
              FocusScope.of(context).unfocus();
              widget.findInfo([
                _datePickerValue1!,
                _datePickerValue2!
              ]);
            }
          },
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
            minimumSize: Size(342.w, 44.h),
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          child: AnimatedContainer(
            duration: Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            width: 342.w,
            height: 44.h,
            padding: EdgeInsets.only(top: 12.h, bottom: 12.h),
            decoration: BoxDecoration(
              color: backgroundColorButton,
              borderRadius: BorderRadius.circular(10.sp)
            ),
            child: Text(
              'Найти',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Rubik',
                fontWeight: FontWeight.w400,
                fontSize: 16.sp,
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
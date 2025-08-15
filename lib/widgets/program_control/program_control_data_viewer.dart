import 'package:flutter/material.dart';
import 'package:pki_frontend_app/main.dart';
import 'program_control_numbers_generator.dart';


class ProgramControlDataViewer extends StatefulWidget {
  final bool isEmptyControlData;
  final Map<String, List<Map<String, dynamic>>> dataByDescription;
  final String dropDownButtonValue;
  const ProgramControlDataViewer({
    super.key,
    required this.isEmptyControlData,
    required this.dataByDescription,
    required this.dropDownButtonValue
  });

  @override
  ProgramControlDataViewerState createState() => ProgramControlDataViewerState();
}

class ProgramControlDataViewerState extends State<ProgramControlDataViewer> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Container(
              width: 253.w,
              height: 26.h,
              padding: EdgeInsets.only(top: 4.h, left: 4.w, bottom: 8.h),
              child: Text(
                'Номер телефона',
                style: TextStyle(
                  fontFamily: 'Rubik',
                  fontWeight: FontWeight.w300,
                  fontSize: 12.sp,
                  height: 1,
                  letterSpacing: 0,
                  color: Color(0xFF404040)
                ),
              ),
            ),
            SizedBox(
              height: 26.h,
              width: 1,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: Color(0xFFF2F2F2)
                )
              ),
            ),
            Container(
              width: 87.w,
              height: 26.h,
              padding: EdgeInsets.only(top: 4.h, left: 4.w, bottom: 8.h, right: 4.w),
              child: Text(
                'Статус',
                style: TextStyle(
                  fontFamily: 'Rubik',
                  fontWeight: FontWeight.w300,
                  fontSize: 12.sp,
                  height: 1,
                  letterSpacing: 0,
                  color: Color(0xFF404040)
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
        Column(
          children: widget.isEmptyControlData
          ? [
              Container(
                width: 342.w,
                height: 42.h,
                padding: EdgeInsets.only(top: 4.h, left: 4.w, bottom: 4.h, right: 4.w),
                child: Text(
                  'Нет данных',
                  style: TextStyle(
                    fontFamily: 'Rubik',
                    fontWeight: FontWeight.w400,
                    fontSize: 16.sp,
                    height: 1,
                    letterSpacing: 0,
                    color: Color(0xFF404040)
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ]
          : [
            ProgramControlNumbersGenerator(
              isEmptyControlData: widget.isEmptyControlData,
              dataByDescription: widget.dataByDescription,
              dropDownButtonValue: widget.dropDownButtonValue
            )
          ],
        )
      ],
    );
  }
}
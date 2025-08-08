import 'package:flutter/material.dart';
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
      children: widget.isEmptyControlData
      ? [
          Container(
            width: 342,
            height: 42,
            padding: EdgeInsets.only(top: 4, left: 4, bottom: 4, right: 4),
            child: Text(
              'Нет данных',
              style: TextStyle(
                fontFamily: 'Rubik',
                fontWeight: FontWeight.w400,
                fontSize: 16,
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
    );
  }
}
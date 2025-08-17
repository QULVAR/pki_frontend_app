import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import '../../../scripts/text_styles.dart';
import '../../scripts/formatting.dart';
import '../../../scripts/resizer.dart';


class ProgramControlNumbersGenerator extends StatefulWidget {
  final bool isEmptyControlData;
  final Map<String, List<Map<String, dynamic>>> dataByDescription;
  final String dropDownButtonValue;
  const ProgramControlNumbersGenerator({
    super.key,
    required this.isEmptyControlData,
    required this.dataByDescription,
    required this.dropDownButtonValue
  });

  @override
  ProgramControlNumbersGeneratorState createState() => ProgramControlNumbersGeneratorState();
}

class ProgramControlNumbersGeneratorState extends State<ProgramControlNumbersGenerator> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: widget.dataByDescription[widget.dropDownButtonValue]!.map<Widget>((user) {

        final Color backgroundColorNumber = user['isOn']
                                            ? Color(0xFFF8FCFF)
                                            : Colors.white;
        
        return Row(
          children: [
            AnimatedContainer(
              duration: Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              key: ValueKey("${user['phoneNumber']}1"),
              decoration: BoxDecoration(
                color: backgroundColorNumber
              ),
              width: 253.w,
              height: 46.h,
              padding: EdgeInsets.only(top: 13.5.h, left: 4.w, bottom: 13.5.h),
              child: Text(
                phoneFormat(user['phoneNumber']),
                style: context.dropDownButtonItem(Color(0xFF404040)),
              ),
            ),
            SizedBox(
              height: 46.h,
              width: 1,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: Color(0xFFF2F2F2)
                )
              ),
            ),
            AnimatedContainer(
              duration: Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              key: ValueKey("${user['phoneNumber']}2"),
              decoration: BoxDecoration(
                color: backgroundColorNumber
              ),
              width: 87.w,
              height: 46.h,
              padding: EdgeInsets.only(top: 8.h, left: 18.5.w, bottom: 8.h, right: 18.5.w),
              child: CupertinoSwitch(
                value: user['isOn'],
                activeTrackColor: Color(0xFF4DABEE),
                onChanged: (val) {
                  setState(() {
                    user['isOn'] = val;
                    // ignore: avoid_print
                    print("UPDATE NUMBERS isOn = $val WHERE phoneNumber = '${user['phoneNumber']}'");
                  });
                },
              ),
            ),
          ],
        );
      }).toList()
    );
  }
}
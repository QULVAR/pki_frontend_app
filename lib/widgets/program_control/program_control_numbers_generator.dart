import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import '../../scripts/formatting.dart';


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
              width: 253,
              height: 46,
              padding: EdgeInsets.only(top: 13.5, left: 4, bottom: 13.5),
              child: Text(
                phoneFormat(user['phoneNumber']),
                style: TextStyle(
                  fontFamily: 'Rubik',
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                  height: 1,
                  letterSpacing: 0,
                  color: Color(0xFF404040)
                ),
              ),
            ),
            SizedBox(
              height: 46,
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
              width: 88,
              height: 46,
              padding: EdgeInsets.only(top: 8, left: 18.5, bottom: 8, right: 18.5),
              child: CupertinoSwitch(
                value: user['isOn'],
                activeTrackColor: Color(0xFF4DABEE),
                onChanged: (val) {
                  setState(() {
                    user['isOn'] = val;
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
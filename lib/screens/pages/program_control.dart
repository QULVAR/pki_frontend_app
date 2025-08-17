import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import '../../scripts/resizer.dart';

import '../../widgets/program_control/program_control_form.dart';
import '../../widgets/program_control/program_control_data_viewer.dart';
import '../../scripts/json_reader.dart';



class ProgramControlPage extends StatefulWidget {

  const ProgramControlPage({super.key});

  @override
  State<ProgramControlPage> createState() => ProgramControlPageState();
}

class ProgramControlPageState extends State<ProgramControlPage> {
  Map<String, List<Map<String, dynamic>>> dataByDescription = {};
  final ScrollController _scrollController = ScrollController();
  final _programControlFormKey = GlobalKey<ProgramControlFormState>();
  String _dropDownButtonValue = '';
  bool _isEmptyControlData = true;
  double _sizedBoxMarginBottom = 16;
  double _animatedPositionedHeight = 38;
  late double _left;
  double _height = 0;
  bool _animate = true;

  void moveToX(double left) {
    setState(() {
      _left = left;
      _animate = true;
    });
  }

  void moveToXWithoutAnimation(double left) {
    setState(() {
      _animate = false;
      _left = left;
    });
  }

  void clear() {
    _programControlFormKey.currentState?.clear();
    setState(() {
      dataByDescription = {};
    });
  }

  void _onSelectedChanged(String? program) {
    setState(() {
      _dropDownButtonValue = program ?? '';
      loadControlData();
      getParameters();
    });
  }
  
  void loadControlData() {
    const String fileName = 'assets/test_data/control_data.json';
    rootBundle.loadString(fileName).then((jsonString) {
      setState(() {
        dataByDescription = readJsonControlData(jsonString);
      });
    }).catchError((err) {
      setState(() {
        dataByDescription = {};
      });
    });
  }

  @override
  void initState() {
    super.initState();
    loadControlData();
    getParameters();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _left = MediaQuery.of(context).size.width;
  }

  void getParameters() {
    _isEmptyControlData = dataByDescription.isEmpty
                             || dataByDescription[_dropDownButtonValue] == null
                             || dataByDescription[_dropDownButtonValue]!.isEmpty;
    
    _height = !(_isEmptyControlData)
    ? (225.h + dataByDescription[_dropDownButtonValue]!.length * 46.h).toDouble()
    : 225.h + 38.h;

    _sizedBoxMarginBottom = _height <= 623.h
    ? 16.h
    : _height - 623.h;

    _animatedPositionedHeight = _height <= 623.h
    ? _height + 32.h
    : _height;
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      duration: Duration(milliseconds: _animate ? 300 : 0),
      curve: Curves.easeInOutCirc,
      top: 0,
      left: _left.w,
      width: 390.w,
      height: _animatedPositionedHeight,
      child: SingleChildScrollView(
        controller: _scrollController,
        padding: EdgeInsets.only(right: 12.w, left: 12.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              child: Container(
                margin: EdgeInsets.only(top: 16.h, bottom: _sizedBoxMarginBottom),
                padding: EdgeInsets.only(top: 11.h, right: 12.w, left: 12.w),
                height: _height,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(6.sp),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ProgramControlForm(
                      key: _programControlFormKey,
                      onSelectedChanged: _onSelectedChanged
                    ),
                    SizedBox(height: 24.h),
                    SizedBox(
                      height: 1,
                      width: 342.w,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: Color(0xFFF2F2F2)
                        )
                      ),
                    ),
                    SizedBox(height: 24.h,),
                    ProgramControlDataViewer(
                      isEmptyControlData: _isEmptyControlData,
                      dataByDescription: dataByDescription,
                      dropDownButtonValue: _dropDownButtonValue
                    )
                  ],
                )
              ),
            ),
          ],
        ),
      ),
    );
  }
}
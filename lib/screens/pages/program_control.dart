import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

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
      print('Error loading $fileName: $err');
      setState(() {
        dataByDescription = {};
      });
    });
  }

  void moveToX(double left) {
    setState(() => _left = left);
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
    ? (225 + dataByDescription[_dropDownButtonValue]!.length * 46).toDouble()
    : 225 + 38;

    _sizedBoxMarginBottom = _height <= 623
    ? 16
    : _height - 623;

    _animatedPositionedHeight = _height <= 623
    ? _height + 32
    : _height;
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOutCirc,
      top: 0,
      left: _left,
      width: 390,
      height: _animatedPositionedHeight,
      child: SingleChildScrollView(
        controller: _scrollController,
        padding: EdgeInsets.only(right: 12, left: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              child: Container(
                margin: EdgeInsets.only(top: 16, bottom: _sizedBoxMarginBottom),
                padding: EdgeInsets.only(top: 12, right: 12, left: 12),
                height: _height,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ProgramControlForm(
                      key: _programControlFormKey,
                      onSelectedChanged: _onSelectedChanged
                    ),
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
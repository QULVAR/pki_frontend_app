import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:pki_frontend_app/main.dart';

import '../../widgets/statistics/statistics_form.dart';
import '../../widgets/statistics/statistics_data_viewer.dart';
import '../../scripts/json_reader.dart';


class StatisticsPage extends StatefulWidget {

  const StatisticsPage({super.key});

  @override
  State<StatisticsPage> createState() => StatisticsPageState();
}

class StatisticsPageState extends State<StatisticsPage> {
  final _statisticsPageFormKey = GlobalKey<StatisticsPageFormState>();
  late double _left;
  Map<String, dynamic> data = {};
  bool _animate = true;
  bool flag = true;

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
    _statisticsPageFormKey.currentState?.clear();
    setState(() {
      data = {};
    });
  }

  void findInfo(List<DateTime> values) {
    print(values[0]);
    print(values[1]);
    setState(() {
      loadTransactionData();
    });
  }

  void loadTransactionData() {
    const String fileName = 'assets/test_data/statistics.json';

    rootBundle.loadString(fileName).then((jsonString) {
      setState(() {
        data = readJsonStatistics(jsonString);
      });
    }).catchError((err) {
      setState(() {
        data = {};
      });
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (flag) {
      _left = MediaQuery.of(context).size.width;
      flag = false;
    }
  }


  @override
  Widget build(BuildContext contextVt) {
    return AnimatedPositioned(
      duration: Duration(milliseconds: _animate ? 300 : 0),
      curve: Curves.easeInOutCirc,
      top: 0,
      left: _left.w,
      child: Container(
        height: 607.h,
        width: 366.w,
        padding: EdgeInsets.only(top: 12.h, bottom: 12.h, left: 12.w, right: 12.w),
        margin: EdgeInsets.only(top: 16.h, right: 12.w, left: 12.w, bottom: 16.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(6.sp)
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            StatisticsPageForm(
              key: _statisticsPageFormKey,
              findInfo: findInfo
            ),
            SizedBox(height: 9.h,),
            SizedBox(
              height: 1,
              width: 342.w,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: Color(0xFFF2F2F2)
                )
              ),
            ),
            SizedBox(height: 9.h,),
            StatisticsDataViewer(data: data,)
          ],
        ),
      )
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

import '../../widgets/statistics/statistics_form.dart';
import '../../widgets/statistics/statistics_data_viewer.dart';
import '../../scripts/json_reader.dart';


class StatisticsPage extends StatefulWidget {

  const StatisticsPage({super.key});

  @override
  State<StatisticsPage> createState() => StatisticsPageState();
}

class StatisticsPageState extends State<StatisticsPage> {
  late double _left;
  double _top = 0;
  Map<String, dynamic> data = {};

  void moveToX(double left) {
    setState(() => _left = left);
  }

  void moveToY(double top) {
    setState(() => _top = top);
  }

  void findInfo(List<DateTime> values) {
    print(values[0]);
    print(values[1]);
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
  void initState() {
    super.initState();
    loadTransactionData();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _left = MediaQuery.of(context).size.width;
  }


  @override
  Widget build(BuildContext contextVt) {
    return AnimatedPositioned(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOutCirc,
        top: _top,
        left: _left,
        child: Container(
          height: 607,
          width: 366,
          padding: EdgeInsets.all(12),
          margin: EdgeInsets.only(top: 16, right: 12, left: 12, bottom: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(6)
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              StatisticsPageForm(findInfo: findInfo),
              SizedBox(height: 24,),
              SizedBox(
                height: 1,
                width: 342,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: Color(0xFFF2F2F2)
                  )
                ),
              ),
              SizedBox(height: 24,),
              StatisticsDataViewer(data: data,)
            ],
          ),
        )
    );
  }
}
import 'package:flutter/material.dart';


class StatisticsPage extends StatefulWidget {

  const StatisticsPage({super.key});

  @override
  State<StatisticsPage> createState() => StatisticsPageState();
}

class StatisticsPageState extends State<StatisticsPage> {
  late double _left;
  double _top = 0;

  void moveToX(double left) {
    setState(() => _left = left);
  }

  void moveToY(double top) {
    setState(() => _top = top);
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
        child: Text("Стастистика")
    );
  }
}
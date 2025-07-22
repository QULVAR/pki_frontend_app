import 'package:flutter/material.dart';

import '../../../widgets/add_program_form.dart';
import '../../../widgets/how_it_works.dart';


class AddProgramPage extends StatefulWidget {
  const AddProgramPage({super.key});

  @override
  State<AddProgramPage> createState() => AddProgramPageState();
}

class AddProgramPageState extends State<AddProgramPage> {
  double _left = 0;
  int i = 0;
  late double _top;

  void moveToX(double left) {
    setState(() => _left = left);
  }

  void moveToY(double top) {
    setState(() => _top = top);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _top = MediaQuery.of(context).size.height;
  }

  void _onSubmit () {
    print("It's work!");
  }

  @override
  Widget build(BuildContext contextVt) {
    return AnimatedPositioned(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOutCirc,
      top: _top,
      left: _left,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            AddProgramForm(onSubmit: _onSubmit),
            SizedBox(height: 32,),
            HowItWorksWidget()
          ],
        ),
      )
    );
  }
}
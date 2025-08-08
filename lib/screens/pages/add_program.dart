import 'package:flutter/material.dart';

import '../../widgets/add_program/add_program_form.dart';
import '../../widgets/add_program/how_it_works.dart';
import '../../widgets/add_program/dialog_add_program.dart';
import '../../widgets/global/fields and alerts/phone_input.dart';
import '../../widgets/global/fields and alerts/drop_down_button.dart';



class AddProgramPage extends StatefulWidget {
  const AddProgramPage({super.key});

  @override
  State<AddProgramPage> createState() => AddProgramPageState();
}

class AddProgramPageState extends State<AddProgramPage> {
  final _phoneKey = GlobalKey<PhoneInputWidgetState>();
  final _dropdownKey = GlobalKey<DropDownButtonState>();
  double _left = 0;

  void moveToX(double left) {
    setState(() => _left = left);
  }

  void _onSubmit () {
    showSuccessDialog(context, _resetForm);
    _phoneKey.currentState?.clear();
    _dropdownKey.currentState?.clear();
  }

  void _resetForm() {
    _phoneKey.currentState?.clear();
    _dropdownKey.currentState?.clear();
    setState((){});
  }

  @override
  Widget build(BuildContext contextVt) {
    return AnimatedPositioned(
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOutQuint,
      top: 0,
      left: _left,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            AddProgramForm(onSubmit: _onSubmit, phoneKey: _phoneKey, dropDownButtonKey: _dropdownKey,),
            SizedBox(height: 32,),
            HowItWorksWidget()
          ],
        ),
      )
    );
  }
}
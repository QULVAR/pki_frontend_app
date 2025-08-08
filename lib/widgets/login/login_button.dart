import 'package:flutter/material.dart';


Widget getButton (Function authorize, bool isValid, String email, String password) {
  return AnimatedContainer(
    duration: Duration(milliseconds: 300),
    curve: Curves.easeInOut,
    child:TextButton(
      onPressed: () => isValid ? authorize(email, password) : null,
      style: TextButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        fixedSize: Size(342, 48),
        backgroundColor: isValid ? Color(0xFF4DABEE) : Color(0xFFE6E6E6),
        shadowColor: Colors.transparent,
      ),
      child: Text(
        'Войти',
        style: TextStyle(
          fontFamily: 'Rubik',
          fontWeight: FontWeight.w400,
          fontSize: 16,
          fontStyle: FontStyle.normal,
          height: 1.25,
          letterSpacing: 0.0,
          color: Colors.white,
        ),
        textAlign: TextAlign.start,
      )
    )
  );
}
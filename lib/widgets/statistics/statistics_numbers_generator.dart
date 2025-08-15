import 'package:flutter/material.dart';
import 'package:pki_frontend_app/main.dart';

import '../../scripts/formatting.dart';

List<Widget> getNumbersFromData(Map<String, dynamic> data, bool flagInput, List<Color> backgroundColorNumber) {
  bool flag = flagInput;
  return data['getAllTransactionsWithDiscount']['transactionStatByCustomer']!.map<Widget>((user) {
    flag = !flag;
    return Row(
      children: [
        AnimatedContainer(
          duration: Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          key: ValueKey("${user['phoneNumber']}1"),
          decoration: BoxDecoration(
            color: backgroundColorNumber[flag ? 0 : 1]
          ),
          width: 130.w,
          height: 30.h,
          padding: EdgeInsets.only(top: 8.h, left: 4.w, bottom: 11.h),
          child: Text(
            phoneFormat(user['phoneNumber']),
            style: TextStyle(
              fontFamily: 'Rubik',
              fontWeight: FontWeight.w400,
              fontSize: 12.sp,
              height: 1,
              letterSpacing: 0,
              color: Color(0xFF404040)
            ),
          ),
        ),
        SizedBox(
          height: 30.h,
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
          key: ValueKey(user['stat']['allConsumptionWh']),
          decoration: BoxDecoration(
            color: backgroundColorNumber[flag ? 0 : 1]
          ),
          width: 122.w,
          height: 30.h,
          padding: EdgeInsets.only(top: 8.h, bottom: 8.h),
          child: Center(
            child: Text(
              numbersFormat(user['stat']['allConsumptionWh'].toDouble()),
              style: TextStyle(
                fontFamily: 'Rubik',
                fontWeight: FontWeight.w400,
                fontSize: 12.sp,
                height: 1,
                letterSpacing: 0,
                color: Color(0xFF404040)
              ),
            ),
          ),
        ),
        SizedBox(
          height: 30.h,
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
          key: ValueKey(user['stat']['allPrice']),
          decoration: BoxDecoration(
            color: backgroundColorNumber[flag ? 0 : 1]
          ),
          width: 87.w,
          height: 30.h,
          padding: EdgeInsets.only(top: 8.h, bottom: 8.h),
          child: Center(
            child: Text(
              '₽ ${numbersFormat(user['stat']['allPrice'].toDouble())}',
              style: TextStyle(
                fontFamily: 'Rubik',
                fontWeight: FontWeight.w400,
                fontSize: 12.sp,
                height: 1,
                letterSpacing: 0,
                color: Color(0xFF404040)
              ),
            ),
          ),
        ),
      ],
    );
  }).toList();
}
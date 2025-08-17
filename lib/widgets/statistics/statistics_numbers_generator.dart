import 'package:flutter/material.dart';

import '../../../scripts/text_styles.dart';
import '../../scripts/formatting.dart';
import '../../../scripts/resizer.dart';


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
            style: AppText.statisticsNumberGeneratorFields,
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
              style: AppText.statisticsNumberGeneratorFields
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
              style: AppText.statisticsNumberGeneratorFields
            ),
          ),
        ),
      ],
    );
  }).toList();
}
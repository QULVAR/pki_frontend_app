import 'package:flutter/material.dart';
import 'package:pki_frontend_app/main.dart';

import '../../scripts/formatting.dart';
import 'statistics_numbers_generator.dart';


class StatisticsDataViewer extends StatefulWidget {
  final Map<String, dynamic> data;
  const StatisticsDataViewer({
    super.key,
    Map<String, dynamic>? data
  }): data = data ?? const {};
  @override
  State<StatisticsDataViewer> createState() => StatisticsDataViewerState();
}

class StatisticsDataViewerState extends State<StatisticsDataViewer> {
  List<Color> backgroundColorNumber = [Color(0xFFF8FCFF), Colors.white];
  bool flag = false;
  double _height = 0;
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    if (widget.data.isEmpty) {
      _height = 270;
    }
    else {
      _height = (widget.data['getAllTransactionsWithDiscount']['transactionStatByCustomer'].length * 30).toDouble();
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Данные о пользователях',
          textAlign: TextAlign.start,
          style: TextStyle(
            fontFamily: 'Rubik',
            fontWeight: FontWeight.w400,
            fontSize: 16.sp,
            height: (20/16),
            letterSpacing: 0,
            color: Color(0xFF404040)
          ),
        ),
        SizedBox(height: 24.h,),
        Row(
          children: [
            Container(
              width: 130.w,
              height: 40.h,
              padding: EdgeInsets.only(top: 4.h, left: 4.w, bottom: 22.h),
              child: Text(
                'Номер',
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontFamily: 'Rubik',
                  fontWeight: FontWeight.w300,
                  fontSize: 12.sp,
                  height: 1,
                  letterSpacing: 0,
                  color: Color(0xFF404040)
                ),
              ),
            ),
            SizedBox(
              width: 1,
              height: 40.h,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: Color(0xFFF2F2F2)
                )
              ),
            ),
            Container(
              width: 122.w,
              height: 40.h,
              padding: EdgeInsets.only(top: 4.h, left: 4.w, bottom: 8.h, right: 3.w),
              child: Text(
                'Общее потребление энергии, кВт⋅ч',
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontFamily: 'Rubik',
                  fontWeight: FontWeight.w300,
                  fontSize: 12.sp,
                  height: 1,
                  letterSpacing: 0,
                  color: Color(0xFF404040)
                ),
              ),
            ),
            SizedBox(
              width: 1,
              height: 40.h,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: Color(0xFFF2F2F2)
                )
              ),
            ),
            Container(
              width: 87.w,
              height: 40.h,
              padding: EdgeInsets.only(top: 4.h, left: 4.w, bottom: 8.h, right: 4.w),
              child: Text(
                'Общая стоимость',
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontFamily: 'Rubik',
                  fontWeight: FontWeight.w300,
                  fontSize: 12.sp,
                  height: 1,
                  letterSpacing: 0,
                  color: Color(0xFF404040)
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          width: 342.w,
          height: 270.h,
          child: SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  child: Container(
                    height: _height.h,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(6.sp),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: widget.data.isEmpty
                      ? [
                        Container(
                          width: 342.w,
                          height: 30.h,
                          padding: EdgeInsets.only(top: 4.h, left: 4.w, bottom: 4.h, right: 4.w),
                          child: Text(
                            'Нет данных',
                            style: TextStyle(
                              fontFamily: 'Rubik',
                              fontWeight: FontWeight.w400,
                              fontSize: 16.sp,
                              height: 1,
                              letterSpacing: 0,
                              color: Color(0xFF404040)
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        SizedBox(height: 240.h,)
                      ]
                      : getNumbersFromData(widget.data, flag, backgroundColorNumber)
                    )
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          width: 342.w,
          height: 1,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: Color(0xFFF2F2F2)
            )
          ),
        ),
        Row(
          children: [
            Container(
              width: 130.w,
              height: 29.h,
              decoration: BoxDecoration(
                color: widget.data.isNotEmpty
                      ? backgroundColorNumber[flag ? 0 : 1]
                      : backgroundColorNumber[1]
              ),
              padding: EdgeInsets.only(top: 7.h, left: 4.w, bottom: 8.h),
              child: Text(
                'Итого',
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontFamily: 'Rubik',
                  fontWeight: FontWeight.w500,
                  fontSize: 12.sp,
                  height: 1,
                  letterSpacing: 0,
                  color: Color(0xFF404040)
                ),
              ),
            ),
            SizedBox(
              width: 1,
              height: 29.h,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: Color(0xFFF2F2F2)
                )
              ),
            ),
            Container(
              width: 122.w,
              height: 29.h,
              decoration: BoxDecoration(
                color: widget.data.isNotEmpty
                      ? backgroundColorNumber[flag ? 0 : 1]
                      : backgroundColorNumber[1]
              ),
              padding: EdgeInsets.only(top: 3.h, left: 4.w, bottom: 8.h, right: 3.w),
              child: Center(
                child: Text(
                  widget.data.isEmpty ? numbersFormat(0)
                  : numbersFormat(widget.data['getAllTransactionsWithDiscount']['allConsumptionWh'].toDouble()),
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontFamily: 'Rubik',
                    fontWeight: FontWeight.w500,
                    fontSize: 12.sp,
                    height: 1,
                    letterSpacing: 0,
                    color: Color(0xFF404040)
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 1,
              height: 29.h,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: Color(0xFFF2F2F2)
                )
              ),
            ),
            Container(
              width: 87.w,
              height: 29.h,
              decoration: BoxDecoration(
                color: widget.data.isNotEmpty
                      ? backgroundColorNumber[flag ? 0 : 1]
                      : backgroundColorNumber[1]
              ),
              padding: EdgeInsets.only(top: 3.h, left: 4.w, bottom: 8.h, right: 4.w),
              child: Center(
                child: Text(
                  widget.data.isEmpty ? '₽ ${numbersFormat(0)}'
                  : '₽ ${numbersFormat(widget.data['getAllTransactionsWithDiscount']['allPrice'].toDouble())}',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontFamily: 'Rubik',
                    fontWeight: FontWeight.w500,
                    fontSize: 12.sp,
                    height: 1,
                    letterSpacing: 0,
                    color: Color(0xFF404040)
                  ),
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}
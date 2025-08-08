import 'package:flutter/material.dart';

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
  bool flag = true;
  double _height = 0;
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    if (widget.data.isEmpty) {
      _height = 150;
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
            fontSize: 16,
            height: (20/16),
            letterSpacing: 0,
            color: Color(0xFF404040)
          ),
        ),
        SizedBox(height: 24,),
        Row(
          children: [
            Container(
              width: 130,
              height: 40,
              padding: EdgeInsets.only(top: 4, left: 4, bottom: 22),
              child: Text(
                'Номер',
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontFamily: 'Rubik',
                  fontWeight: FontWeight.w300,
                  fontSize: 12,
                  height: 1,
                  letterSpacing: 0,
                  color: Color(0xFF404040)
                ),
              ),
            ),
            SizedBox(
              width: 1,
              height: 40,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: Color(0xFFF2F2F2)
                )
              ),
            ),
            Container(
              width: 122,
              height: 40,
              padding: EdgeInsets.only(top: 4, left: 4, bottom: 8, right: 3),
              child: Text(
                'Общее потребление энергии, кВт⋅ч',
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontFamily: 'Rubik',
                  fontWeight: FontWeight.w300,
                  fontSize: 12,
                  height: 1,
                  letterSpacing: 0,
                  color: Color(0xFF404040)
                ),
              ),
            ),
            SizedBox(
              width: 1,
              height: 40,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: Color(0xFFF2F2F2)
                )
              ),
            ),
            Container(
              width: 88,
              height: 40,
              padding: EdgeInsets.only(top: 4, left: 4, bottom: 8, right: 4),
              child: Text(
                'Общая стоимость',
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontFamily: 'Rubik',
                  fontWeight: FontWeight.w300,
                  fontSize: 12,
                  height: 1,
                  letterSpacing: 0,
                  color: Color(0xFF404040)
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          width: 342,
          height: 150,
          child: SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  child: Container(
                    height: _height,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: widget.data.isEmpty
                      ? [
                        Container(
                          width: 342,
                          height: 30,
                          padding: EdgeInsets.only(top: 4, left: 4, bottom: 4, right: 4),
                          child: Text(
                            'Нет данных',
                            style: TextStyle(
                              fontFamily: 'Rubik',
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                              height: 1,
                              letterSpacing: 0,
                              color: Color(0xFF404040)
                            ),
                            textAlign: TextAlign.center,
                          ),
                        )
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
          width: 342,
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
              width: 130,
              height: 29,
              decoration: BoxDecoration(
                color: backgroundColorNumber[flag ? 1 : 0]
              ),
              padding: EdgeInsets.only(top: 7, left: 4, bottom: 8),
              child: Text(
                'Итого',
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontFamily: 'Rubik',
                  fontWeight: FontWeight.w500,
                  fontSize: 12,
                  height: 1,
                  letterSpacing: 0,
                  color: Color(0xFF404040)
                ),
              ),
            ),
            SizedBox(
              width: 1,
              height: 29,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: Color(0xFFF2F2F2)
                )
              ),
            ),
            Container(
              width: 122,
              height: 29,
              decoration: BoxDecoration(
                color: backgroundColorNumber[flag ? 1 : 0]
              ),
              padding: EdgeInsets.only(top: 3, left: 4, bottom: 8, right: 3),
              child: Center(
                child: Text(
                  widget.data.isEmpty ? numbersFormat(0)
                  : numbersFormat(widget.data['getAllTransactionsWithDiscount']['allConsumptionWh'].toDouble()),
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontFamily: 'Rubik',
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                    height: 1,
                    letterSpacing: 0,
                    color: Color(0xFF404040)
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 1,
              height: 29,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: Color(0xFFF2F2F2)
                )
              ),
            ),
            Container(
              width: 88,
              height: 29,
              decoration: BoxDecoration(
                color: backgroundColorNumber[flag ? 1 : 0]
              ),
              padding: EdgeInsets.only(top: 3, left: 4, bottom: 8, right: 4),
              child: Center(
                child: Text(
                  widget.data.isEmpty ? '₽ ${numbersFormat(0)}'
                  : '₽ ${numbersFormat(widget.data['getAllTransactionsWithDiscount']['allPrice'].toDouble())}',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontFamily: 'Rubik',
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
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
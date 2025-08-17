import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../scripts/resizer.dart';
import '../../scripts/text_styles.dart';


class HowItWorksWidget extends StatefulWidget {
  const HowItWorksWidget({super.key});

  @override
  State<HowItWorksWidget> createState() => _HowItWorksWidgetState();
}

class _HowItWorksWidgetState extends State<HowItWorksWidget>
    with TickerProviderStateMixin {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOutCirc,
      width: 366.w,
      height: _expanded ? 202.h : 44.h,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(_expanded ? 8.sp : 6.sp),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: () => setState(() => _expanded = !_expanded),
          borderRadius: BorderRadius.circular(_expanded ? 8.sp : 6.sp),
          child: Padding(
            padding: EdgeInsets.only(left: 12.w, right: 8.w, top: 10.h, bottom: 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Как это работает?',
                      style: context.menuBody16W400(Color(0xFF3E4E5E)),
                    ),
                    SvgPicture.asset(
                      _expanded ? "assets/icons/arrow_up.svg" : "assets/icons/arrow_down.svg",
                      key: ValueKey(_expanded),
                      width: 24.sp,
                      height: 24.sp,
                    ),
                  ],
                ),
                SizedBox(height: 6.h),
                Expanded(
                  child: ClipRect(
                    child: AnimatedOpacity(
                      duration: Duration(milliseconds: 200),
                      opacity: _expanded ? 1.0 : 0.0,
                      child: _expanded
                          ? SingleChildScrollView(
                              physics: NeverScrollableScrollPhysics(),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 17.h),
                                  Text(
                                    "Внесение данных по номеру телефона",
                                    style: AppText.addProgramHowItWorksH1,
                                  ),
                                  SizedBox(height: 9.h),
                                  Text(
                                    "Для добавления программы пользователю, введите его номер телефона в указанное текстовое поле.",
                                    style: context.addProgramHowItWorksText(1.222),
                                  ),
                                  SizedBox(height: 21.h),
                                  Text(
                                    "Выбор программы",
                                    style: AppText.addProgramHowItWorksH1,
                                  ),
                                  SizedBox(height: 9.h),
                                  Text(
                                    "В выпадающем списке выберите программу, которую необходимо применить к выбранному пользователю.",
                                    style: context.addProgramHowItWorksText(1.15),
                                  ),
                                ],
                              ),
                            )
                          : const SizedBox.shrink(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
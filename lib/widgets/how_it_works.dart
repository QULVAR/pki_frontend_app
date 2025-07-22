import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


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
      width: 366,
      height: _expanded ? 202 : 44,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(_expanded ? 8 : 6),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: () => setState(() => _expanded = !_expanded),
          borderRadius: BorderRadius.circular(_expanded ? 8 : 6),
          child: Padding(
            padding: const EdgeInsets.only(left: 12, right: 8, top: 10, bottom: 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Как это работает?',
                      style: TextStyle(
                        fontFamily: 'Rubik',
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                        height: 1.25,
                        color: Color(0xFF3E4E5E),
                      ),
                    ),
                    SvgPicture.asset(
                      _expanded ? "assets/icons/arrow_up.svg" : "assets/icons/arrow_down.svg",
                      key: ValueKey(_expanded),
                      width: 24,
                      height: 24,
                    ),
                  ],
                ),
                SizedBox(height: 6),
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
                                  SizedBox(height: 17),
                                  Text(
                                    "Внесение данных по номеру телефона",
                                    style: TextStyle(
                                      fontFamily: 'Rubik',
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14,
                                      height: (20 / 14),
                                      color: Color(0xFF3E4E5E),
                                    ),
                                  ),
                                  SizedBox(height: 9),
                                  Text(
                                    "Для добавления программы пользователю, введите его номер телефона в указанное текстовое поле.",
                                    style: TextStyle(
                                      fontFamily: 'Rubik',
                                      fontWeight: FontWeight.w300,
                                      fontSize: 12,
                                      height: 1.122,
                                      color: Color(0xFF777777),
                                    ),
                                  ),
                                  SizedBox(height: 21),
                                  Text(
                                    "Выбор программы",
                                    style: TextStyle(
                                      fontFamily: 'Rubik',
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14,
                                      height: (20 / 14),
                                      color: Color(0xFF3E4E5E),
                                    ),
                                  ),
                                  SizedBox(height: 9),
                                  Text(
                                    "В выпадающем списке выберите программу, которую необходимо применить к выбранному пользователю.",
                                    style: TextStyle(
                                      fontFamily: 'Rubik',
                                      fontWeight: FontWeight.w300,
                                      fontSize: 12,
                                      height: 1.15,
                                      color: Color(0xFF777777),
                                    ),
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
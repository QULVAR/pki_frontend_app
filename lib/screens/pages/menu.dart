import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../widgets/menu/menu_show_dialog.dart';


class MenuPage extends StatefulWidget {
  final VoidCallback logout;

  const MenuPage({super.key, required this.logout});

  @override
  State<MenuPage> createState() => MenuPageState();
}

class MenuPageState extends State<MenuPage> {
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
        child: Container(
          width: 366,
          height: 599,
          margin: EdgeInsets.only(top: 16, bottom: 24, right: 12, left: 12),
          padding: EdgeInsets.only(top: 16, left: 16, right: 16, bottom: 0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8)
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: SvgPicture.asset(
                  "assets/icons/pki_ul_logo_menu.svg",
                  width: 260,
                  height: 52,
                ),
              ),
              SizedBox(height: 12),
              Center(
                child:Text(
                  'Личный кабинет для юр. лиц',
                  style: TextStyle(
                    fontFamily: 'Rubik',
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                    height: (20/16),
                    letterSpacing: 0,
                    color: Color(0xFF777777)
                  )
                )
              ),
              SizedBox(height: 24),
              Center(
                child: ColoredBox(
                  color: Color(0xFFF2F2F2),
                  child: SizedBox(
                    width: 334,
                    height: 1,
                  )
                ),
              ),
              SizedBox(height: 24,),
              Text(
                'ООО «ПКИ»',
                style: TextStyle(
                  fontFamily: 'Rubik',
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                  height: (20/16),
                  letterSpacing: 0,
                  color: Color(0xFF777777),
                ),
              ),
              SizedBox(height: 12),
              Text(
                '№ 296-ДХ от 11.09.2023',
                style: TextStyle(
                  fontFamily: 'Rubik',
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                  height: (20/16),
                  letterSpacing: 0,
                  color: Color(0xFF777777),
                ),
              ),
              SizedBox(height: 307,),
              Text(
                'Версия: 2.0',
                style: TextStyle(
                  fontFamily: 'Rubik',
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  height: 1,
                  letterSpacing: 0,
                  color: Color(0xFF404040),
                ),
              ),
              SizedBox(height: 16,),
              TextButton(
                onPressed: () => showLogoutConfirm(context, widget.logout),
                style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(135),
                  ),
                  minimumSize: Size(336, 42),
                  backgroundColor: Color(0xFFF5F5F5),
                  shadowColor: Colors.transparent,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Выйти',
                      style: TextStyle(
                        fontFamily: 'Rubik',
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                        fontStyle: FontStyle.normal,
                        height: (20/16),
                        letterSpacing: 0.0,
                        color: Color(0xFF3E4E5E),
                      ),
                    ),
                    SizedBox(width: 10),
                    SvgPicture.asset(
                      'assets/icons/exit.svg',
                      width: 17,
                      height: 16,
                    ),
                  ],
                ),
              ),
            ],
          ),
        )
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../scripts/resizer.dart';
import '../../scripts/text_styles.dart';

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
  bool _animate = true;

  void moveToX(double left) {
    setState(() {
      _left = left;
      _animate = true;
    });
  }

  void moveToXWithoutAnimation(double left) {
    setState(() {
      _animate = false;
      _left = left;
    });
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
      duration: Duration(milliseconds: _animate ? 300 : 0),
        curve: Curves.easeInOutCirc,
        top: _top.h,
        left: _left.w,
        child: Container(
          width: 366.w,
          height: 599.h,
          margin: EdgeInsets.only(top: 16.h, bottom: 24.h, right: 12.w, left: 12.w),
          padding: EdgeInsets.only(top: 16.h, left: 16.w, right: 16.w, bottom: 0.h),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.sp)
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: SvgPicture.asset(
                  "assets/icons/pki_ul_logo_menu.svg",
                  width: 260.sp,
                  height: 52.sp,
                ),
              ),
              SizedBox(height: 12.h),
              Center(
                child:Text(
                  'Личный кабинет для юр. лиц',
                  style: AppText.menuBody16W400
                )
              ),
              SizedBox(height: 24.h),
              Center(
                child: ColoredBox(
                  color: Color(0xFFF2F2F2),
                  child: SizedBox(
                    width: 334.w,
                    height: 1,
                  )
                ),
              ),
              SizedBox(height: 24.h,),
              Text(
                'ООО «ПКИ»',
                style: AppText.menuBody16W400,
              ),
              SizedBox(height: 12.h),
              Text(
                '№ 296-ДХ от 11.09.2023',
                style: AppText.menuBody16W400
              ),
              SizedBox(height: 307.h,),
              Text(
                'Версия: 2.0',
                style: AppText.menuBody14W400
              ),
              SizedBox(height: 16.h,),
              TextButton(
                onPressed: () => showLogoutConfirm(context, widget.logout),
                style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(135),
                  ),
                  minimumSize: Size(336.w, 42.h),
                  backgroundColor: Color(0xFFF5F5F5),
                  shadowColor: Colors.transparent,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Выйти',
                      style: context.menuBody16W400(Color(0xFF3E4E5E)),
                    ),
                    SizedBox(width: 10.w),
                    SvgPicture.asset(
                      'assets/icons/exit.svg',
                      width: 17.sp,
                      height: 16.sp,
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
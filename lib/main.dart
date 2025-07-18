import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:flutter_svg/flutter_svg.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(95, 255, 255, 255)),
      ),
      home: const MyHomePage(title: 'Добавление программы'),
    );
  }
}



class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}


class _MyHomePageState extends State<MyHomePage> {
  Color _fieldColor = Color(0xFFF5F5F5);
  Color _dropdownColor = Color(0xFFF5F5F5);
  String _phoneIcon = "assets/icons/phone.svg";

  final TextEditingController _phoneController = TextEditingController();
  final _phoneFormatter = MaskTextInputFormatter(
    mask: '+7 (###) ###-##-##',
    filter: { "#": RegExp(r'\d') },
  );

  final List<String> _programs = [
    'Заряд 80',
    'Тариф ООО «ПКИ»',
    'Заряд 120',
  ];

  String? _selectedProgram;


  @override
  void initState() {
    super.initState();
    _phoneController.addListener(() {
      final digitsOnly = _phoneFormatter.getUnmaskedText();
      if (digitsOnly.length == 10) {
        setState(() {
          _fieldColor = Color(0xFFEDF7FD);
          _phoneIcon = "assets/icons/phone_blue.svg";
        });
      } else {
        setState(() {
          _fieldColor = Color(0xFFF5F5F5);
          _phoneIcon = "assets/icons/phone.svg";
        });
      }
    });
  }

    @override
    void dispose() {
      _phoneController.dispose();
      super.dispose();
    }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    
    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          widget.title,
          style: const TextStyle(
            fontFamily: 'Rubik',
            fontWeight: FontWeight.w400,
            fontStyle: FontStyle.normal,
            fontSize: 20
          ),
        ),
        toolbarHeight: 54,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              width: 366,
              height: 256,
              margin: EdgeInsets.only(top: 16, right: 12, left: 12, bottom: 36),
              padding: EdgeInsets.only(top: 12, right: 12, left: 12, bottom: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(6),
              ),
              child:
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Добавление пользователя в\u00A0программу',
                    style: const TextStyle(
                      fontFamily: 'Rubik',
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.normal,
                      fontSize: 20,
                      height: 1,
                      letterSpacing: 0.0,
                    ),
                    textAlign: TextAlign.start,
                  ),
                  SizedBox(height: 26),
                  Text(
                    'Введите номер телефона:',
                    style: const TextStyle(
                      fontFamily: 'Rubik',
                      fontWeight: FontWeight.w300,
                      fontSize: 14,
                      height: 1.0,
                      letterSpacing: 0.0,
                    ),
                    textAlign: TextAlign.start,
                  ),
                  SizedBox(height: 8),
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 300), // ← тут задаётся плавность
                    curve: Curves.easeInOut, // можно поменять на другую анимацию
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      color: _fieldColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: TextField(
                      keyboardType: TextInputType.phone,
                      controller: _phoneController,
                      inputFormatters: [_phoneFormatter],
                      decoration: InputDecoration(
                        icon: LayoutBuilder(
                          builder: (context, constraints) {
                            return AnimatedSwitcher(
                              duration: Duration(milliseconds: 300),
                              child: SvgPicture.asset(
                                _phoneIcon,
                                key: ValueKey(_phoneIcon),
                                width: 24,
                                height: 24,
                              ),
                            );
                          },
                        ),
                        border: InputBorder.none,
                        hintText: '+7 (___) ___-__-__',
                        hintStyle: TextStyle(
                          fontFamily: 'Rubik',
                          fontWeight: FontWeight.w300,
                          fontSize: 16,
                          color: Color.fromARGB(255, 167, 167, 167),
                          letterSpacing: 0.0
                        ),
                      ),
                      style: TextStyle(
                        fontFamily: 'Rubik',
                        fontSize: 16,
                      ),
                    ),
                  ),
                  const SizedBox(height: 18),
                  Text(
                    'Выберите программу:',
                    style: const TextStyle(
                      fontFamily: 'Rubik',
                      fontWeight: FontWeight.w300,
                      fontSize: 14,
                      height: 1.0,
                      letterSpacing: 0.0,
                    ),
                    textAlign: TextAlign.start,
                  ),
                  SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      color: _dropdownColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        isExpanded: true,
                        value: _selectedProgram,
                        hint: const Text(
                          'Выбрать программу',
                          style: TextStyle(
                            fontFamily: 'Rubik',
                            fontWeight: FontWeight.w300,
                            fontSize: 16,
                            color: Color.fromARGB(255, 167, 167, 167),
                          ),
                        ),
                        icon: const Icon(Icons.keyboard_arrow_down),
                        items: _programs.map((program) {
                          return DropdownMenuItem<String>(
                            value: program,
                            child: Text(
                              program,
                              style: const TextStyle(
                                fontFamily: 'Rubik',
                                fontSize: 16,
                              ),
                            ),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            _selectedProgram = value;
                            _dropdownColor = Color(0xFFEDF7FD);
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      //footer widgets
    );
  }
}

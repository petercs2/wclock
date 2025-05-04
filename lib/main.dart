import 'package:circle_clock/pages/circle_main/circle_main_binding.dart';
import 'package:circle_clock/pages/circle_main/circle_main_view.dart';
import 'package:circle_clock/pages/circle_query/circle_query_binding.dart';
import 'package:circle_clock/pages/circle_query/circle_query_view.dart';
import 'package:circle_clock/pages/circle_setting/circle_setting_binding.dart';
import 'package:circle_clock/pages/circle_setting/circle_setting_check.dart';
import 'package:circle_clock/pages/circle_setting/circle_setting_view.dart';
import 'package:circle_clock/pages/local_net/local_net_binding.dart';
import 'package:circle_clock/pages/local_net/local_net_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

Color primaryColor = Colors.black;
Color bgColor = Colors.black;

List<List<Color>> graList = const [
  [Color(0xff240c84), Color(0xff5412b2)],
  [Color(0xff842c0c), Color(0xffb25612)],
  [Color(0xff6d840c), Color(0xffa0b212)],
  [Color(0xff0c8428), Color(0xff62b212)],
  [Color(0xff0c4d84), Color(0xff1287b2)],
  [Color(0xff5a0c84), Color(0xffac12b2)],
  [Color(0xff840c7f), Color(0xffb21281)],
  [Color(0xff840c36), Color(0xffb21268)],
  [Color(0xff840c0c), Color(0xffb21212)],
  [Color(0xff84720c), Color(0xffb29912)],
  [Color(0xff464646), Color(0xff6f6f6f)],
  [Color(0xff7b0c84), Color(0xff5412b2)],
  [Color(0xff840c0c), Color(0xffb2ac12)],
  [Color(0xff95ad0e), Color(0xff3db212)],
  [Color(0xff845f0c), Color(0xffb21299)],
];

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final colorType = prefs.getInt('colorType');
  if (colorType == null) {
    await prefs.setInt('colorType', 0);
    await prefs.setInt('dialType', 0);
    await prefs.setBool('time24', true);
    await prefs.setBool('fahrenheit', true);
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      getPages: Quick,
      initialRoute: '/',
      theme: ThemeData(
        useMaterial3: true,
        primaryColor: primaryColor,
        scaffoldBackgroundColor: bgColor,
        colorScheme: ColorScheme.light(
          primary: primaryColor,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          scrolledUnderElevation: 0,
          centerTitle: true,
          titleTextStyle: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontSize: 20,
          ),
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          selectedItemColor: primaryColor,
          selectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
          elevation: 0,
          backgroundColor: Colors.white,
        ),
        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
        ),
        cardTheme: const CardTheme(
          color: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
        ),
        dialogTheme: const DialogTheme(
          actionsPadding: EdgeInsets.only(right: 10, bottom: 5),
        ),
        dividerTheme: DividerThemeData(
          thickness: 1,
          color: Colors.grey[200],
        ),
      ),
    );
  }
}
List<GetPage<dynamic>> Quick = [
  GetPage(name: '/', page: () => const CircleQueryView(), binding: CircleQueryBinding()),
  GetPage(name: '/circleMain', page: () => const CircleMainPage(), binding: CircleMainBinding()),
  GetPage(name: '/circleSetting', page: () => CircleSettingPage(), binding: CircleSettingBinding()),
  GetPage(name: '/circleCheck', page: () => const CircleSettingCheck()),
  GetPage(name: '/localNet', page: () => const LocalNetView(), binding: LocalNetBinding()),
];
import 'package:flutter/cupertino.dart';
import 'package:mental_health_app/views/screens/main_screens/account_screens/setting_screen.dart';
import 'package:mental_health_app/views/screens/main_screens/doctor_screens/schedule_screen.dart';
import 'package:mental_health_app/views/screens/main_screens/home_screen.dart';
import 'package:mental_health_app/views/screens/main_screens/meditate_screens/meditate_screen.dart';
import 'package:mental_health_app/views/screens/main_screens/musics_screens/musics_screen.dart';

const Map<int, String> gendersDatas = {0: 'male', 1: 'female'};
const Map<int, String> ageDatas = {
  0: '14 - 17',
  1: '18 - 24',
  2: '25 - 29',
  3: '30 - 34',
  4: '35 - 39',
  5: '40 - 44',
  6: '45 - 49',
  7: '≥ 50',
};
const List<Map> goalDatas = [
  {'id': 0, 'title': 'Stress Reduction'},
  {'id': 1, 'title': 'Better Sleep'},
  {'id': 2, 'title': 'Improved Focus & Concentration'},
  {'id': 3, 'title': 'Increased Self-Awareness'}
];
const List<Map> timedatas = [
  {'id': 0, 'title': ' Less than 15 minutes / day'},
  {'id': 1, 'title': ' Between 15-30 minutes / day'},
  {'id': 2, 'title': ' Between 30-60 minutes / day'},
  {'id': 3, 'title': ' More than 60 minutes / day'},
  {'id': 4, 'title': " I haven't decided yet"},
];

const List<Widget> pages = [
  HomeScreen(),
  MeditateScreen(),
  MusicsScreen(),
  SettingsScreen()
];

const List<Widget> doctorPages = [ScheduleScreen(), SettingsScreen()];

const kprimaryColor = Color(0xff212C42);
const ksecondryColor = Color(0xff9CA2FF);
const ksecondryLightColor = Color(0xffEDEFFE);
const klightContentColor = Color(0xffF1F2F7);

const double kbigFontSize = 25;
const double knormalFontSize = 18;
const double ksmallFontSize = 15;

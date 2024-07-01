import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:nanny_organizer/adapter/hive_adapter.dart';
import 'package:nanny_organizer/client/hive_names.dart';
import 'package:nanny_organizer/database/database.dart';
import 'package:nanny_organizer/onboarding/onboarding_widget.dart';
import 'package:nanny_organizer/screens/screens.dart';
import 'package:shared_preferences/shared_preferences.dart';

int? initScreen;
void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(ScheduleDBAdapter());
  await Hive.openBox<ScheduleDB>(HiveBoxes.schedule);
  Hive.registerAdapter(DiaryDBAdapter());
  await Hive.openBox<DiaryDB>(HiveBoxes.diary);
  Hive.registerAdapter(InstructionsDBAdapter());
  await Hive.openBox<InstructionsDB>(HiveBoxes.instructions);
  Hive.registerAdapter(ContactDBAdapter());
  await Hive.openBox<ContactDB>(HiveBoxes.contact);
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  initScreen = await prefs.getInt("initScreen");
  await prefs.setInt("initScreen", 1);
  scheduleBox.values.forEach(
    (element) {
      if (DateTime.now().day - element.dateTime!.day == 7) {
        element.delete();
      }
    },
  );

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: <LocalizationsDelegate<Object>>[
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('ru', 'RU'),
        const Locale('en', 'US'),
      ],
      home: initScreen == 0 || initScreen == null ? OnboardingWidget() : Screens(),
    );
  }
}

import 'package:hive_flutter/adapters.dart';
import 'package:nanny_organizer/adapter/hive_adapter.dart';

import '../client/hive_names.dart';

final diaryBox = Hive.box<DiaryDB>(HiveBoxes.diary);
final scheduleBox = Hive.box<ScheduleDB>(HiveBoxes.schedule);
final instructionsBox = Hive.box<InstructionsDB>(HiveBoxes.instructions);
final contactBox = Hive.box<ContactDB>(HiveBoxes.contact);
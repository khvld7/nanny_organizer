import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
part 'hive_adapter.g.dart';

@HiveType(typeId: 0)
class ScheduleDB extends HiveObject {
  @HiveField(0)
  DateTime? dateTime;
  @HiveField(1)
  String? name;
  @HiveField(2)
  int? id;
  @HiveField(3)
  String? discriptions;
  @HiveField(4)
  DateTime? time;
  @HiveField(5)
  bool isSelect;

  ScheduleDB({
    this.dateTime,
    this.name,
    this.id,
    this.discriptions,
    this.time,
    this.isSelect = false,
  });
}

@HiveType(typeId: 1)
class DiaryDB extends HiveObject {
  @HiveField(0)
  DateTime? dateTime;
  @HiveField(1)
  String? name;
  @HiveField(2)
  String? category;
  @HiveField(3)
  String? note;
  @HiveField(4)
  int? id;

  DiaryDB({
    this.id,
    this.dateTime,
    this.name,
    this.category,
    this.note,
  });
}

@HiveType(typeId: 2)
class InstructionsDB extends HiveObject {
  @HiveField(0)
  Uint8List? image;
  @HiveField(1)
  String? title;
  @HiveField(2)
  String? text;

  InstructionsDB({
    this.image,
    this.title,
    this.text,
  });
}

@HiveType(typeId: 3)
class ContactDB extends HiveObject {
  @HiveField(0)
  String? name;
  @HiveField(1)
  bool? isFavourite;
  @HiveField(2)
  String? number;

  ContactDB({
    this.name,
    this.number,
    this.isFavourite = false,
  });
}

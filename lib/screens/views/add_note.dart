import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:nanny_organizer/adapter/hive_adapter.dart';
import 'package:nanny_organizer/components/calendar_custom.dart';
import 'package:nanny_organizer/components/custom_button.dart';
import 'package:nanny_organizer/components/custom_textfield.dart';
import 'package:nanny_organizer/components/style.dart';
import 'package:nanny_organizer/database/database.dart';
import 'package:nanny_organizer/globals.dart';

class AddNote extends StatefulWidget {
  const AddNote({super.key});

  @override
  State<AddNote> createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  TextEditingController dateController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  TextEditingController noteController = TextEditingController();

  List<String> items = ['Тема записи', 'Новая категория', 'Здоровье', 'Учеба', 'Спорт', 'Досуг'];

  addDiary() {
    diaryBox.add(
      DiaryDB(
        id: diaryBox.length,
        dateTime: date,
        name: nameController.text,
        category: '#' + categoryController.text,
        note: noteController.text,
      ),
    );
  }

  @override
  void initState() {
    if (mounted) {
      nameController.addListener(() {
        setState(() {});
      });
      dateController.addListener(() {
        setState(() {});
      });
      categoryController.addListener(() {
        setState(() {});
      });
      noteController.addListener(() {
        setState(() {});
      });
    }

    super.initState();
  }

  String? _time;
  Map<String, List<DiaryDB>> monthCard = {};

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          'assets/images/launch.png',
          height: double.infinity,
          width: double.infinity,
          fit: BoxFit.fill,
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            shape: RoundedRectangleBorder(
              side: BorderSide(
                color: Color.fromRGBO(188, 188, 227, 1),
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            leadingWidth: 40,
            leading: Container(
              padding: EdgeInsets.only(left: 16),
              child: CustomButton(
                onPressed: () => Navigator.pop(context),
                child: SvgPicture.asset('assets/icons/back.svg'),
              ),
            ),
            title: Row(
              children: [
                Text(
                  'Добавление записи',
                  style: appBarSubtitle,
                ),
              ],
            ),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
          floatingActionButton: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              children: [
                Expanded(
                  child: CustomButton(
                    isActive: nameController.text.isNotEmpty &&
                            dateController.text.isNotEmpty &&
                            categoryController.text.isNotEmpty &&
                            noteController.text.isNotEmpty
                        ? true
                        : false,
                    borderRadius: BorderRadius.circular(16),
                    border: nameController.text.isNotEmpty &&
                            dateController.text.isNotEmpty &&
                            categoryController.text.isNotEmpty &&
                            noteController.text.isNotEmpty
                        ? null
                        : Border.all(color: Color.fromRGBO(188, 188, 227, 1)),
                    onPressed: () {
                      addDiary();
                      Navigator.pop(context);
                    },
                    child: Text(
                      'Сохранить',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Prata',
                        color: nameController.text.isNotEmpty &&
                                dateController.text.isNotEmpty &&
                                categoryController.text.isNotEmpty &&
                                noteController.text.isNotEmpty
                            ? Color.fromRGBO(12, 22, 84, 1)
                            : Color.fromRGBO(188, 188, 227, 1),
                      ),
                    ),
                    color: nameController.text.isNotEmpty &&
                            dateController.text.isNotEmpty &&
                            categoryController.text.isNotEmpty &&
                            noteController.text.isNotEmpty
                        ? Color.fromRGBO(88, 255, 227, 1)
                        : Color.fromRGBO(241, 246, 255, 1),
                  ),
                ),
              ],
            ),
          ),
          body: ListView(
            padding: EdgeInsets.only(bottom: 80),
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                child: Column(
                  children: [
                    InkWell(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () => openCalendar(
                          context: context,
                          setState: () {
                            setState(() {
                              _time = DateFormat.yMMMMd('ru_RU').format(date);
                              dateController.text = _time ?? '';
                            });
                          }),
                      child: AbsorbPointer(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 12),
                          child: CustomTextfield(
                            readOnly: true,
                            hintText: 'Дата',
                            labelText: 'Дата',
                            controller: dateController,
                            suffixIcon: Padding(
                              padding: EdgeInsets.only(right: 16),
                              child: CustomButton(
                                height: 24,
                                width: 24,
                                child: SvgPicture.asset('assets/icons/calendar.svg'),
                              ),
                            ),
                            onChanged: (value) {},
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 12),
                      child: CustomTextfield(
                        textCapitalization: TextCapitalization.sentences,
                        controller: nameController,
                        hintText: 'Краткое название',
                        labelText: 'Название',
                        onChanged: (value) {},
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 12),
                      child: CustomTextfield(
                        controller: categoryController,
                        readOnly: true,
                        hintText: 'Категория записи',
                        labelText: 'Категория',
                        suffixIcon: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: InkWell(
                            child: DropdownButtonFormField(
                              decoration: InputDecoration.collapsed(
                                hintText: 'Категория записи',
                                hintStyle: TextStyle(
                                  color: Color.fromRGBO(188, 188, 227, 1),
                                  fontSize: 13,
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w200,
                                ),
                              ),
                              isExpanded: true,
                              borderRadius: BorderRadius.circular(16),
                              items: [
                                DropdownMenuItem(
                                  enabled: false,
                                  child: Text(
                                    items[0],
                                    style: TextStyle(
                                      color: Color.fromRGBO(114, 110, 255, 1),
                                      fontSize: 11,
                                      fontFamily: 'Roboto',
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  value: items[0],
                                ),
                                DropdownMenuItem(
                                  enabled: false,
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          items[1],
                                          style: TextStyle(
                                            color: Color.fromRGBO(188, 188, 227, 1),
                                            fontSize: 13,
                                            fontFamily: 'Roboto',
                                            fontWeight: FontWeight.w200,
                                          ),
                                        ),
                                      ),
                                      SvgPicture.asset('assets/icons/up.svg'),
                                    ],
                                  ),
                                  value: items[1],
                                ),
                                DropdownMenuItem(
                                  child: Text(items[2], style: dropFirst),
                                  value: items[2],
                                ),
                                DropdownMenuItem(
                                  child: Text(items[3], style: dropFirst),
                                  value: items[3],
                                ),
                                DropdownMenuItem(
                                  child: Text(items[4], style: dropFirst),
                                  value: items[4],
                                ),
                                DropdownMenuItem(
                                  child: Text(items[5], style: dropFirst),
                                  value: items[5],
                                ),
                              ],
                              onChanged: (value) => setState(() {
                                categoryController.text = value ?? '';
                              }),
                              iconSize: 24,
                              icon: SvgPicture.asset('assets/icons/down.svg'),
                            ),
                          ),
                        ),
                        onChanged: (value) {},
                      ),
                    ),
                    SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 12),
                        child: CustomTextfield(
                          textCapitalization: TextCapitalization.sentences,
                          maxLines: null,
                          controller: noteController,
                          hintText: 'Что вы хотите записать',
                          labelText: 'Запись',
                          onChanged: (value) {},
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

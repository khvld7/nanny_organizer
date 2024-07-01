import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:nanny_organizer/adapter/hive_adapter.dart';
import 'package:intl/intl.dart';
import 'package:nanny_organizer/components/card_widget.dart';
import 'package:nanny_organizer/components/category_custom.dart';
import 'package:nanny_organizer/components/custom_button.dart';
import 'package:nanny_organizer/database/database.dart';
import 'package:nanny_organizer/screens/views/add_note.dart';

class DiaryWidget extends StatefulWidget {
  const DiaryWidget({super.key});

  @override
  State<DiaryWidget> createState() => _DiaryWidgetState();
}

final colorBg = Color.fromRGBO(241, 246, 255, 1);
final styleText = TextStyle(
  color: Color.fromRGBO(188, 188, 227, 1),
  fontWeight: FontWeight.w400,
  fontSize: 12,
  fontFamily: 'Roboto',
);
final styleTextActive = TextStyle(
  color: Color.fromRGBO(12, 22, 84, 1),
  fontWeight: FontWeight.w400,
  fontSize: 12,
  fontFamily: 'Roboto',
);

class _DiaryWidgetState extends State<DiaryWidget> {
  List<CategoryCustom> category = [
    CategoryCustom(
      id: 0,
      text: 'Все',
      color: colorBg,
      textStyle: styleText,
    ),
    CategoryCustom(
      id: 1,
      text: '#Здоровье',
      color: colorBg,
      textStyle: styleText,
    ),
    CategoryCustom(
      id: 2,
      text: '#Учеба',
      color: colorBg,
      textStyle: styleText,
    ),
    CategoryCustom(
      id: 3,
      text: '#Спорт',
      color: colorBg,
      textStyle: styleText,
    ),
    CategoryCustom(
      id: 4,
      text: '#Досуг',
      color: colorBg,
      textStyle: styleText,
    ),
  ];

  List<DiaryDB> items = diaryBox.values.cast<DiaryDB>().toList();

  changeCategory(int categoryFiltred) {
    items.clear();
    if (categoryFiltred != 0) {
      diaryBox.values.forEach(
        (element) {
          if (element.category == category[categoryFiltred].text) {
            items.add(element);
          }
        },
      );
    } else {
      items = diaryBox.values.toList();
    }
    setState(() {});
  }

  @override
  void initState() {
    items.clear();
    changeCategory(0);
    category[0].isSelect = true;
    category[0].textStyle = styleTextActive;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 10),
        child: Row(
          children: [
            Expanded(
              child: CustomButton(
                borderRadius: BorderRadius.circular(16),
                onPressed: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) {
                        return AddNote();
                      },
                    ),
                  );
                  changeCategory(0);
                  category.forEach((element) {
                    element.isSelect = false;
                    element.textStyle = styleText;
                    category[0].isSelect = true;
                    category[0].textStyle = styleTextActive;
                  });
                },
                child: Text(
                  'Добавить запись',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Prata',
                    color: Color.fromRGBO(12, 22, 84, 1),
                  ),
                ),
                textColor: Color.fromRGBO(12, 22, 84, 1),
                color: Color.fromRGBO(88, 255, 227, 1),
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.transparent,
      body: diaryBox.isNotEmpty
          ? ListView(
              shrinkWrap: true,
              children: [
                Container(
                  height: 40,
                  child: ListView.builder(
                    keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                    shrinkWrap: true,
                    physics: ScrollPhysics(),
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 5),
                    scrollDirection: Axis.horizontal,
                    itemCount: category.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        highlightColor: Colors.transparent,
                        splashColor: Colors.transparent,
                        onTap: () => setState(() {
                          category.forEach((element) {
                            element.isSelect = false;
                            element.textStyle = styleText;
                          });
                          category[index].isSelect = true;
                          category[index].isSelect == true ? category[index].textStyle = styleTextActive : styleText;
                          changeCategory(category[index].id!);
                        }),
                        child: category[index].build(context),
                      );
                    },
                  ),
                ),
                ValueListenableBuilder(
                  valueListenable: diaryBox.listenable(),
                  builder: (BuildContext context, Box<DiaryDB> diaryBox, Widget? child) {
                    items.sort((a, b) => a.dateTime!.compareTo((b.dateTime!)));
                    Map<String, List<DiaryDB>> groupedItems = {};
                    for (var item in items) {
                      String date = DateFormat.yMMMMd('ru_RU').format(item.dateTime!).toString();
                      if (!groupedItems.containsKey(date)) {
                        groupedItems[date] = [];
                      }
                      groupedItems[date]?.add(item);
                    }
                    List<String> sortedDates = groupedItems.keys.toList();
                    return ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      physics: BouncingScrollPhysics(),
                      itemCount: sortedDates.length,
                      padding: EdgeInsets.only(top: 20, bottom: 100, left: 24, right: 24),
                      itemBuilder: (BuildContext context, int index) {
                        String dateDiary = sortedDates[index];
                        List<DiaryDB> itemsForDate = groupedItems[dateDiary]!;
                        return Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(bottom: 5),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    sortedDates[index],
                                    style: TextStyle(
                                      color: Color.fromRGBO(114, 110, 255, 1),
                                      fontWeight: FontWeight.w400,
                                      fontSize: 11,
                                      fontFamily: 'Roboto',
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            ...itemsForDate.map(
                              (items) => DiaryCardWidget(
                                delete: () {
                                  setState(() {
                                    diaryBox.values.forEach((element) {
                                      if (element == items) {
                                        element.delete();
                                      }
                                    });
                                    this.items.remove(items);
                                  });
                                },
                                category: items.category ?? '',
                                name: items.name ?? '',
                                note: items.note ?? '',
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },
                )
              ],
            )
          : Center(
              child: Text(
                'Дневник прогресса пуст.',
                style: TextStyle(
                  color: Color.fromRGBO(114, 110, 255, 1),
                  fontSize: 13,
                  fontWeight: FontWeight.w300,
                  fontFamily: 'Roboto',
                ),
              ),
            ),
    );
  }
}

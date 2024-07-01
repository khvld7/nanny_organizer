import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nanny_organizer/components/category_custom.dart';
import 'package:nanny_organizer/components/custom_button.dart';

class DiaryCardWidget extends StatelessWidget {
  final String name;
  final String note;
  final String category;
  final Function()? delete;

  const DiaryCardWidget({
    required this.category,
    required this.name,
    required this.note,
    this.delete,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    List<CategoryCustom> categoryId = [
      CategoryCustom(id: 1, text: '#Здоровье'),
      CategoryCustom(id: 2, text: '#Учеба'),
      CategoryCustom(id: 3, text: '#Спорт'),
      CategoryCustom(id: 4, text: '#Досуг'),
    ];
    return Stack(
      alignment: AlignmentDirectional(0.9, -1),
      children: [
        Container(
          margin: EdgeInsets.symmetric(vertical: 10),
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Color.fromRGBO(188, 188, 227, 1), width: 1),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      name,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Color.fromRGBO(12, 22, 84, 1),
                        fontSize: 15,
                        fontWeight: FontWeight.w300,
                        fontFamily: 'Roboto',
                      ),
                    ),
                  ),
                  PopupMenuButton(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    child: SvgPicture.asset(
                      'assets/icons/dots.svg',
                    ),
                    itemBuilder: (context) => [
                      PopupMenuItem(
                        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                        height: 30,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Редактировать',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w300,
                                fontFamily: 'Roboto',
                                color: Color.fromRGBO(12, 22, 84, 1),
                              ),
                            ),
                          ],
                        ),
                      ),
                      PopupMenuItem(
                        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                        height: 0.5,
                        enabled: false,
                        child: Divider(
                          height: 0.5,
                          color: Color.fromRGBO(225, 224, 224, 1),
                        ),
                      ),
                      PopupMenuItem(
                        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (_) => AlertDialog(
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                              alignment: Alignment.center,
                              surfaceTintColor: Colors.white,
                              contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                              actions: [
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    CustomButton(
                                      padding: EdgeInsets.symmetric(horizontal: 10),
                                      height: 35,
                                      textColor: Color.fromRGBO(12, 22, 84, 1),
                                      onPressed: () => Navigator.pop(context),
                                      child: Text(
                                        'Закрыть',
                                        style: TextStyle(
                                          fontFamily: 'Prata',
                                          fontSize: 13,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                    CustomButton(
                                      padding: EdgeInsets.symmetric(horizontal: 10),
                                      height: 35,
                                      borderRadius: BorderRadius.circular(16),
                                      color: Colors.red,
                                      onPressed: () {
                                        delete!();
                                        Navigator.pop(context);
                                      },
                                      child: Text(
                                        'Удалить',
                                        style: TextStyle(
                                          fontFamily: 'Prata',
                                          fontSize: 13,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                              title: Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Удалить',
                                      style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.w400,
                                        fontFamily: 'Prata',
                                        color: Colors.red,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: 10),
                                      child: Text(
                                        'Вы действительно хотите удалить рецепт?',
                                        style: TextStyle(
                                            fontSize: 14, fontWeight: FontWeight.w300, fontFamily: 'Roboto', color: Color.fromRGBO(12, 22, 84, 1)),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                        height: 30,
                        child: Text(
                          'Удалить',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w300,
                            fontFamily: 'Roboto',
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(top: 4),
                child: Row(
                  children: [
                    Text(
                      note,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Color.fromRGBO(138, 138, 177, 1),
                        fontSize: 13,
                        fontWeight: FontWeight.w300,
                        fontFamily: 'Roboto',
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        CategoryCustom(
          color: Color.fromRGBO(241, 246, 255, 1),
          text: category,
          height: 20,
          textStyle: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w300,
            fontFamily: 'Roboto',
            color: Color.fromRGBO(12, 22, 84, 1),
          ),
        ),
      ],
    );
  }
}

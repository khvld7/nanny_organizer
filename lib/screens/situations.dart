import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import 'package:nanny_organizer/adapter/hive_adapter.dart';
import 'package:nanny_organizer/components/custom_button.dart';
import 'package:nanny_organizer/database/database.dart';
import 'package:nanny_organizer/screens/views/add_instructions.dart';
import 'package:nanny_organizer/screens/views/add_number.dart';
import 'package:nanny_organizer/screens/views/danger_situations.dart';
import 'package:nanny_organizer/screens/views/instructions.dart';
import 'package:nanny_organizer/screens/views/numbers.dart';

class SituationsWidget extends StatefulWidget {
  const SituationsWidget({super.key});

  @override
  State<SituationsWidget> createState() => _SituationsWidgetState();
}

class _SituationsWidgetState extends State<SituationsWidget> {
  bool _isOpenFavourites = false;
  List<ContactDB> favourites = [];

  updateList() {
    favourites = contactBox.values.where((element) {
      return element.isFavourite == true;
    }).toList();
    setState(() {});
  }

  @override
  void initState() {
    updateList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.only(bottom: 20),
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              InkWell(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) {
                        return Numbers();
                      },
                    ),
                  );
                  updateList();
                },
                child: Container(
                  margin: EdgeInsets.only(top: 10),
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  decoration: BoxDecoration(color: Color.fromRGBO(114, 110, 255, 1), borderRadius: BorderRadius.circular(16)),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              'Телефонная книга',
                              style: TextStyle(
                                fontFamily: 'Prata',
                                fontWeight: FontWeight.w400,
                                fontSize: 18,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          CustomButton(
                            width: 24,
                            height: 24,
                            onPressed: () async {
                              await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (BuildContext context) {
                                    return AddNumber();
                                  },
                                ),
                              );
                              updateList();
                            },
                            child: SvgPicture.asset('assets/icons/add_number.svg'),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            contactBox.length % 10 == 2 || contactBox.length % 10 == 3 || contactBox.length % 10 == 4
                                ? '${contactBox.length} номера'
                                : '${contactBox.length} номеров',
                            style: TextStyle(
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w400,
                              fontSize: 13,
                              color: Color.fromRGBO(188, 188, 227, 1),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: ExpansionTile(
                              onExpansionChanged: (value) {
                                setState(() {
                                  _isOpenFavourites = !_isOpenFavourites;
                                });
                                updateList();
                              },
                              trailing: SizedBox.shrink(),
                              shape: Border.all(style: BorderStyle.none),
                              title: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    _isOpenFavourites ? 'Скрыть' : 'Избранное',
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w400,
                                      fontFamily: 'Roboto',
                                      color: _isOpenFavourites ? Color.fromRGBO(188, 188, 227, 1) : Color.fromRGBO(88, 255, 227, 1),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 10),
                                    child: SvgPicture.asset(_isOpenFavourites ? 'assets/icons/up.svg' : 'assets/icons/down.svg'),
                                  ),
                                ],
                              ),
                              children: [
                                Container(
                                  child: ListView.builder(
                                    itemCount: favourites.length,
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemBuilder: (BuildContext context, int index) {
                                      final favIndex = favourites[index];
                                      return Container(
                                        child: Row(
                                          children: [
                                            Container(
                                              width: 1,
                                              height: 30,
                                              color: Color.fromRGBO(88, 255, 227, 1),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 5),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    favIndex.name ?? '',
                                                    style: TextStyle(
                                                      fontSize: 15,
                                                      fontWeight: FontWeight.w500,
                                                      fontFamily: 'Roboto',
                                                      color: Color.fromRGBO(241, 246, 255, 1),
                                                    ),
                                                  ),
                                                  Text(
                                                    favIndex.number ?? '',
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      fontWeight: FontWeight.w300,
                                                      fontFamily: 'Roboto',
                                                      color: Color.fromRGBO(241, 246, 255, 1),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              InkWell(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) {
                        return Instructions();
                      },
                    ),
                  );
                  setState(() {});
                },
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  decoration: BoxDecoration(color: Color.fromRGBO(7, 198, 172, 1), borderRadius: BorderRadius.circular(16)),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                'Мои инструкции',
                                style: TextStyle(
                                  fontFamily: 'Prata',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 18,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            CustomButton(
                              width: 24,
                              height: 24,
                              onPressed: () async {
                                await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (BuildContext context) {
                                      return AddInstructions();
                                    },
                                  ),
                                );
                                setState(() {});
                              },
                              child: SvgPicture.asset('assets/icons/add_instructions.svg'),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            '${instructionsBox.length} инструкции',
                            style: TextStyle(
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w400,
                              fontSize: 13,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              InkWell(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () async {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) {
                        return DangerSituations();
                      },
                    ),
                  );
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: Color.fromRGBO(88, 255, 227, 1),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Image.asset(
                            fit: BoxFit.fitWidth,
                            'assets/images/situations.png',
                            width: double.infinity,
                          ),
                        ),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              'Опасные ситуации в жизни детей',
                              style: TextStyle(
                                fontFamily: 'Prata',
                                fontWeight: FontWeight.w400,
                                fontSize: 18,
                                color: Color.fromRGBO(12, 22, 84, 1),
                              ),
                            ),
                          ),
                          CustomButton(
                            width: 24,
                            height: 24,
                            child: SvgPicture.asset('assets/icons/chevron_right_situations.svg'),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                '5 опасных ситуаций, которые \nнеобходимо разъяснить ребенку.',
                                style: TextStyle(
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 13,
                                  color: Color.fromRGBO(138, 138, 177, 1),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

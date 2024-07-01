import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:nanny_organizer/adapter/hive_adapter.dart';
import 'package:nanny_organizer/components/custom_button.dart';
import 'package:nanny_organizer/components/custom_textfield.dart';
import 'package:nanny_organizer/components/style.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nanny_organizer/database/database.dart';

class Numbers extends StatefulWidget {
  const Numbers({super.key});

  @override
  State<Numbers> createState() => _NumbersState();
}

class _NumbersState extends State<Numbers> {
  TextEditingController searchController = TextEditingController();
  List<ContactDB> filtred = [];

  searchContact() {
    final query = searchController.text;
    if (query.isNotEmpty) {
      filtred = contactBox.values.where((element) {
        return element.name!.toLowerCase().contains(query.toLowerCase());
      }).toList();
    } else {
      filtred = contactBox.values.toList();
    }
    setState(() {});
  }

  @override
  void initState() {
    filtred = contactBox.values.toList();
    searchController.addListener(searchContact);
    super.initState();
  }

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
                  'Телефонная книга',
                  style: appBarSubtitle,
                ),
              ],
            ),
          ),
          body: contactBox.isNotEmpty
              ? Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: CustomTextfield(
                              controller: searchController,
                              hintText: 'Искать...',
                              paddingHorizontal: 0,
                              paddingVerical: 0,
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 10,
                                  color: Color.fromRGBO(160, 175, 175, 0.25),
                                )
                              ],
                              onChanged: (onChanged) {},
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 2,
                                  blurStyle: BlurStyle.normal,
                                  color: Color.fromRGBO(160, 175, 175, 0.25),
                                ),
                              ],
                              shape: BoxShape.circle,
                              color: Color.fromRGBO(88, 255, 227, 1),
                            ),
                            child: Center(
                              child: SvgPicture.asset(
                                'assets/icons/add_number.svg',
                                colorFilter: ColorFilter.mode(Color.fromRGBO(114, 110, 255, 1), BlendMode.srcIn),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        child: ValueListenableBuilder(
                          valueListenable: contactBox.listenable(),
                          builder: (context, value, child) => ListView.builder(
                            padding: EdgeInsets.symmetric(vertical: 24),
                            shrinkWrap: true,
                            itemCount: filtred.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Dismissible(
                                onDismissed: ((direction) {
                                  setState(() {
                                    filtred.removeAt(index);
                                    contactBox.deleteAt(index);
                                  });
                                }),
                                resizeDuration: Duration(milliseconds: 300),
                                direction: DismissDirection.endToStart,
                                background: Container(
                                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                                  margin: EdgeInsets.only(bottom: 20),
                                  decoration: ShapeDecoration(
                                    color: Color.fromRGBO(255, 59, 48, 1),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16.0),
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(right: 15),
                                        child: SvgPicture.asset(
                                          'assets/icons/trash.svg',
                                          colorFilter: ColorFilter.mode(
                                            Colors.white,
                                            BlendMode.srcIn,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                child: Container(
                                  margin: EdgeInsets.only(bottom: 20),
                                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(16),
                                    boxShadow: [
                                      BoxShadow(
                                        blurRadius: 10,
                                        color: Color.fromRGBO(160, 175, 175, 0.25),
                                      ),
                                      BoxShadow(
                                        blurStyle: BlurStyle.normal,
                                        offset: Offset(-1, 0),
                                        color: Color.fromRGBO(88, 255, 227, 1),
                                      ),
                                    ],
                                  ),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Column(
                                          children: [
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: Text(
                                                    '${filtred[index].name}',
                                                    style: TextStyle(
                                                      color: Color.fromRGBO(12, 22, 84, 1),
                                                      fontSize: 12,
                                                      fontWeight: FontWeight.w300,
                                                      fontFamily: 'Roboto',
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(top: 5),
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    child: Text(
                                                      '${filtred[index].number}',
                                                      style: TextStyle(
                                                        color: Color.fromRGBO(138, 138, 177, 1),
                                                        fontSize: 14,
                                                        fontWeight: FontWeight.w300,
                                                        fontFamily: 'Roboto',
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SvgPicture.asset(
                                        'assets/icons/favourites.svg',
                                        colorFilter: ColorFilter.mode(
                                          filtred[index].isFavourite! ? Color.fromRGBO(88, 255, 227, 1) : Color.fromRGBO(188, 188, 227, 1),
                                          BlendMode.srcIn,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                key: UniqueKey(),
                              );
                            },
                          ),
                        ),
                      )
                    ],
                  ),
                )
              : Center(
                  child: Text(
                    'Вы не добавили номер',
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 13,
                      fontWeight: FontWeight.w300,
                      color: Color.fromRGBO(138, 138, 177, 1),
                    ),
                  ),
                ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:nanny_organizer/components/custom_button.dart';
import 'package:nanny_organizer/components/style.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nanny_organizer/onboarding/onboarding.dart';

class DangerSituations extends StatefulWidget {
  const DangerSituations({super.key});

  @override
  State<DangerSituations> createState() => _DangerSituationsState();
}

class _DangerSituationsState extends State<DangerSituations> {
  PageController pageController = PageController();
  int acitve_screen = 0;
  List<Onboarding> screenData = [
    Onboarding(
      screenId: 0,
      title: '#1',
      text:
          'Как можно чаще говорите с детьми, помогайте решать их, пусть даже пустяковые, по вашему мнению, проблемы. Наблюдая за игрой ребенка, мы смотрим на себя со стороны. А значит, нам самим нужно быть предельно осторожными и внимательными, зная, что наше действие ребенок может воспроизвести с точностью до мельчайших деталей. Поэтому, сколько бы раз вы ни повторяли ребенку, что прежде чем открыть дверь, нужно узнать кто за ней, он никогда не выполнит, если вы сами не будете четко это выполнять.',
    ),
    Onboarding(
      screenId: 1,
      title: '#2',
      text:
          'Если хотите научить ребенка правилам безопасности, прежде всего сами выполняйте их. Самым лучшим способом обучения детей является собственный пример. Если вы всегда внимательны к своей собственной безопасности, то и ребенок будет повторять эти же действия. Любой мошенник или вор внимательно наблюдает за людьми и безошибочно выбирает себе жертву, и если вы приучили ребенка к внимательности, то шанс быть ограбленным снизится почти вдвое.',
    ),
  ];
  List<Onboarding> expansionTile = [
    Onboarding(
      title: 'Неожиданные возгорания электроприборов',
      text:
          'Любая электроника может выйти из строя, особенно это касается соединений. Чаще всего возгорание происходит в розетках. В этом случае ребенок должен максимально быстро покинуть комнату, где произошло возгорание, и найти любого ближайшего взрослого (из числа семьи) или способ с ним связаться. Доведите, что покидать опасную зону надо в сторону выхода, а прятаться в шкафах и под кроватями от огня не только бесполезно, но и сильно затрудняет взрослым спасение.',
    ),
    Onboarding(
      title: 'Незнакомый взрослый просит помощи',
      text:
          'Если человек действительно нуждается в помощи, он будет искать ее у взрослых, способных ее оказать. Все случаи просьб о помощи, обращенных к детям, следует рассматривать как риск. Единственное исключение из этой ситуации — когда никого другого рядом нет и человек просит найти и позвать другого взрослого.',
    ),
    Onboarding(
      title: 'Встреча с агрессивными животными',
      text:
          'Правильные действия — спокойно покинуть опасное место. Показывать страх или убегать нельзя, поскольку это может спровоцировать нападение. Ваша задача дать понять ребенку, что как бы не было страшно, побег является ошибкой и только спокойное отдаление является верным решением.',
    ),
    Onboarding(
      title: 'Если незнакомец стучит в дверь',
      text:
          'В любом случае плохая идея открывать дверь незнакомым лицам. Даже если они представляются кем-то важным вроде полицейских. Открывать дверь не в коем случае НЕЛЬЗЯ.',
    ),
    Onboarding(
      title: 'Если ребенок потерялся в толпе',
      text:
          'Вы должны научить своих детей правильным действиям в толпе. Самое основное — движение следует осуществлять по ходу толпы, а не навстречу ей. При этом нужно стремиться выйти к ее краю, подойти к ближайшему хорошо заметному ориентиру и дать о себе знать. К примеру звонком по телефону.',
    ),
  ];

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
                  'Опасные ситуации в жизни детей',
                  style: appBarSubtitle,
                ),
              ],
            ),
          ),
          body: ListView(
            padding: EdgeInsets.symmetric(vertical: 20),
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
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
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: Color.fromRGBO(88, 255, 227, 1),
                      ),
                      child: Text(
                        '“Обеспечение безопасности семьи, а в особенности детей имеет очень большое значение.”',
                        style: TextStyle(
                          fontFamily: 'Prata',
                          fontWeight: FontWeight.w400,
                          fontSize: 18,
                          color: Color.fromRGBO(12, 22, 84, 1),
                        ),
                      ),
                    ),
                    Container(
                      height: MediaQuery.sizeOf(context).height > 800 ? 350 : 370,
                      margin: EdgeInsets.symmetric(vertical: 10),
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: Colors.white,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Expanded(
                            child: PageView(
                              controller: pageController,
                              onPageChanged: (value) {
                                setState(() {
                                  acitve_screen = value;
                                });
                              },
                              children: [
                                Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 10),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            screenData[0].title ?? '',
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400,
                                              fontFamily: 'Prata',
                                              color: Color.fromRGBO(12, 22, 84, 1),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Text(
                                      screenData[0].text ?? '',
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Container(
                                          height: 5,
                                          width: 5,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: acitve_screen == 0 ? Color.fromRGBO(88, 255, 227, 1) : Color.fromRGBO(188, 188, 227, 1),
                                          ),
                                        ),
                                        Container(
                                          height: 5,
                                          width: 5,
                                          margin: EdgeInsets.symmetric(horizontal: 5),
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: acitve_screen == 1 ? Color.fromRGBO(88, 255, 227, 1) : Color.fromRGBO(188, 188, 227, 1),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 10),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            screenData[1].title ?? '',
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400,
                                              fontFamily: 'Prata',
                                              color: Color.fromRGBO(12, 22, 84, 1),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Text(
                                      screenData[1].text ?? '',
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Container(
                                          height: 5,
                                          width: 5,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: acitve_screen == 0 ? Color.fromRGBO(88, 255, 227, 1) : Color.fromRGBO(188, 188, 227, 1),
                                          ),
                                        ),
                                        Container(
                                          height: 5,
                                          width: 5,
                                          margin: EdgeInsets.symmetric(horizontal: 5),
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: acitve_screen == 1 ? Color.fromRGBO(88, 255, 227, 1) : Color.fromRGBO(188, 188, 227, 1),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    ListView.builder(
                      itemCount: 5,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          margin: EdgeInsets.only(top: 10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                              color: Color.fromRGBO(88, 255, 227, 1),
                            ),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: ExpansionTile(
                            onExpansionChanged: (value) {
                              setState(() {
                                expansionTile[index].isOpen = !expansionTile[index].isOpen;
                              });
                            },
                            trailing:
                                SvgPicture.asset(expansionTile[index].isOpen ? 'assets/icons/arrow_right_up.svg' : 'assets/icons/arrow_right.svg'),
                            childrenPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                            shape: Border.all(style: BorderStyle.none),
                            title: Text(
                              expansionTile[index].title ?? '',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                fontFamily: 'Roboto',
                                color: Color.fromRGBO(12, 22, 84, 1),
                              ),
                            ),
                            children: [
                              Text(
                                expansionTile[index].text ?? '',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w300,
                                  fontFamily: 'Roboto',
                                  color: Color.fromRGBO(12, 22, 84, 1),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}

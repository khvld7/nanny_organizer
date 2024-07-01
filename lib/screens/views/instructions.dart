import 'package:flutter/material.dart';
import 'package:nanny_organizer/components/custom_button.dart';
import 'package:nanny_organizer/components/style.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nanny_organizer/database/database.dart';
import 'package:nanny_organizer/screens/views/add_instructions.dart';
import 'package:nanny_organizer/screens/views/instructions_index.dart';

class Instructions extends StatefulWidget {
  const Instructions({super.key});

  @override
  State<Instructions> createState() => _InstructionsState();
}

class _InstructionsState extends State<Instructions> {
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
                  'Мои инструкции',
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
                    borderRadius: BorderRadius.circular(16),
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
                    child: Text(
                      'Добавить инструкцию',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Prata',
                        color: Color.fromRGBO(12, 22, 84, 1),
                      ),
                    ),
                    color: Color.fromRGBO(88, 255, 227, 1),
                  ),
                ),
              ],
            ),
          ),
          body: instructionsBox.isNotEmpty
              ? ListView.builder(
                  padding: EdgeInsets.symmetric(vertical: 24, horizontal: 24),
                  itemCount: instructionsBox.length,
                  itemBuilder: (BuildContext context, int index) {
                    final instructionsIndex = instructionsBox.getAt(index);
                    return InkWell(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) {
                            return InstructionsIndex(
                              title: instructionsIndex?.title,
                              image: instructionsIndex?.image,
                              text: instructionsIndex?.text,
                            );
                          },
                        ),
                      ),
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                        margin: EdgeInsets.only(top: 10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: Color.fromRGBO(114, 110, 255, 1)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                CustomButton(
                                  width: 24,
                                  height: 24,
                                  child: SvgPicture.asset('assets/icons/instructions_open.svg'),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 16),
                                    child: Text(
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      instructionsIndex?.title ?? '',
                                      style: TextStyle(
                                        fontFamily: 'Roboto',
                                        fontSize: 15,
                                        fontWeight: FontWeight.w300,
                                        color: Color.fromRGBO(12, 22, 84, 1),
                                      ),
                                    ),
                                  ),
                                ),
                                CustomButton(
                                  width: 24,
                                  height: 24,
                                  onPressed: () => setState(() {
                                    instructionsBox.deleteAt(index);
                                  }),
                                  child: SvgPicture.asset('assets/icons/trash.svg'),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 5),
                                    child: Text(
                                      instructionsIndex?.text ?? '',
                                      overflow: TextOverflow.ellipsis,
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
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                )
              : Center(
                  child: Text(
                    'Вы не добавили инструкции',
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

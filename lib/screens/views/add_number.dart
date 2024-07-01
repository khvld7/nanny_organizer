import 'package:flutter/material.dart';
import 'package:nanny_organizer/adapter/hive_adapter.dart';
import 'package:nanny_organizer/components/custom_button.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nanny_organizer/components/custom_textfield.dart';
import 'package:nanny_organizer/database/database.dart';
import '../../components/style.dart';

class AddNumber extends StatefulWidget {
  const AddNumber({super.key});

  @override
  State<AddNumber> createState() => _AddNumberState();
}

class _AddNumberState extends State<AddNumber> {
  bool _isFavourites = false;
  TextEditingController nameController = TextEditingController();
  TextEditingController numberController = TextEditingController();

  @override
  void initState() {
    if (mounted) {
      nameController.addListener(() {
        setState(() {});
      });
      numberController.addListener(() {
        setState(() {});
      });
    }
    super.initState();
  }

  addContact() {
    contactBox.add(
      ContactDB(
        name: nameController.text,
        number: numberController.text,
        isFavourite: _isFavourites,
      ),
    );
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
          floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
          floatingActionButton: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              children: [
                Expanded(
                  child: CustomButton(
                      isActive: nameController.text.isNotEmpty && numberController.text.isNotEmpty ? true : false,
                      borderRadius: BorderRadius.circular(16),
                      border: nameController.text.isNotEmpty && numberController.text.isNotEmpty
                          ? null
                          : Border.all(color: Color.fromRGBO(188, 188, 227, 1)),
                      onPressed: () {
                        addContact();
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Сохранить',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Prata',
                          color: nameController.text.isNotEmpty && numberController.text.isNotEmpty
                              ? Color.fromRGBO(12, 22, 84, 1)
                              : Color.fromRGBO(188, 188, 227, 1),
                        ),
                      ),
                      color: nameController.text.isNotEmpty && numberController.text.isNotEmpty
                          ? Color.fromRGBO(88, 255, 227, 1)
                          : Color.fromRGBO(241, 246, 255, 1)),
                ),
              ],
            ),
          ),
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
                  'Новый контакт',
                  style: appBarSubtitle,
                ),
              ],
            ),
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: CustomTextfield(
                        textCapitalization: TextCapitalization.sentences,
                        textInputAction: TextInputAction.done,
                        controller: nameController,
                        hintText: 'Имя контакта',
                        labelText: 'Имя',
                        onChanged: (value) {},
                      ),
                    ),
                    InkWell(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () => setState(() {
                        _isFavourites = !_isFavourites;
                      }),
                      child: Container(
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
                          color: Colors.white,
                        ),
                        child: Center(
                          child: SvgPicture.asset(
                            'assets/icons/favourites.svg',
                            colorFilter:
                                ColorFilter.mode(_isFavourites ? Color.fromRGBO(88, 255, 227, 1) : Color.fromRGBO(188, 188, 227, 1), BlendMode.srcIn),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: CustomTextfield(
                    controller: numberController,
                    keyboardType: TextInputType.phone,
                    hintText: 'Номер телефона контакта',
                    labelText: 'Номер телефона',
                    onChanged: (value) {},
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}

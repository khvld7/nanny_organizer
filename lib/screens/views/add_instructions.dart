import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nanny_organizer/adapter/hive_adapter.dart';
import 'package:nanny_organizer/components/custom_button.dart';
import 'package:nanny_organizer/components/custom_textfield.dart';
import 'package:nanny_organizer/components/style.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nanny_organizer/database/database.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:image_picker/image_picker.dart';

class AddInstructions extends StatefulWidget {
  const AddInstructions({super.key});

  @override
  State<AddInstructions> createState() => _AddInstructionsState();
}

class _AddInstructionsState extends State<AddInstructions> {
  File? _selectedImage;
  TextEditingController nameController = TextEditingController();
  TextEditingController textController = TextEditingController();

  _getFromGallery(context) async {
    try {
      final pickedFile = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        maxHeight: 400,
        maxWidth: 400,
      );
      setState(() {
        _selectedImage = File(pickedFile!.path);
      });
    } catch (e) {
      var status = await Permission.photos.status;
      if (status.isDenied) {
        _showAlertDialog(context);
      } else {
        _showAlertDialog(context);
        print('Exception occured!');
      }
    }
  }

  _showAlertDialog(context) => showCupertinoDialog<void>(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
          title: Text(
            'Отказано в доступе',
          ),
          content: Text('Разрешить доступ к галерее'),
          actions: [
            CupertinoDialogAction(
              onPressed: () => Navigator.pop(context),
              child: Text('Назад'),
            ),
            CupertinoDialogAction(
              onPressed: () => openAppSettings(),
              isDefaultAction: true,
              child: Text('Настройки'),
            ),
          ],
        ),
      );

  addInstructions() {
    instructionsBox.add(
      InstructionsDB(
        image: _selectedImage?.readAsBytesSync(),
        title: nameController.text,
        text: textController.text,
      ),
    );
  }

  @override
  void initState() {
    if (mounted) {
      nameController.addListener(() {
        setState(() {});
      });
      textController.addListener(() {
        setState(() {});
      });
    }
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
                  'Новая инструкция',
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
                    isActive: _selectedImage != null && nameController.text.isNotEmpty && textController.text.isNotEmpty ? true : false,
                    border: _selectedImage != null && nameController.text.isNotEmpty && textController.text.isNotEmpty
                        ? null
                        : Border.all(color: Color.fromRGBO(188, 188, 227, 1)),
                    borderRadius: BorderRadius.circular(16),
                    onPressed: () {
                      addInstructions();
                      Navigator.pop(context);
                    },
                    child: Text(
                      'Сохранить',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Prata',
                        color: _selectedImage != null && nameController.text.isNotEmpty && textController.text.isNotEmpty
                            ? Color.fromRGBO(12, 22, 84, 1)
                            : Color.fromRGBO(188, 188, 227, 1),
                      ),
                    ),
                    color: _selectedImage != null && nameController.text.isNotEmpty && textController.text.isNotEmpty
                        ? Color.fromRGBO(88, 255, 227, 1)
                        : Color.fromRGBO(241, 246, 255, 1),
                  ),
                ),
              ],
            ),
          ),
          body: ListView(
            padding: EdgeInsets.only(top: 20, bottom: 120),
            children: [
              Column(
                children: [
                  _selectedImage != null
                      ? StreamBuilder<File>(
                          stream: Stream.periodic(
                            Duration(seconds: 1),
                            (_) => _selectedImage!,
                          ),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return Container(
                                padding: const EdgeInsets.symmetric(horizontal: 24),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: Image.file(
                                    snapshot.data!,
                                    fit: BoxFit.fitWidth,
                                  ),
                                ),
                              );
                            } else {
                              return CircularProgressIndicator();
                            }
                          })
                      : Container(
                          margin: EdgeInsets.symmetric(horizontal: 24),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(241, 246, 255, 1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Image.asset('assets/images/camera.png'),
                        ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () => _getFromGallery(context),
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          child: Text(
                            'Нажмите ',
                            style: TextStyle(
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w300,
                              fontSize: 11,
                              color: Color.fromRGBO(114, 110, 255, 1),
                            ),
                          ),
                        ),
                        Text(
                          'для выбора фотографии',
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w300,
                            fontSize: 11,
                            color: Color.fromRGBO(138, 138, 177, 1),
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: CustomTextfield(
                      textInputAction: TextInputAction.done,
                      textCapitalization: TextCapitalization.sentences,
                      controller: nameController,
                      labelText: 'Название инструкции',
                      hintText: 'Название инструкции',
                      onChanged: (value) {
                        nameController.text = value;
                      },
                    ),
                  ),
                  CustomTextfield(
                    textInputAction: TextInputAction.done,
                    textCapitalization: TextCapitalization.sentences,
                    maxLines: null,
                    controller: textController,
                    labelText: 'Текст инструкции',
                    hintText: 'Текст инструкции',
                    onChanged: (value) {
                      setState(() {
                        textController.text = value;
                      });
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

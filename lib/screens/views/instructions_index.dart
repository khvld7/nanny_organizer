import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:nanny_organizer/components/custom_button.dart';
import 'package:nanny_organizer/components/style.dart';
import 'package:flutter_svg/flutter_svg.dart';

class InstructionsIndex extends StatefulWidget {
  final String? title;
  final String? text;
  final Uint8List? image;

  const InstructionsIndex({required this.title, required this.image, required this.text, super.key});

  @override
  State<InstructionsIndex> createState() => _InstructionsIndexState();
}

class _InstructionsIndexState extends State<InstructionsIndex> {
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
                Expanded(
                  child: Text(
                    maxLines: 2,
                    softWrap: true,
                    widget.title ?? '',
                    style: appBarSubtitle,
                  ),
                ),
              ],
            ),
          ),
          body: ListView(
            padding: EdgeInsets.symmetric(vertical: 20),
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                margin: const EdgeInsets.symmetric(horizontal: 16),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.memory(widget.image!),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        widget.title ?? '',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w300,
                          fontFamily: 'Roboto',
                          color: Color.fromRGBO(12, 22, 84, 1),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              widget.text ?? '',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w300,
                                fontFamily: 'Roboto',
                                color: Color.fromRGBO(12, 22, 84, 1),
                              ),
                            ),
                          ),
                        ],
                      ),
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

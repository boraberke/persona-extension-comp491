import 'dart:html';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:macos_ui/macos_ui.dart';
import 'dart:convert';

class CustomizationView extends StatefulWidget {
  const CustomizationView({Key? key}) : super(key: key);

  @override
  State<CustomizationView> createState() => _CustomizationViewState();
}

class _CustomizationViewState extends State<CustomizationView> {
  late final TextEditingController _nameInputController;
  late final TextEditingController _locationInputController;
  String nameInput = '';
  String locationInput = '';

  List<String> ageList = [];
  List<int> ageListInteger = [];
  String agePopupVal = "";

  @override
  void initState() {
    _nameInputController = TextEditingController(text: nameInput);
    _locationInputController = TextEditingController(text: locationInput);

    /*ageListInteger = List<int>.generate(100, (index) => index + 1);
    ageList = utf8.decode(ageListInteger) as List<String>;
    agePopupVal = ageList.first;*/

    ageList = ["1", "2", "3"];
    agePopupVal = ageList.first;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: Add the UI code here
    return CupertinoPageScaffold(
      backgroundColor: Color(0xfffff6ec),
      child: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
                elevation: 0,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10)),
                ),
                fixedSize: const Size(200, 42.5),
                backgroundColor: Color(0xffedbe8e)),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image.asset('assets/images/keyword-icon-40x22.png'),
                const Padding(padding: EdgeInsets.only(left: 10)),
                Text(
                  'Persona Customization',
                  style: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                    color: Color(0xffffffff),
                    fontWeight: FontWeight.w600,
                    fontSize: 11.4,
                  )),
                ),
              ],
            ),
          ),
          const Padding(padding: EdgeInsets.only(top: 10)),
          Expanded(
            child: Padding(
                padding: EdgeInsets.all(10),
                child: ListView(
                  children: [
                    ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                            elevation: 0,
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            fixedSize: const Size(180, 35),
                            backgroundColor: Color(0xffffead4)),
                        child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Saved Personas',
                                style: GoogleFonts.poppins(
                                    textStyle: const TextStyle(
                                  color: Color(0xff87633e),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 11.4,
                                )),
                              ),
                              const Icon(
                                CupertinoIcons.play_fill,
                                color: Color(0xff87633e),
                                size: 15.0,
                              )
                            ])),
                    const Padding(padding: EdgeInsets.only(top: 10)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Padding(padding: EdgeInsets.only(left: 10)),
                        Text(
                          'Create Persona',
                          style: GoogleFonts.poppins(
                              textStyle: const TextStyle(
                            color: Color(0xff87633e),
                            fontWeight: FontWeight.w600,
                            fontSize: 13.1,
                          )),
                        ),
                      ],
                    ),
                    const Padding(padding: EdgeInsets.only(top: 5)),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 180,
                          height: 30,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              MacosTextField(
                                controller: _nameInputController,
                                textAlign: TextAlign.start,
                                keyboardType: TextInputType.text,
                                maxLines: 1,
                                placeholder: "Name your persona",
                                placeholderStyle: const TextStyle(
                                  color: Color(0x665f5f5f),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    const Padding(padding: EdgeInsets.only(top: 10)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: Text(
                            'Age',
                            style: GoogleFonts.poppins(
                                textStyle: const TextStyle(
                              color: Color(0xff87633e),
                              fontWeight: FontWeight.w600,
                              fontSize: 13.1,
                            )),
                          ),
                        ),
                        SizedBox(
                          width: 60,
                          height: 20,
                          child: MacosPopupButton(
                            value: agePopupVal,
                            items: ageList.map<MacosPopupMenuItem<String>>(
                                (String value) {
                              return MacosPopupMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              // This is called when the user selects an item.
                              setState(() {
                                agePopupVal = newValue!;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    const Padding(padding: EdgeInsets.only(top: 10)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: Text(
                            'Location',
                            style: GoogleFonts.poppins(
                                textStyle: const TextStyle(
                              color: Color(0xff87633e),
                              fontWeight: FontWeight.w600,
                              fontSize: 13.1,
                            )),
                          ),
                        ),
                        SizedBox(
                            width: 100,
                            height: 30,
                            child: MacosTextField(
                              controller: _locationInputController,
                              textAlign: TextAlign.start,
                              keyboardType: TextInputType.text,
                              maxLines: 1,
                              placeholder: "Alanya",
                              placeholderStyle: const TextStyle(
                                color: Color(0x665f5f5f),
                              ),
                            )
                        ),
                      ],
                    ),
                    const Padding(padding: EdgeInsets.only(top: 5)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: Text(
                            'Profession',
                            style: GoogleFonts.poppins(
                                textStyle: const TextStyle(
                                  color: Color(0xff87633e),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 13.1,
                                )),
                          ),
                        ),
                        SizedBox(
                            width: 100,
                            height: 30,
                            child: MacosTextField(
                              controller: _locationInputController,
                              textAlign: TextAlign.start,
                              keyboardType: TextInputType.text,
                              maxLines: 1,
                              placeholder: "Avocado Farmer",
                              placeholderStyle: const TextStyle(
                                color: Color(0x665f5f5f),
                              ),
                            )
                        ),
                      ],
                    ),
                  ],
                )),
          ),
          const Padding(padding: EdgeInsets.only(top: 10)),
          ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                elevation: 5,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(24.0)),
                ),
                fixedSize: const Size(130, 24),
                backgroundColor: Color(0xffedbe8e),
                shadowColor: Color(0xffedbe8e),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'SAVE & CONTINUE',
                    style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                      color: Color(0xffffffff),
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                    )),
                  ),
                ],
              )),
          const Padding(padding: EdgeInsets.only(bottom: 10)),
        ],
      ),
    );
  }
}

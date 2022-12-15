import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:macos_ui/macos_ui.dart';

class CustomizationView extends StatefulWidget {
  const CustomizationView({Key? key}) : super(key: key);

  @override
  State<CustomizationView> createState() => _CustomizationViewState();
}

class _CustomizationViewState extends State<CustomizationView> {
  late final TextEditingController _nameInputController;
  late final TextEditingController _ageInputController;
  late final TextEditingController _locationInputController;
  late final TextEditingController _professionInputController;
  String nameInput = '';
  String ageInput = '';
  String locationInput = '';
  String professionInput = '';
  String genderInput = 'Male';
  String maritalStatusInput = 'Married';
  String educationInput = 'High School';
  String incomeInput = '<\$25,000';
  late final TextEditingController _bookInterestInputController;
  late final TextEditingController _moviesTvInterestInputController;
  late final TextEditingController _musicInterestInputController;
  late final TextEditingController _sportInterestInputController;
  late final TextEditingController _hobbyInputController;
  String bookInterestInput = '';
  String moviesTvInterestInput = '';
  String musicInterestInput = '';
  String sportInterestInput = '';
  String hobbyInput = '';

  @override
  void initState() {
    _nameInputController = TextEditingController(text: nameInput);
    _ageInputController = TextEditingController(text: ageInput);
    _locationInputController = TextEditingController(text: locationInput);
    _professionInputController = TextEditingController(text: professionInput);
    _bookInterestInputController =
        TextEditingController(text: bookInterestInput);
    _moviesTvInterestInputController =
        TextEditingController(text: moviesTvInterestInput);
    _musicInterestInputController =
        TextEditingController(text: musicInterestInput);
    _sportInterestInputController =
        TextEditingController(text: sportInterestInput);
    _hobbyInputController = TextEditingController(text: hobbyInput);

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
                fixedSize: const Size(300, 42.5),
                backgroundColor: Color(0xffedbe8e)),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image.asset(
                    'assets/images/persona-customization-icon-11x22.png'),
                const Padding(padding: EdgeInsets.only(left: 10)),
                Text(
                  'Persona Customization',
                  style: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                    color: Color(0xffffffff),
                    fontWeight: FontWeight.w600,
                    fontSize: 13.1,
                  )),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
                padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                child: ListView(
                  children: [
                    const Padding(padding: EdgeInsets.only(top: 10)),
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
                                  fontSize: 12,
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
                            fontSize: 17,
                          )),
                        ),
                      ],
                    ),
                    const Padding(padding: EdgeInsets.only(top: 5)),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 250,
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
                            width: 140,
                            height: 30,
                            child: MacosTextField(
                              controller: _ageInputController,
                              textAlign: TextAlign.start,
                              keyboardType: TextInputType.number,
                              maxLines: 1,
                              maxLength: 3,
                              placeholder: "25",
                              placeholderStyle: const TextStyle(
                                color: Color(0x665f5f5f),
                              ),
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                            )),
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
                            width: 140,
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
                            )),
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
                            width: 140,
                            height: 30,
                            child: MacosTextField(
                              controller: _professionInputController,
                              textAlign: TextAlign.start,
                              keyboardType: TextInputType.text,
                              maxLines: 1,
                              placeholder: "Avocado Farmer",
                              placeholderStyle: const TextStyle(
                                color: Color(0x665f5f5f),
                              ),
                            )),
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
                            'Gender',
                            style: GoogleFonts.poppins(
                                textStyle: const TextStyle(
                              color: Color(0xff87633e),
                              fontWeight: FontWeight.w600,
                              fontSize: 13.1,
                            )),
                          ),
                        ),
                        SizedBox(
                          width: 137,
                          child: MacosPopupButton<String>(
                            items: <String>[
                              'Male',
                              'Female',
                              'Non-Binary'
                            ].map<MacosPopupMenuItem<String>>((String value) {
                              return MacosPopupMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            value: genderInput,
                            onChanged: (String? newValue) {
                              setState(() {
                                genderInput = newValue!;
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
                            'Marital Status',
                            style: GoogleFonts.poppins(
                                textStyle: const TextStyle(
                              color: Color(0xff87633e),
                              fontWeight: FontWeight.w600,
                              fontSize: 13.1,
                            )),
                          ),
                        ),
                        SizedBox(
                          width: 137,
                          child: MacosPopupButton<String>(
                            items: <String>[
                              'Married',
                              'Divorced',
                              'Separated',
                              'Widowed',
                              'Never Married'
                            ].map<MacosPopupMenuItem<String>>((String value) {
                              return MacosPopupMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            value: maritalStatusInput,
                            onChanged: (String? newValue) {
                              setState(() {
                                maritalStatusInput = newValue!;
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
                            'Education',
                            style: GoogleFonts.poppins(
                                textStyle: const TextStyle(
                              color: Color(0xff87633e),
                              fontWeight: FontWeight.w600,
                              fontSize: 13.1,
                            )),
                          ),
                        ),
                        SizedBox(
                          width: 137,
                          child: MacosPopupButton<String>(
                            items: <String>[
                              'High School',
                              'Bachelor\'s',
                              'Master\'s',
                              'PhD',
                              'Other'
                            ].map<MacosPopupMenuItem<String>>((String value) {
                              return MacosPopupMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            value: educationInput,
                            onChanged: (String? newValue) {
                              setState(() {
                                educationInput = newValue!;
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
                            'Income',
                            style: GoogleFonts.poppins(
                                textStyle: const TextStyle(
                              color: Color(0xff87633e),
                              fontWeight: FontWeight.w600,
                              fontSize: 13.1,
                            )),
                          ),
                        ),
                        SizedBox(
                          //width: 137,
                          child: MacosPopupButton<String>(
                            items: <String>[
                              '<\$25,000',
                              '\$25,000 - \$50,000',
                              '\$50,000 - \$100,000',
                              '\$100,000 - \$250,000',
                              '>\$250,000'
                            ].map<MacosPopupMenuItem<String>>((String value) {
                              return MacosPopupMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            value: incomeInput,
                            onChanged: (String? newValue) {
                              setState(() {
                                incomeInput = newValue!;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    const Padding(padding: EdgeInsets.only(top: 15)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Padding(padding: EdgeInsets.only(left: 10)),
                        Text(
                          'Interests & Hobbies',
                          style: GoogleFonts.poppins(
                              textStyle: const TextStyle(
                            color: Color(0xff87633e),
                            fontWeight: FontWeight.w600,
                            fontSize: 17,
                          )),
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
                            'Book Interests',
                            style: GoogleFonts.poppins(
                                textStyle: const TextStyle(
                              color: Color(0xff87633e),
                              fontWeight: FontWeight.w600,
                              fontSize: 13.1,
                            )),
                          ),
                        ),
                        SizedBox(
                            width: 140,
                            height: 30,
                            child: MacosTextField(
                              controller: _bookInterestInputController,
                              textAlign: TextAlign.start,
                              keyboardType: TextInputType.text,
                              maxLines: 1,
                              placeholder: "The Great Gatsby, Hamlet",
                              placeholderStyle: const TextStyle(
                                color: Color(0x665f5f5f),
                              ),
                            )),
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
                            'Movies & TV Interests',
                            style: GoogleFonts.poppins(
                                textStyle: const TextStyle(
                              color: Color(0xff87633e),
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                            )),
                          ),
                        ),
                        SizedBox(
                            width: 140,
                            height: 30,
                            child: MacosTextField(
                              controller: _moviesTvInterestInputController,
                              textAlign: TextAlign.start,
                              keyboardType: TextInputType.text,
                              maxLines: 1,
                              placeholder: "Modern Family, Godfather Part II",
                              placeholderStyle: const TextStyle(
                                color: Color(0x665f5f5f),
                              ),
                            )),
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
                            'Music Interests',
                            style: GoogleFonts.poppins(
                                textStyle: const TextStyle(
                              color: Color(0xff87633e),
                              fontWeight: FontWeight.w600,
                              fontSize: 13.1,
                            )),
                          ),
                        ),
                        SizedBox(
                            width: 140,
                            height: 30,
                            child: MacosTextField(
                              controller: _musicInterestInputController,
                              textAlign: TextAlign.start,
                              keyboardType: TextInputType.text,
                              maxLines: 1,
                              placeholder: "Highway to Hell, Dua Lipa",
                              placeholderStyle: const TextStyle(
                                color: Color(0x665f5f5f),
                              ),
                            )),
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
                            'Sports Interests',
                            style: GoogleFonts.poppins(
                                textStyle: const TextStyle(
                              color: Color(0xff87633e),
                              fontWeight: FontWeight.w600,
                              fontSize: 13.1,
                            )),
                          ),
                        ),
                        SizedBox(
                            width: 140,
                            height: 30,
                            child: MacosTextField(
                              controller: _sportInterestInputController,
                              textAlign: TextAlign.start,
                              keyboardType: TextInputType.text,
                              maxLines: 1,
                              placeholder: "Lionel Messi, US Open",
                              placeholderStyle: const TextStyle(
                                color: Color(0x665f5f5f),
                              ),
                            )),
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
                            'Hobbies',
                            style: GoogleFonts.poppins(
                                textStyle: const TextStyle(
                              color: Color(0xff87633e),
                              fontWeight: FontWeight.w600,
                              fontSize: 13.1,
                            )),
                          ),
                        ),
                        SizedBox(
                            width: 140,
                            height: 30,
                            child: MacosTextField(
                              controller: _hobbyInputController,
                              textAlign: TextAlign.start,
                              keyboardType: TextInputType.text,
                              maxLines: 1,
                              placeholder: "Wood Carving, Video Games",
                              placeholderStyle: const TextStyle(
                                color: Color(0x665f5f5f),
                              ),
                            )),
                      ],
                    ),
                  ],
                )),
          ),
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

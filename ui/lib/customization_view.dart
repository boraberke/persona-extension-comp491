import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:macos_ui/macos_ui.dart';
import 'package:ui/saved_personas_view.dart';
import 'objects/Persona.dart';
import 'dbQueries.dart';

class CustomizationView extends StatefulWidget {
  final String accessID;

  const CustomizationView({super.key, required this.accessID});

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
  late final TextEditingController _genderInputController;
  late final TextEditingController _maritalStatusInputController;
  late final TextEditingController _educationInputController;
  late final TextEditingController _incomeInputController;
  String genderInput = '';
  String maritalStatusInput = '';
  String educationInput = '';
  String incomeInput = '';
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
    _genderInputController = TextEditingController(text: genderInput);
    _maritalStatusInputController =
        TextEditingController(text: maritalStatusInput);
    _educationInputController = TextEditingController(text: educationInput);
    _incomeInputController = TextEditingController(text: incomeInput);
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
      backgroundColor: const Color(0xfffff6ec),
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
                backgroundColor: const Color(0xffedbe8e)),
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
                    //TODO: change widget below visually
                    Padding(
                      padding: EdgeInsets.only(left: 10, top: 10),
                      child: Text(
                        "Access ID:  ${widget.accessID}",
                        style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                          color: Color(0xff87633e),
                          fontWeight: FontWeight.w600,
                          fontSize: 13.1,
                        )),
                        overflow: TextOverflow.fade,
                      ),
                    ),
                    const Padding(padding: EdgeInsets.only(top: 10)),
                    ElevatedButton(
                        onPressed: () async {
                          List<Persona> personas =
                              await getPersonaList(widget.accessID);
                          // ignore: use_build_context_synchronously
                          Navigator.push(
                              context,
                              CupertinoPageRoute(
                                  builder: (context) => SavedPersonasView(
                                      accessID: widget.accessID,
                                      personas: personas)));
                        },
                        style: ElevatedButton.styleFrom(
                            elevation: 0,
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            fixedSize: const Size(180, 35),
                            backgroundColor: const Color(0xffffead4)),
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
                                Icons.arrow_forward_ios,
                                color: Color(0xff87633e),
                                size: 15.0,
                              )
                            ])),
                    const Padding(padding: EdgeInsets.only(top: 10)),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Create Persona',
                          style: GoogleFonts.poppins(
                              textStyle: const TextStyle(
                            color: Color(0xff87633e),
                            fontWeight: FontWeight.w600,
                            fontSize: 17,
                          )),
                        ),
                        const Padding(
                            padding: EdgeInsets.only(top: 5, left: 5)),
                        SizedBox(
                          height: 30,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              MacosTextField(
                                controller: _nameInputController,
                                textAlign: TextAlign.start,
                                keyboardType: TextInputType.text,
                                inputFormatters: [FilteringTextInputFormatter.allow(RegExp('[a-z A-Z 0-9]'))],
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
                          padding: const EdgeInsets.only(left: 10),
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
                          padding: const EdgeInsets.only(left: 10),
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
                          padding: const EdgeInsets.only(left: 10),
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
                          padding: const EdgeInsets.only(left: 10),
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
                            width: 140,
                            height: 30,
                            child: MacosTextField(
                              controller: _genderInputController,
                              textAlign: TextAlign.start,
                              keyboardType: TextInputType.text,
                              maxLines: 1,
                              placeholder: "Male",
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
                          padding: const EdgeInsets.only(left: 10),
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
                            width: 140,
                            height: 30,
                            child: MacosTextField(
                              controller: _maritalStatusInputController,
                              textAlign: TextAlign.start,
                              keyboardType: TextInputType.text,
                              maxLines: 1,
                              placeholder: "Married",
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
                          padding: const EdgeInsets.only(left: 10),
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
                            width: 140,
                            height: 30,
                            child: MacosTextField(
                              controller: _educationInputController,
                              textAlign: TextAlign.start,
                              keyboardType: TextInputType.text,
                              maxLines: 1,
                              placeholder: "Bachelor's in Computer Science",
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
                          padding: const EdgeInsets.only(left: 10),
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
                        Row(
                          children: [
                            Text(
                              '\$',
                              style: GoogleFonts.poppins(
                                  textStyle: const TextStyle(
                                color: Color(0xff87633e),
                                fontWeight: FontWeight.w600,
                                fontSize: 13.1,
                              )),
                            ),
                            SizedBox(
                                width: 140,
                                height: 30,
                                child: MacosTextField(
                                  controller: _incomeInputController,
                                  textAlign: TextAlign.start,
                                  keyboardType: TextInputType.number,
                                  maxLines: 1,
                                  maxLength: 10,
                                  placeholder: "50,000",
                                  placeholderStyle: const TextStyle(
                                    color: Color(0x665f5f5f),
                                  ),
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly,
                                  ],
                                )),
                          ],
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 10.0, right: 10.0),
                          child: Text(
                            'For the fields below, you can specify \nmultiple interests separated by a comma.',
                            style: GoogleFonts.poppins(
                                textStyle: const TextStyle(
                              color: Color(0xffedbe8e),
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                            )),
                          ),
                        ),
                      ],
                    ),
                    const Padding(padding: EdgeInsets.only(top: 10.0)),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
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
                            //height: 30,
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
                    const Padding(padding: EdgeInsets.only(top: 10)),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Text(
                            'Movies & TV Interests',
                            style: GoogleFonts.poppins(
                                textStyle: const TextStyle(
                              color: Color(0xff87633e),
                              fontWeight: FontWeight.w600,
                              fontSize: 13.1,
                            )),
                          ),
                        ),
                        SizedBox(
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
                    const Padding(padding: EdgeInsets.only(top: 10)),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
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
                    const Padding(padding: EdgeInsets.only(top: 10)),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
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
                    const Padding(padding: EdgeInsets.only(top: 10)),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
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
              onPressed: () async {
                // Create a Persona Object
                List<String> tempBook = [];
                if (_bookInterestInputController.text.isNotEmpty) {
                  tempBook = _bookInterestInputController.text.split(',');
                  tempBook = tempBook.map((e) => e.trim()).toList();
                }

                List<String> tempMovies = [];
                if (_moviesTvInterestInputController.text.isNotEmpty) {
                  tempMovies = _moviesTvInterestInputController.text.split(',');
                  tempMovies = tempMovies.map((e) => e.trim()).toList();
                }

                List<String> tempMusic = [];
                if (_musicInterestInputController.text.isNotEmpty) {
                  tempMusic = _musicInterestInputController.text.split(',');
                  tempMusic = tempMusic.map((e) => e.trim()).toList();
                }

                List<String> tempSport = [];
                if (_sportInterestInputController.text.isNotEmpty) {
                  tempSport = _sportInterestInputController.text.split(',');
                  tempSport = tempSport.map((e) => e.trim()).toList();
                }

                List<String> tempHobby = [];
                if (_hobbyInputController.text.isNotEmpty) {
                  tempHobby = _hobbyInputController.text.split(',');
                  tempHobby = tempHobby.map((e) => e.trim()).toList();
                }
                print(
                    "name: ${_nameInputController.text}\n age: ${_ageInputController.text}\n profession: ${_professionInputController.text}\n gender: ${_genderInputController.text}\n location: ${_locationInputController.text}\n marital_status: ${_maritalStatusInputController.text}\n education: ${_educationInputController.text}\n income: ${_incomeInputController.text}\n book_interests: $tempBook\n movies_interests: $tempMovies\n music_interests: $tempMusic\n sport_interests: $tempSport\n hobby: $tempHobby\n");
                Persona persona = Persona(
                    name: _nameInputController.text,
                    age: int.parse(_ageInputController.text),
                    profession: _professionInputController.text,
                    gender: _genderInputController.text,
                    location: _locationInputController.text,
                    marital_status: _maritalStatusInputController.text,
                    education: _educationInputController.text,
                    income: _incomeInputController.text,
                    book_interest: tempBook,
                    movies_interest: tempMovies,
                    music_interest: tempMusic,
                    sport_interest: tempSport,
                    hobby: tempHobby);

                await addPersonaToList(widget.accessID, persona);
                List<Persona> personas = await getPersonaList(widget.accessID);
                Navigator.push(
                    context,
                    CupertinoPageRoute(
                        builder: (context) => SavedPersonasView(
                              personas: personas,
                              accessID: widget.accessID,
                            )));
              },
              style: ElevatedButton.styleFrom(
                elevation: 5,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(24.0)),
                ),
                fixedSize: const Size(130, 24),
                backgroundColor: const Color(0xffedbe8e),
                shadowColor: const Color(0xffedbe8e),
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

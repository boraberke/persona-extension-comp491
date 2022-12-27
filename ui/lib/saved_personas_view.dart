import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:macos_ui/macos_ui.dart';

class SavedPersonasView extends StatefulWidget {
  const SavedPersonasView({Key? key}) : super(key: key);

  @override
  State<SavedPersonasView> createState() => _SavedPersonasViewState();
}

class _SavedPersonasViewState extends State<SavedPersonasView> {
  late List<dynamic> _personas;
  // TODO @emre: Get user persona list into _personas

  final List<Map<String, dynamic>> _personasDemo = [
    {"Name": "Metin"},
    {"Name": "Tevfik"},
    {"Name": "Sezgin"},
    {"Name": "Kareem"},
    {"Name": "Abdul"},
    {"Name": "Jabbar"},
    {"Name": "Mehmet"},
    {"Name": "Ali"},
    {"Name": "Erbil"},
  ];

  void deletePersona(int index) {
    setState(() {
      _personasDemo.removeAt(index);
      // TODO @emre: Remove persona from DB

    });
  }

  void goWithPersona(int index) {
    setState(() {
      // TODO @emre: Go with selected persona.

    });
  }

  @override
  void initState() {
    super.initState();
    _loadPersonas();

  }

  void _loadPersonas() async {
    // TODO @emre: Load User's Personas from Database
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
                  'Saved Personas',
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
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Column(
                    children: _personasDemo.map((persona) {
                      return Column(
                        children: [
                          const Padding(padding: EdgeInsets.only(top: 10.0)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      elevation: 0,
                                      shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10))),
                                      fixedSize: const Size(160, 40),
                                      backgroundColor: const Color(0xffffead4)),
                                  onPressed: () => goWithPersona(
                                      _personasDemo.indexOf(persona)),
                                  child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Icon(
                                          Icons.account_circle_rounded,
                                          color: Color(0xff87633e),
                                          size: 20.0,
                                        ),
                                        Text(
                                          persona['Name'],
                                          style: GoogleFonts.poppins(
                                              textStyle: const TextStyle(
                                            color: Color(0xff87633e),
                                            fontWeight: FontWeight.w600,
                                            fontSize: 15,
                                          )),
                                        ),
                                      ])),
                              const Padding(padding: EdgeInsets.only(left: 10.0)),
                              ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      elevation: 0,
                                      shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10))),
                                      fixedSize: const Size(40, 40),
                                      backgroundColor: const Color(0xffff7e80)),
                                  onPressed: () => deletePersona(
                                      _personasDemo.indexOf(persona)),
                                  child: const Icon(
                                    CupertinoIcons.trash_fill,
                                    color: Color(0xffffffff),
                                    size: 20.0,
                                  )),
                            ],
                          ),
                        ],
                      );
                    }).toList(),
                  ),
                  const Padding(padding: EdgeInsets.only(bottom: 10.0)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'dart:convert';
import 'dart:html';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'objects/Persona.dart';
import 'package:ui/statistics_view.dart';
import 'package:http/http.dart' as http;
import 'dbQueries.dart';

class SavedPersonasView extends StatefulWidget {
  SavedPersonasView(
      {super.key, required this.accessID, required this.personas});

  List<Persona> personas;
  final String accessID;

  @override
  State<SavedPersonasView> createState() => _SavedPersonasViewState();
}

class _SavedPersonasViewState extends State<SavedPersonasView> {
  late List<Persona> personas;
  late String accessID;

  @override
  void initState() async {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    personas = widget.personas;
    accessID = widget.accessID;
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
                    children: personas.map((persona) {
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
                                  onPressed: () async {
                                    getWebsitesToSearchfromPersona(persona);
                                    Map<String, int> statistics =
                                        await getStatistics(persona)
                                            as Map<String, int>;
                                    Navigator.push(
                                        context,
                                        CupertinoPageRoute(
                                            builder: (context) =>
                                                StatisticsView(
                                                    searchStats: statistics)));
                                  },
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
                                          persona.name,
                                          style: GoogleFonts.poppins(
                                              textStyle: const TextStyle(
                                            color: Color(0xff87633e),
                                            fontWeight: FontWeight.w600,
                                            fontSize: 15,
                                          )),
                                        ),
                                      ])),
                              const Padding(
                                  padding: EdgeInsets.only(left: 10.0)),
                              ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      elevation: 0,
                                      shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10))),
                                      fixedSize: const Size(40, 40),
                                      backgroundColor: const Color(0xffff7e80)),
                                  onPressed: () => {
                                        deletePersonaFromList(
                                            widget.accessID, persona.name),
                                        setState(() {
                                          personas.removeWhere((item) =>
                                              item.name == persona.name);
                                        })
                                      },
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

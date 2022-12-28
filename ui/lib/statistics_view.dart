import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fl_chart/fl_chart.dart';

class StatisticsView extends StatefulWidget {
  const StatisticsView({Key? key}) : super(key: key);

  @override
  State<StatisticsView> createState() => _StatisticsViewState();
}

class _StatisticsViewState extends State<StatisticsView> {
  late Map<String, int> _searchStats;

  final Map<String, int> _searchStatsDemo = {
    "Age": 5,
    "Location": 10,
    "Profession": 20,
    "Gender": 15,
    "Marital Status": 25,
    "Education": 30,
    "Income": 20,
    "Book Interest": 5,
    "Movies TV Interest": 25,
    "Music Interest": 15,
    "Sport Interest": 20,
    "Hobby": 25,
  };

  @override
  void initState() {
    super.initState();
    _loadStats();

  }

  void _loadStats() async {
    // TODO: Load Stats from Backend

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
              Navigator.popUntil(context, (route) => route.isFirst);
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
                    'assets/images/statistics-icon-30x22.png'),
                const Padding(padding: EdgeInsets.only(left: 10)),
                Text(
                  'Statistics',
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
                  Padding(
                    padding: const EdgeInsets.only(top: 20, bottom: 20),
                    child: Text(
                      'Breakdown of the Latest Search',
                      style: GoogleFonts.poppins(
                          textStyle: const TextStyle(
                            color: Color(0xff87633e),
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                            decoration: TextDecoration.underline,
                          )),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left:10, bottom: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Websites Visited For Each Attribute',
                          style: GoogleFonts.poppins(
                              textStyle: const TextStyle(
                                color: Color(0xff87633e),
                                fontWeight: FontWeight.w600,
                                fontSize: 13,
                              )),
                        ),
                      ],
                    ),
                  ),
                  /*Padding(
                    padding: const EdgeInsets.all(10),
                    child: ,
                  ),*/
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

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fl_chart/fl_chart.dart';

class StatisticsView extends StatefulWidget {
  StatisticsView({super.key, required this.searchStats});

  Map<String, int> searchStats;

  @override
  State<StatisticsView> createState() => _StatisticsViewState();
}

class _StatisticsViewState extends State<StatisticsView> {
  late Map<String, int> searchStats;

  Map<String, int> searchStatsCategorized = {
    "Job": 0,
    "Book": 0,
    "Movie": 0,
    "Music": 0,
    "Sport": 0,
    "Hobby": 0,
  };

  @override
  void initState() {
    super.initState();
  }

  List<Color> gradientColors = [
    const Color(0xff23b6e6),
    const Color(0xff02d39a),
  ];

  bool showAvg = false;

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Color(0xff68737d),
      fontWeight: FontWeight.bold,
      fontSize: 10,
    );
    Widget text;

    switch (value.toInt()) {
      case 0:
        text = Text(
          "Job",
          style: style,
          overflow: TextOverflow.fade,
        );
        break;
      case 2:
        text = Text(
          "Book",
          style: style,
          overflow: TextOverflow.fade,
        );
        break;
      case 4:
        text = Text(
          "Movie",
          style: style,
          overflow: TextOverflow.fade,
        );
        break;
      case 6:
        text = text = Text(
          "Music",
          style: style,
          overflow: TextOverflow.fade,
        );
        break;
      case 8:
        text = text = Text(
          "Sport",
          style: style,
          overflow: TextOverflow.fade,
        );
        break;
      case 10:
        text = text = Text(
          "Hobby",
          style: style,
          overflow: TextOverflow.fade,
        );
        break;
      default:
        text = Text('', style: style);
        break;
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: text,
    );
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Color(0xff67727d),
      fontWeight: FontWeight.bold,
      fontSize: 12,
    );
    String text;
    switch (value.toInt()) {
      case 3:
        text = '3';
        break;
      case 6:
        text = '6';
        break;
      case 9:
        text = '9';
        break;
      case 12:
        text = '12';
        break;
      case 15:
        text = '15';
        break;
      case 18:
        text = '18';
        break;
      default:
        return Container();
    }

    return Text(text, style: style, textAlign: TextAlign.left);
  }

  LineChartData mainData() {
    searchStatsCategorized = {
      "Job": 0,
      "Book": 0,
      "Movie": 0,
      "Music": 0,
      "Sport": 0,
      "Hobby": 0,
    };

    var keys = widget.searchStats.keys.toList();
    var linkLengths = widget.searchStats.values.toList();
    for (int i = 0; i < keys.length; i++) {
      if (keys[i].contains("jobs")) {
        searchStatsCategorized["Job"] =
            (searchStatsCategorized["Job"]! + linkLengths[i]);
      } else if (keys[i].contains("book")) {
        searchStatsCategorized["Book"] =
            (searchStatsCategorized["Book"]! + linkLengths[i]);
      } else if (keys[i].contains("letterboxd") ||
          keys[i].contains("film watch")) {
        searchStatsCategorized["Movie"] =
            (searchStatsCategorized["Movie"]! + linkLengths[i]);
      } else if (keys[i].contains("concerts")) {
        searchStatsCategorized["Music"] =
            (searchStatsCategorized["Music"]! + linkLengths[i]);
      } else if (keys[i].contains("match tickets")) {
        searchStatsCategorized["Sport"] =
            (searchStatsCategorized["Sport"]! + linkLengths[i]);
      } else if (keys[i].contains("events")) {
        searchStatsCategorized["Hobby"] =
            (searchStatsCategorized["Hobby"]! + linkLengths[i]);
      }
    }

    var values = searchStatsCategorized.values.toList();

    List<FlSpot> spots = [];
    for (int i = 0; i < values.length; i++) {
      spots.add(FlSpot(i.toDouble() * 2, values[i].toDouble()));
    }

    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        horizontalInterval: 3,
        verticalInterval: 1,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 1,
          );
        },
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            interval: 1,
            getTitlesWidget: bottomTitleWidgets,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: 3,
            getTitlesWidget: leftTitleWidgets,
            reservedSize: 42,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: Border.all(color: const Color(0xff37434d)),
      ),
      minX: 0,
      maxX: 11,
      minY: 0,
      maxY: 18,
      lineBarsData: [
        LineChartBarData(
          spots: spots,
          isCurved: true,
          gradient: LinearGradient(
            colors: gradientColors,
          ),
          barWidth: 4,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: gradientColors
                  .map((color) => color.withOpacity(0.3))
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }

  LineChartData avgData() {
    int sum = 0;

    var values = searchStatsCategorized.values.toList();

    for (int i = 0; i < values.length; i++) {
      sum = sum + values[i];
    }

    double average = sum / values.length;

    return LineChartData(
      lineTouchData: LineTouchData(enabled: false),
      gridData: FlGridData(
        show: true,
        drawHorizontalLine: true,
        verticalInterval: 1,
        horizontalInterval: 3,
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 1,
          );
        },
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            getTitlesWidget: bottomTitleWidgets,
            interval: 1,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: leftTitleWidgets,
            reservedSize: 42,
            interval: 3,
          ),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: Border.all(color: const Color(0xff37434d)),
      ),
      minX: 0,
      maxX: 11,
      minY: 0,
      maxY: 18,
      lineBarsData: [
        LineChartBarData(
          spots: [
            FlSpot(0, average),
            FlSpot(2, average),
            FlSpot(4, average),
            FlSpot(6, average),
            FlSpot(8, average),
            FlSpot(10, average),
          ],
          isCurved: true,
          gradient: LinearGradient(
            colors: [
              ColorTween(begin: gradientColors[0], end: gradientColors[1])
                  .lerp(0.2)!,
              ColorTween(begin: gradientColors[0], end: gradientColors[1])
                  .lerp(0.2)!,
            ],
          ),
          barWidth: 4,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: [
                ColorTween(begin: gradientColors[0], end: gradientColors[1])
                    .lerp(0.2)!
                    .withOpacity(0.1),
                ColorTween(begin: gradientColors[0], end: gradientColors[1])
                    .lerp(0.2)!
                    .withOpacity(0.1),
              ],
            ),
          ),
        ),
      ],
    );
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
                Image.asset('assets/images/statistics-icon-30x22.png'),
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
                    padding: const EdgeInsets.only(left: 10, bottom: 10),
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
                  Padding(
                    padding: const EdgeInsets.only(left: 28, right: 18),
                    child: Stack(
                      children: <Widget>[
                        AspectRatio(
                          aspectRatio: 1.70,
                          child: DecoratedBox(
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(18),
                              ),
                              color: Color(0xff232d37),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                right: 18,
                                left: 12,
                                top: 24,
                                bottom: 12,
                              ),
                              child: LineChart(
                                showAvg ? avgData() : mainData(),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 60,
                          height: 34,
                          child: TextButton(
                            onPressed: () {
                              setState(() {
                                showAvg = !showAvg;
                              });
                            },
                            child: Text(
                              'avg',
                              style: TextStyle(
                                fontSize: 12,
                                color: showAvg
                                    ? Colors.white.withOpacity(0.5)
                                    : Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

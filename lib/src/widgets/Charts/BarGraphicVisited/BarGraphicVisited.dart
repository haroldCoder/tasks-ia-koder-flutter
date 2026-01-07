import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:tasks_ia_koderx/src/shared/States/Visited_App/visited_service.dart';
import 'package:tasks_ia_koderx/src/shared/lang/graphs/lang.dart';
import 'package:tasks_ia_koderx/src/widgets/Charts/BarGraphicVisited/constants/days.dart';

class Bargraphicvisited extends StatefulWidget {
  @override
  _BargraphicvisitedState createState() => _BargraphicvisitedState();
}

class _BargraphicvisitedState extends State<Bargraphicvisited> {
  VisitedService visitedService = VisitedService();

  @override
  void initState() {
    super.initState();
    _balanceVisitedsByDays();
  }

  Future<void> _balanceVisitedsByDays() async {
    var visiteds = await visitedService.getAllVisiteds();

    setState(() {
      for (var vb in visiteds) {
        List<String> parts = vb.datelog.split(", ");

        if (parts.isNotEmpty) {
          String dayFound = parts[0];
          if (visitedBalanceDays.containsKey(dayFound)) {
            visitedBalanceDays[dayFound] =
                visitedBalanceDays[dayFound]! + 1;
          }
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    List<String> days = visitedBalanceDays.keys.toList();
    List<int> values = visitedBalanceDays.values.toList();

    return  Container(
        padding: EdgeInsets.only(top: 10, bottom: 10, left: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          border: Border.all(color: Colors.white38),
        ),
        child: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                interactionsDay,
                style: TextStyle(color: Colors.white38),
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: BarChart(
                BarChartData(
                  barGroups: List.generate(
                    days.length,
                        (index) => BarChartGroupData(
                      x: index,
                      barRods: [
                        BarChartRodData(
                          toY: values[index].toDouble(),
                          color: Colors.blueAccent,
                          width: 30,
                          backDrawRodData: BackgroundBarChartRodData(
                            show: true,
                            toY: values[index] + 1,
                            color: Colors.blue.withOpacity(0.2),
                          ),
                        ),
                      ],
                          showingTooltipIndicators: [0]
                    ),
                  ),
                  titlesData: FlTitlesData(
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (double value, TitleMeta meta) {
                          return Text(
                            days[value.toInt()],
                            style: TextStyle(fontSize: 12, color: Colors.white),
                          );
                        },
                      ),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (double value, TitleMeta meta) {
                          return Text(
                            value.toInt().toString(),
                            style: TextStyle(color: Colors.white30, fontSize: 12),
                          );
                        },
                      ),
                    ),
                    topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  ),
                  borderData: FlBorderData(show: false),
                  gridData: FlGridData(show: false),
                  barTouchData: BarTouchData(
                    touchTooltipData: BarTouchTooltipData(
                      fitInsideVertically: true,
                      tooltipPadding: EdgeInsets.zero,
                      tooltipMargin: 0,
                      getTooltipItem: (group, groupIndex, rod, rodIndex) {
                        return BarTooltipItem(
                          '${rod.toY}',
                          const TextStyle(color: Colors.white, fontSize: 14),
                          children: [],
                        );
                      },
                    ),
                  )
                ),
              ),
            ),
          ],
        ),
    );
  }
}

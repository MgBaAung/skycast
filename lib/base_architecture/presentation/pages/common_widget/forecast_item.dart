import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:skycast/base_architecture/domain/model/forecast_model.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:skycast/base_architecture/domain/model/wealther_data_model.dart';

class DailyWeatherChart extends StatelessWidget {
  final List<Lists> fullList;

  const DailyWeatherChart({super.key, required this.fullList});

  @override
  Widget build(BuildContext context) {
    final List<Lists> dailyList = getCalculatedDailyForecasts(fullList);

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        color: const Color(0xFF1B3B5F),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: dailyList.map((item) {
              DateTime date = DateTime.parse(item.dtTxt!);
              int conditionId = item.weather?.first.id ?? 800;
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    DateFormat('EEE').format(date),
                    style: const TextStyle(
                      color: Colors.white70,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: 70,
                    height: 40,
                    child: Text(
                      weatherDescription(item.weather),
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(color: Colors.white70),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    DateFormat('MM/dd').format(date),
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Icon(
                    _getWeatherIcon(conditionId),
                    color: Colors.white,
                    size: 28,
                  ),
                ],
              );
            }).toList(),
          ),
          const SizedBox(height: 30),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: SizedBox(
              height: 160,
              child: LineChart(
                LineChartData(
                  gridData: const FlGridData(show: false),
                  titlesData: const FlTitlesData(show: false),
                  borderData: FlBorderData(show: false),
                  minY:
                      (dailyList
                          .map((e) => e.main!.tempMin! - 273.15)
                          .reduce((a, b) => a < b ? a : b)) -
                      5,
                  maxY:
                      (dailyList
                          .map((e) => e.main!.tempMax! - 273.15)
                          .reduce((a, b) => a > b ? a : b)) +
                      5,
                  lineTouchData: LineTouchData(
                    enabled: false,
                    handleBuiltInTouches: false,

                    touchTooltipData: LineTouchTooltipData(
                      getTooltipColor: (touchedSpot) => Colors.transparent,
                      fitInsideHorizontally: true,
                      fitInsideVertically: true,
                      tooltipPadding: EdgeInsets.symmetric(vertical: 10),
                      getTooltipItems: (List<LineBarSpot> lineBarsSpot) {
                        return lineBarsSpot.map((lineBarSpot) {
                          final isMax = lineBarSpot.barIndex == 0;

                          return LineTooltipItem(
                            isMax
                                ? "${lineBarSpot.y.round()}°C"
                                : "\n\n\n\n\n\n${lineBarSpot.y.round()}°C",
                            TextStyle(
                              color: lineBarSpot.bar.color,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          );
                        }).toList();
                      },
                    ),
                  ),
                  lineBarsData: [
                    _createLine(
                      dailyList,
                      isMax: true,
                      color: Colors.orangeAccent,
                    ),
                    _createLine(
                      dailyList,
                      isMax: false,
                      color: Colors.cyanAccent,
                    ),
                  ],
                  showingTooltipIndicators: dailyList.asMap().entries.map((
                    index,
                  ) {
                    final maxLine = _createLine(
                      dailyList,
                      isMax: true,
                      color: Colors.orangeAccent,
                    );

                    final minLine = _createLine(
                      dailyList,
                      isMax: false,
                      color: Colors.cyanAccent,
                    );

                    return ShowingTooltipIndicators([
                      LineBarSpot(
                        maxLine,
                        0,
                        FlSpot(
                          index.key.toDouble(),
                          (dailyList[index.key].main!.tempMax! - 273.15),
                        ),
                      ),
                      LineBarSpot(
                        minLine,
                        1,
                        FlSpot(
                          index.key.toDouble(),
                          (dailyList[index.key].main!.tempMin! - 273.15),
                        ),
                      ),
                    ]);
                  }).toList(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Lists> getCalculatedDailyForecasts(List<Lists> list) {
    final Map<String, List<Lists>> groupedMap = {};
    for (var item in list) {
      String date = item.dtTxt!.split(' ')[0];
      groupedMap.putIfAbsent(date, () => []).add(item);
    }
    List<Lists> results = [];
    groupedMap.forEach((date, items) {
      double maxTemp = -double.infinity;
      double minTemp = double.infinity;
      Lists representativeItem = items[0];
      for (var hourly in items) {
        if (hourly.main!.tempMax! > maxTemp) maxTemp = hourly.main!.tempMax!;
        if (hourly.main!.tempMin! < minTemp) minTemp = hourly.main!.tempMin!;
        if (hourly.dtTxt!.contains("12:00:00")) representativeItem = hourly;
      }
      representativeItem.main!.tempMax = maxTemp;
      representativeItem.main!.tempMin = minTemp;
      results.add(representativeItem);
    });
    return results.take(5).toList();
  }

  LineChartBarData _createLine(
    List<Lists> data, {
    required bool isMax,
    required Color color,
  }) {
    return LineChartBarData(
      spots: data.asMap().entries.map((e) {
        double tempK = isMax ? e.value.main!.tempMax! : e.value.main!.tempMin!;
        return FlSpot(e.key.toDouble(), tempK - 273.15);
      }).toList(),
      isCurved: true,
      color: color,
      barWidth: 3,
      dotData: const FlDotData(show: true),
      belowBarData: BarAreaData(
        show: isMax,
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [color.withOpacity(0.3), Colors.transparent],
        ),
      ),
    );
  }

  String weatherDescription(List<Weather>? data) {
    if (data == null || data.isEmpty) return 'N/A';

    String desc = data.first.description ?? 'N/A';

    return desc
        .split(' ')
        .map((word) {
          if (word.isEmpty) return word;
          return word[0].toUpperCase() + word.substring(1);
        })
        .join(' ');
  }

  IconData _getWeatherIcon(int conditionId) {
    if (conditionId < 300) return Icons.thunderstorm;
    if (conditionId < 500) return Icons.cloudy_snowing;
    if (conditionId < 600) return Icons.umbrella;
    if (conditionId < 700) return Icons.ac_unit;
    if (conditionId < 800) return Icons.foggy;
    if (conditionId == 800) return Icons.wb_sunny;
    if (conditionId <= 804) return Icons.cloud;
    return Icons.device_thermostat;
  }
}

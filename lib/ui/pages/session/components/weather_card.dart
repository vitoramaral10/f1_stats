import 'package:f1_stats/domain/entities/entities.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WeatherCard extends StatelessWidget {
  final List<WeatherEntity> weather;

  const WeatherCard({
    super.key,
    required this.weather,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      height: 200,
      child: Card(
        child: Column(
          children: [
            Text(
              'Weather',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Divider(),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Obx(
                  () => weather.isEmpty
                      ? Center(
                          child: Text('No DATA'),
                        )
                      : Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Column(
                                  children: [
                                    Row(
                                      children: [
                                        Row(
                                          children: [
                                            Text('Air Temp.',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .labelLarge),
                                            SizedBox(width: 8),
                                            Text(
                                              '${weather.last.airTemperature}°C',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleMedium!
                                                  .copyWith(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(width: 16),
                                        Row(
                                          children: [
                                            Text('Humidity',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .labelLarge),
                                            SizedBox(width: 8),
                                            Text(
                                              '${weather.last.humidity}%',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleMedium!
                                                  .copyWith(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Row(
                                          children: [
                                            Text('Track Temp.',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .labelLarge),
                                            SizedBox(width: 8),
                                            Text(
                                              '${weather.last.trackTemperature}°C',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleMedium!
                                                  .copyWith(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(width: 16),
                                        Row(
                                          children: [
                                            Text('Wind',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .labelLarge),
                                            SizedBox(width: 8),
                                            Text(
                                              '${weather.last.windSpeed} km/h',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleMedium!
                                                  .copyWith(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Spacer(),
                            SizedBox(
                              height: 50,
                              child: Obx(
                                () => LineChart(
                                  LineChartData(
                                    gridData: FlGridData(show: false),
                                    titlesData: FlTitlesData(show: false),
                                    borderData: FlBorderData(show: false),
                                    lineBarsData: [
                                      LineChartBarData(
                                        spots: weather
                                            .asMap()
                                            .entries
                                            .map((e) => FlSpot(e.key.toDouble(),
                                                e.value.trackTemperature))
                                            .toList(),
                                        isCurved: true,
                                        color: Colors.blue,
                                        barWidth: 2,
                                        isStrokeCapRound: true,
                                        belowBarData: BarAreaData(show: false),
                                        dotData: FlDotData(show: false),
                                      ),
                                      LineChartBarData(
                                        spots: weather
                                            .asMap()
                                            .entries
                                            .map((e) => FlSpot(e.key.toDouble(),
                                                e.value.airTemperature))
                                            .toList(),
                                        isCurved: true,
                                        color: Colors.red,
                                        barWidth: 2,
                                        isStrokeCapRound: true,
                                        belowBarData: BarAreaData(show: false),
                                        dotData: FlDotData(show: false),
                                      ),
                                    ],
                                    minX: 0,
                                    maxX: weather.length.toDouble() - 1,
                                  ),
                                  duration: const Duration(milliseconds: 250),
                                ),
                              ),
                            ),
                          ],
                        ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

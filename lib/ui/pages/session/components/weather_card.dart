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

  String _getWeatherCondition(WeatherEntity data) {
    if (data.rainfall > 0) {
      return 'Rainy';
    } else if (data.humidity > 80) {
      return 'Humid';
    } else if (data.humidity < 30) {
      return 'Dry';
    } else {
      return 'Clear';
    }
  }

  IconData _getWeatherIcon(WeatherEntity data) {
    if (data.rainfall > 0) {
      return Icons.water_drop;
    } else if (data.humidity > 80) {
      return Icons.cloud;
    } else if (data.humidity < 30) {
      return Icons.wb_sunny;
    } else {
      return Icons.cloud_queue;
    }
  }

  Color _getWeatherColor(WeatherEntity data) {
    if (data.rainfall > 0) {
      return Colors.blue;
    } else if (data.humidity > 80) {
      return Colors.blueGrey;
    } else if (data.humidity < 30) {
      return Colors.orange;
    } else {
      return Colors.lightBlue;
    }
  }

  double _calculateRainProbability(WeatherEntity data) {
    // Simple algorithm to estimate rain probability
    // based on humidity and pressure
    double probability = (data.humidity / 100) * 0.7;
    // Lower pressure often indicates higher chance of rain
    double pressureFactor = (1010 - data.pressure) / 50;
    probability += pressureFactor > 0 ? pressureFactor : 0;
    // Cap at 100%
    return (probability * 100).clamp(0, 100);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
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
                padding: EdgeInsets.all(12),
                child: Obx(
                  () => weather.isEmpty
                      ? Center(
                          child: Text('No DATA'),
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // Weather condition
                                Row(
                                  children: [
                                    Icon(
                                      _getWeatherIcon(weather.last),
                                      color: _getWeatherColor(weather.last),
                                      size: 28,
                                    ),
                                    SizedBox(width: 8),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          _getWeatherCondition(weather.last),
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium!
                                              .copyWith(
                                                fontWeight: FontWeight.bold,
                                              ),
                                        ),
                                        Text(
                                          '${_calculateRainProbability(weather.last).toStringAsFixed(0)}% chance of rain',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),

                                // Temperature group
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Row(
                                      children: [
                                        Text('Air: ',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall),
                                        Text(
                                          '${weather.last.airTemperature}°C',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium!
                                              .copyWith(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.red,
                                              ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text('Track: ',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall),
                                        Text(
                                          '${weather.last.trackTemperature}°C',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium!
                                              .copyWith(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.blue,
                                              ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),

                            SizedBox(height: 8),

                            // Weather details
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Icon(Icons.water_outlined, size: 16),
                                    SizedBox(width: 4),
                                    Text(
                                      '${weather.last.humidity}%',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium,
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Icon(Icons.air, size: 16),
                                    SizedBox(width: 4),
                                    Text(
                                      '${weather.last.windSpeed} km/h',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium,
                                    ),
                                  ],
                                ),
                                if (weather.last.rainfall > 0)
                                  Row(
                                    children: [
                                      Icon(Icons.beach_access, size: 16),
                                      SizedBox(width: 4),
                                      Text(
                                        '${weather.last.rainfall} mm',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium,
                                      ),
                                    ],
                                  ),
                              ],
                            ),

                            Spacer(),

                            // Temperature chart
                            SizedBox(
                              height: 40,
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
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                    width: 8, height: 2, color: Colors.red),
                                SizedBox(width: 4),
                                Text('Air',
                                    style:
                                        Theme.of(context).textTheme.bodySmall),
                                SizedBox(width: 8),
                                Container(
                                    width: 8, height: 2, color: Colors.blue),
                                SizedBox(width: 4),
                                Text('Track',
                                    style:
                                        Theme.of(context).textTheme.bodySmall),
                              ],
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

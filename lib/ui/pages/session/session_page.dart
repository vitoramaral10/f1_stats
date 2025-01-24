import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../domain/entities/entities.dart';
import '../../../presentation/presenters/presenters.dart';
import '../pages.dart';

class SessionPage extends GetView<GetxSessionPresenter> {
  const SessionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(controller.session.sessionName),
      ),
      body: Column(
        children: [
          Row(
            children: [
              Expanded(
                  child: RaceControlCard(raceControl: controller.raceControl)),
              Expanded(child: WeatherCard(weather: controller.weather)),
            ],
          ),
          Expanded(child: StandingsWidget(standing: controller.standings)),
        ],
      ),
    );
  }
}

class StandingsWidget extends StatelessWidget {
  final List<StandingEntity> standing;

  const StandingsWidget({
    super.key,
    required this.standing,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Obx(
          () => Table(
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            border: TableBorder(
              verticalInside: BorderSide(color: Colors.grey),
            ),
            columnWidths: {
              0: FlexColumnWidth(9),
              1: FlexColumnWidth(18),
              2: FlexColumnWidth(27),
              3: FlexColumnWidth(27),
              4: FlexColumnWidth(27),
              5: FlexColumnWidth(27),
              6: FlexColumnWidth(45),
              7: FlexColumnWidth(27),
              8: FlexColumnWidth(27),
              9: FlexColumnWidth(27),
              10: FlexColumnWidth(27),
            },
            children: [
              TableRow(
                children: [
                  Center(child: Text('')),
                  Center(child: Text('')),
                  Center(child: Text('GAP')),
                  Center(child: Text('INTERVAL')),
                  Center(child: Text('LAST LAP')),
                  Center(child: Text('')),
                  Center(child: Text('')),
                  Center(child: Text('')),
                  Center(child: Text('1')),
                  Center(child: Text('2')),
                  Center(child: Text('3')),
                ],
              ),
              for (var driver in standing)
                TableRow(
                  children: [
                    Center(child: Text(driver.position.toString())),
                    Center(child: Text(driver.driverAcronym)),
                    Center(child: Text(_formatDuration(driver.gap))),
                    Center(child: Text(_formatDuration(driver.interval))),
                    Center(child: Text(_formatDuration(driver.lastLap))),
                    Center(
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.green),
                          borderRadius: BorderRadius.circular(4),
                          color: driver.drs ? Colors.green : Colors.transparent,
                        ),
                        child: Text('DRS',
                            style: TextStyle(
                                color:
                                    driver.drs ? Colors.white : Colors.green)),
                      ),
                    ),
                    Center(child: Text('')),
                    Center(child: Text(driver.driverLastName)),
                    Center(child: Text(_formatDuration(driver.firstSector))),
                    Center(child: Text(_formatDuration(driver.secondSector))),
                    Center(child: Text(_formatDuration(driver.thirdSector))),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatDuration(dynamic duration) {
    if (duration == null) {
      return '';
    }
    if (duration is String) {
      return duration;
    }

    duration = Duration(milliseconds: (duration * 1000).toInt());

    // formats: mm:ss.SSS or ss.SSS
    final formatterWithMinutes = DateFormat('mm:ss.SSS');
    final formatterWithoutMinutes = DateFormat('ss.SSS');

    return duration.inMinutes > 0
        ? formatterWithMinutes
            .format(DateTime(0, 0, 0, 0, 0, 0, duration.inMilliseconds))
        : formatterWithoutMinutes
            .format(DateTime(0, 0, 0, 0, 0, 0, duration.inMilliseconds));
  }
}

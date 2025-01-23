import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';

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
    return Obx(
      () => Card(
        child: Padding(
          padding: EdgeInsets.all(8),
          child: Table(
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            border: TableBorder(
              verticalInside: BorderSide(color: Colors.grey),
            ),
            columnWidths: {
              0: FlexColumnWidth(1),
              1: FlexColumnWidth(1),
              2: FlexColumnWidth(2),
              3: FlexColumnWidth(2),
              4: FlexColumnWidth(2),
              5: FlexColumnWidth(1),
              6: FlexColumnWidth(30),
              7: FlexColumnWidth(3),
              8: FlexColumnWidth(2),
              9: FlexColumnWidth(2),
              10: FlexColumnWidth(2),
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
                    Center(child: Text('LEADER')),
                    Center(child: Text('+3.023')),
                    Center(child: Text('1:23.456')),
                    Center(
                      child: Text('DRS', style: TextStyle(color: Colors.green)),
                    ),
                    Center(child: Text('')),
                    Center(child: Text('VERSTAPPEN')),
                    Center(child: Text('22.271')),
                    Center(child: Text('39.570')),
                    Center(child: Text('42.271')),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}

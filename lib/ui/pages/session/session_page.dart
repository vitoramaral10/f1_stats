import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
              WeatherCard(weather: controller.weather),
            ],
          ),
          Expanded(
              child: Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: SingleChildScrollView(
                child: Table(
                  columnWidths: {
                    0: FlexColumnWidth(1),
                    1: FlexColumnWidth(3),
                    2: FlexColumnWidth(3),
                    3: FlexColumnWidth(3),
                    4: FlexColumnWidth(3),
                    5: FlexColumnWidth(5),
                    6: FlexColumnWidth(5),
                    7: FlexColumnWidth(5),
                    8: FlexColumnWidth(3),
                    9: FlexColumnWidth(3),
                    10: FlexColumnWidth(3),
                    11: FlexColumnWidth(3),
                    12: FlexColumnWidth(3),
                  },
                  children: [
                    TableRow(
                      children: [
                        TableCell(child: Container()),
                        TableCell(child: Container()),
                        TableCell(child: Text('LAP TIME')),
                        TableCell(child: Text('GAP')),
                        TableCell(child: Text('CURRENT')),
                        TableCell(child: Text('SECTOR 1')),
                        TableCell(child: Text('SECTOR 2')),
                        TableCell(child: Text('SECTOR 3')),
                        TableCell(child: Container()),
                        TableCell(child: Text('1')),
                        TableCell(child: Text('2')),
                        TableCell(child: Text('3')),
                      ],
                    ),
                    ...controller.positions.map(
                      (position) => TableRow(
                        children: [
                          TableCell(child: Text(position.position.toString())),
                          TableCell(
                              child: Text(controller.drivers
                                  .firstWhere((driver) =>
                                      driver.driverNumber ==
                                      position.driverNumber)
                                  .broadcastName)),
                          TableCell(child: Text('1:36.584')),
                          TableCell(child: Text('LEADER')),
                          TableCell(
                            child: RichText(
                              text: TextSpan(
                                text: 'S',
                                style: TextStyle(color: Colors.red),
                                children: [
                                  TextSpan(
                                    text: '   ',
                                    style: TextStyle(color: Colors.red),
                                  ),
                                  TextSpan(
                                    text: 'PIT',
                                    style: TextStyle(color: Colors.red),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          TableCell(child: Text('1:36.584')),
                          TableCell(child: Text('1:36.584')),
                          TableCell(child: Text('1:36.584')),
                          TableCell(child: Text('1:36.584')),
                          TableCell(child: Text('1:36.584')),
                          TableCell(child: Text('1:36.584')),
                          TableCell(child: Text('1:36.584')),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )),
        ],
      ),
    );
  }
}

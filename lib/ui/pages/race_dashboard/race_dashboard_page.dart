import 'package:f1_stats/domain/entities/entities.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../presentation/presenters/presenters.dart';
import '../../helpers/helpers.dart';

class RaceDashboardPage extends GetView<GetxRaceDashboardPresenter> {
  const RaceDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(
          () => Row(
            children: [
              Text(
                controller.meeting?.meetingOfficialName ?? '',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Spacer(),
              Text(
                'LAP 54/70',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.black,
      body: FutureBuilder(
          future: controller.loadLatestMeeting(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              if (snapshot.error is UiError) {
                return Center(
                  child: Text((snapshot.error! as UiError).description),
                );
              } else {
                return const Center(
                  child: Text('Erro inesperado'),
                );
              }
            }

            if (controller.meeting == null) {
              return const Center(
                child: Text('No meeting found'),
              );
            }

            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: FutureBuilder(
                  future: controller.startLiveUpdates(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (snapshot.hasError) {
                      if (snapshot.error is UiError) {
                        return Center(
                          child: Column(
                            children: [
                              Text((snapshot.error! as UiError).description),
                              SizedBox(height: 16),
                              ElevatedButton(
                                onPressed: () async {
                                  try {
                                    await controller.startLiveUpdates();
                                  } catch (e) {
                                    // ignore: avoid_print
                                  }
                                },
                                child: const Text('Tentar novamente'),
                              ),
                            ],
                          ),
                        );
                      } else {
                        return const Center(
                          child: Text('Erro inesperado'),
                        );
                      }
                    }

                    if (controller.meeting == null) {
                      return const Center(
                        child: Text('No meeting found'),
                      );
                    }
                    return Obx(() => DriversList(
                          drivers: controller.drivers,
                          latestPositions: controller.latestPositions,
                          firstPositions: controller.firstPositions,
                          intervals: controller.intervals,
                        ));
                  }),
            );
          }),
    );
  }
}

class DriversList extends StatelessWidget {
  final List<DriverEntity> drivers;
  final List<PositionEntity> latestPositions;
  final List<PositionEntity> firstPositions;
  final List<IntervalEntity> intervals;

  const DriversList({
    super.key,
    required this.drivers,
    required this.latestPositions,
    required this.firstPositions,
    required this.intervals,
  });

  @override
  Widget build(BuildContext context) {
    return Table(
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      border: TableBorder(
        verticalInside: BorderSide(
          color: Colors.grey,
          width: 1,
        ),
        bottom: BorderSide(
          color: Colors.grey,
          width: 1,
        ),
      ),
      columnWidths: const {
        0: FixedColumnWidth(32),
        1: FixedColumnWidth(80),
        2: FixedColumnWidth(72),
        3: FixedColumnWidth(80),
        4: FixedColumnWidth(80),
        5: FixedColumnWidth(80),
        6: FixedColumnWidth(64),
        7: FlexColumnWidth(),
        8: FixedColumnWidth(80),
        9: FixedColumnWidth(80),
        10: FixedColumnWidth(80),
      },
      children: [
        TableRow(
          children: [
            TableCell(
              child: Center(child: Text('')),
            ),
            TableCell(
              child: Center(child: Text('')),
            ),
            TableCell(
              child: Center(child: Text('')),
            ),
            TableCell(
              child: Center(child: Text('GAP')),
            ),
            TableCell(
              child: Center(child: Text('INTERVAL')),
            ),
            TableCell(
              child: Center(child: Text('LAST LAP')),
            ),
            TableCell(
              child: Center(child: Text('')),
            ),
            TableCell(
              child: Center(child: Text('')),
            ),
            TableCell(
              child: Center(child: Text('1')),
            ),
            TableCell(
              child: Center(child: Text('2')),
            ),
            TableCell(
              child: Center(child: Text('3')),
            ),
          ],
        ),
        ...latestPositions.map(
          (position) {
            final driver = drivers.firstWhere(
              (element) => element.driverNumber == position.driverNumber,
            );

            IntervalEntity interval = IntervalEntity(
                meetingKey: 0,
                date: DateTime.now(),
                sessionKey: 0,
                driverNumber: 0,
                gapToLeader: 0,
                interval: 0);

            if (intervals.isNotEmpty) {
              interval = intervals.firstWhere(
                (element) => element.driverNumber == position.driverNumber,
                orElse: () => IntervalEntity(
                  meetingKey: 0,
                  date: DateTime.now(),
                  sessionKey: 0,
                  driverNumber: position.driverNumber,
                  gapToLeader: 'OUT',
                  interval: '',
                ),
              );
            }

            final gainPosition = -((position.position -
                firstPositions
                    .firstWhere(
                      (element) =>
                          element.driverNumber == position.driverNumber,
                    )
                    .position));

            return TableRow(
              children: [
                TableCell(
                  child: Center(
                    child: Text(
                      position.position.toString(),
                    ),
                  ),
                ),
                TableCell(
                  child: Center(
                    child: Row(
                      children: [
                        SizedBox(width: 8),
                        Image.network(
                          driver.teamLogo,
                          width: 24,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          driver.nameAcronym,
                        ),
                      ],
                    ),
                  ),
                ),
                TableCell(
                  child: Center(
                    child: Row(
                      children: [
                        SizedBox(width: 8),
                        if (gainPosition > 0)
                          Transform.rotate(
                              angle: 1.5708,
                              child: Icon(Icons.arrow_back_ios_new,
                                  color: Colors.green))
                        else
                          (gainPosition < 0)
                              ? Transform.rotate(
                                  angle: 4.71239,
                                  child: Icon(Icons.arrow_back_ios_new,
                                      color: Colors.red))
                              : Icon(Icons.remove),
                        const SizedBox(width: 8),
                        Text(
                          gainPosition.toString(),
                        ),
                      ],
                    ),
                  ),
                ),
                TableCell(
                  child: Center(
                    child: Text(
                      (interval.gapToLeader == 0)
                          ? 'LEADER'
                          : (interval.gapToLeader == null)
                              ? '-'
                              : interval.gapToLeader.toString(),
                    ),
                  ),
                ),
                TableCell(
                  child: Center(
                    child: Text(
                      (interval.interval == 0 ||
                              interval.interval.runtimeType == String)
                          ? ''
                          : interval.interval.toString(),
                    ),
                  ),
                ),
                TableCell(
                  child: Center(
                    child: Text(
                      '1:12.000',
                    ),
                  ),
                ),
                TableCell(
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    margin: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      // color: Colors.green,
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(color: Colors.green, width: 2),
                    ),
                    child: Center(
                      child: Center(
                        child: Text(
                          'DRS',
                          style: const TextStyle(
                              color: Colors.green, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ),
                TableCell(
                  child: Center(
                    child: Text(
                      'PIT',
                      style: const TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ),
                TableCell(
                  child: Center(
                    child: Text(
                      '26.966',
                      style: const TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ),
                TableCell(
                  child: Center(
                    child: Text(
                      '26.966',
                      style: const TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ),
                TableCell(
                  child: Center(
                    child: Text(
                      '26.966',
                      style: const TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}

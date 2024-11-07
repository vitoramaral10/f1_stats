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

            return Obx(() => Column(
                  children: [
                    Header(meeting: controller.meeting!),
                    Expanded(
                        child: SingleChildScrollView(
                      padding: const EdgeInsets.all(16),
                      child: DriversList(
                        drivers: controller.drivers,
                        latestPositions: controller.latestPositions,
                        firstPositions: controller.firstPositions,
                      ),
                    )),
                  ],
                ));
          }),
    );
  }
}

class Header extends StatelessWidget {
  final MeetingEntity meeting;
  const Header({
    super.key,
    required this.meeting,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Row(
        children: [
          Text(
            meeting.meetingOfficialName,
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
    );
  }
}

class DriversList extends StatelessWidget {
  final List<DriverEntity> drivers;
  final List<PositionEntity> latestPositions;
  final List<PositionEntity> firstPositions;

  const DriversList({
    super.key,
    required this.drivers,
    required this.latestPositions,
    required this.firstPositions,
  });

  @override
  Widget build(BuildContext context) {
    return Table(
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      columnWidths: const {
        0: FixedColumnWidth(24),
        1: FixedColumnWidth(72),
        2: FixedColumnWidth(64),
        3: FixedColumnWidth(72),
        4: FixedColumnWidth(72),
        5: FixedColumnWidth(72),
        6: FixedColumnWidth(48),
        7: FlexColumnWidth(),
        8: FixedColumnWidth(72),
        9: FixedColumnWidth(72),
        10: FixedColumnWidth(72),
      },
      children: [
        TableRow(
          children: [
            TableCell(
              child: Text(''),
            ),
            TableCell(
              child: Text(''),
            ),
            TableCell(
              child: Text(''),
            ),
            TableCell(
              child: Text('GAP'),
            ),
            TableCell(
              child: Text('INTERVAL'),
            ),
            TableCell(
              child: Text('LAST LAP'),
            ),
            TableCell(
              child: Text(''),
            ),
            TableCell(
              child: Text(''),
            ),
            TableCell(
              child: Text('1'),
            ),
            TableCell(
              child: Text('2'),
            ),
            TableCell(
              child: Text('3'),
            ),
          ],
        ),
        ...latestPositions.map(
          (position) {
            final driver = drivers.firstWhere(
              (element) => element.driverNumber == position.driverNumber,
            );

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
                  child: Text(
                    position.position.toString(),
                  ),
                ),
                TableCell(
                  child: Row(
                    children: [
                      // Icone da Equipe (Placeholder)
                      const Icon(Icons.circle, color: Colors.orange, size: 16),
                      const SizedBox(width: 8),
                      Text(
                        driver.nameAcronym,
                      ),
                    ],
                  ),
                ),
                TableCell(
                  child: Row(
                    children: [
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
                TableCell(
                  child: Text(
                    'LEADER',
                  ),
                ),
                TableCell(
                  child: Text(
                    '+0.000',
                  ),
                ),
                TableCell(
                  child: Text(
                    '1:12.000',
                  ),
                ),
                TableCell(
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      // color: Colors.green,
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(color: Colors.green, width: 2),
                    ),
                    child: Center(
                      child: Text(
                        'DRS',
                        style: const TextStyle(
                            color: Colors.green, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                TableCell(
                  child: Text(
                    'PIT',
                    style: const TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
                TableCell(
                  child: Text(
                    '26.966',
                    style: const TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
                TableCell(
                  child: Text(
                    '26.966',
                    style: const TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
                TableCell(
                  child: Text(
                    '26.966',
                    style: const TextStyle(color: Colors.white, fontSize: 16),
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

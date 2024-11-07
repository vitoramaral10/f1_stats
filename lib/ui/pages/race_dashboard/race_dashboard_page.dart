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

            return Column(
              children: [
                Header(meeting: controller.meeting!),
                Expanded(
                    child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: DriversList(
                      drivers: controller.drivers,
                      positions: controller.positions),
                )),
              ],
            );
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
  final List<PositionEntity> positions;

  const DriversList({
    super.key,
    required this.drivers,
    required this.positions,
  });

  @override
  Widget build(BuildContext context) {
    return Table(
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      columnWidths: const {
        0: FixedColumnWidth(24),
        1: FlexColumnWidth(1),
        2: FlexColumnWidth(1),
        3: FlexColumnWidth(1),
        4: FlexColumnWidth(1),
        5: FixedColumnWidth(48),
        6: FlexColumnWidth(0.5),
        7: FlexColumnWidth(0.5),
        8: FlexColumnWidth(0.5),
        9: FlexColumnWidth(0.5),
        10: FlexColumnWidth(0.5),
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
        ...positions.map(
          (position) {
            final driver = drivers.firstWhere(
              (element) => element.driverNumber == position.driverNumber,
            );

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

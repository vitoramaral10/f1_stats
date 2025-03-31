import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../domain/entities/entities.dart';

class StandingsCard extends StatelessWidget {
  final SessionEntity session;
  final List<DriverEntity> drivers;
  final List<IntervalEntity> intervals;
  final List<LapEntity> laps;

  const StandingsCard({
    super.key,
    required this.session,
    required this.drivers,
    required this.intervals,
    required this.laps,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Obx(
          () => Table(
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            columnWidths: const {
              0: FixedColumnWidth(1),
              1: FixedColumnWidth(1),
              2: FixedColumnWidth(1),
              3: FixedColumnWidth(1),
            },
            children: List.generate(
              drivers.length,
              (index) {
                final driver = drivers[index];
                return TableRow(
                  children: [
                    Text(
                      (index + 1).toString(),
                      textAlign: TextAlign.center,
                    ),
                    Row(
                      children: [
                        Container(
                          width: 4,
                          height: 24,
                          color: driver.teamColour,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 4.0, horizontal: 8.0),
                          child: Text(driver.nameAcronym),
                        ),
                      ],
                    ),
                    Text(
                      session.sessionType == 'Race'
                          ? (intervals
                                  .firstWhereOrNull((i) =>
                                      i.driverNumber == driver.driverNumber)
                                  ?.interval
                                  .toString() ??
                              '')
                          : (laps
                                  .firstWhereOrNull((l) =>
                                      l.driverNumber == driver.driverNumber)
                                  ?.lapDuration
                                  .toString() ??
                              ''),
                    ),
                    Text(
                      intervals
                              .firstWhereOrNull(
                                  (i) => i.driverNumber == driver.driverNumber)
                              ?.gapToLeader
                              .toString() ??
                          '',
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

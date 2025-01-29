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
      body: const Column(
        children: [
          SessionHeader(),
          Expanded(child: StandingsWidget()),
        ],
      ),
    );
  }
}

class SessionHeader extends GetView<GetxSessionPresenter> {
  const SessionHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: RaceControlCard(raceControl: controller.raceControl)),
        WeatherCard(weather: controller.weather),
      ],
    );
  }
}

class StandingsWidget extends GetView<GetxSessionPresenter> {
  const StandingsWidget({super.key});

  static const _columnWidths = {
    0: FlexColumnWidth(9), // Position
    1: FlexColumnWidth(18), // Acronym
    2: FlexColumnWidth(27), // Gap
    3: FlexColumnWidth(27), // Interval
    4: FlexColumnWidth(27), // Last Lap
    5: FlexColumnWidth(27), // DRS
    6: FlexColumnWidth(45), // Spacer
    7: FlexColumnWidth(27), // Name
    8: FlexColumnWidth(27), // S1
    9: FlexColumnWidth(27), // S2
    10: FlexColumnWidth(27), // S3
  };

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Obx(
          () => Table(
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            border: const TableBorder(
              verticalInside: BorderSide(color: Colors.grey),
            ),
            columnWidths: _columnWidths,
            children: [
              _buildHeader(),
              ...controller.standings.map((driver) => _buildRow(driver)),
            ],
          ),
        ),
      ),
    );
  }

  TableRow _buildHeader() {
    return const TableRow(
      children: [
        TableCell(child: SizedBox()), // Position
        TableCell(child: SizedBox()), // Acronym
        CenteredText('GAP'),
        CenteredText('INTERVAL'),
        CenteredText('LAST LAP'),
        TableCell(child: SizedBox()), // DRS
        TableCell(child: SizedBox()), // Spacer
        TableCell(child: SizedBox()), // Name
        CenteredText('S1'),
        CenteredText('S2'),
        CenteredText('S3'),
      ],
    );
  }

  TableRow _buildRow(StandingEntity driver) {
    return TableRow(
      children: [
        CenteredText(driver.position.toString()),
        CenteredText(driver.driverAcronym),
        CenteredText(TimeFormatter.format(driver.gap)),
        CenteredText(TimeFormatter.format(driver.interval)),
        CenteredText(TimeFormatter.format(driver.lastLap)),
        DRSIndicator(active: driver.drs),
        const TableCell(child: SizedBox()), // Spacer
        CenteredText(driver.driverLastName),
        CenteredText(TimeFormatter.format(driver.firstSector)),
        CenteredText(TimeFormatter.format(driver.secondSector)),
        CenteredText(TimeFormatter.format(driver.thirdSector)),
      ],
    );
  }
}

// Remover a classe StandingsHeader que não é mais necessária

// Remove the StandingsRow class as it's no longer needed

class CenteredText extends StatelessWidget {
  final String text;

  const CenteredText(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return TableCell(
      child: Center(child: Text(text)),
    );
  }
}

class DRSIndicator extends StatelessWidget {
  final bool active;

  const DRSIndicator({super.key, required this.active});

  @override
  Widget build(BuildContext context) {
    return TableCell(
      child: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.green),
            borderRadius: BorderRadius.circular(4),
            color: active ? Colors.green : Colors.transparent,
          ),
          child: Text(
            'DRS',
            style: TextStyle(
              color: active ? Colors.white : Colors.green,
            ),
          ),
        ),
      ),
    );
  }
}

class TimeFormatter {
  static String format(dynamic duration) {
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

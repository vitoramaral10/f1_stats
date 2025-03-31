import 'package:f1_stats/domain/entities/entities.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class RaceControlCard extends StatelessWidget {
  final List<RaceControlEntity> raceControl;

  const RaceControlCard({
    super.key,
    required this.raceControl,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 350,
      height: 300,
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Icon(Icons.campaign, color: Theme.of(context).primaryColor),
                  const SizedBox(width: 8),
                  Text(
                    'Race Control',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ],
              ),
            ),
            const Divider(height: 1),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Obx(
                  () => ListView.separated(
                    itemCount: raceControl.length,
                    separatorBuilder: (context, index) =>
                        const Divider(height: 4),
                    itemBuilder: (context, index) {
                      final item = raceControl[index];
                      return RaceControlMessageItem(item: item);
                    },
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

class RaceControlMessageItem extends StatelessWidget {
  final RaceControlEntity item;

  const RaceControlMessageItem({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              if (item.flag != null) FlagIndicator(flag: item.flag!),
              const SizedBox(width: 4),
              if (item.driverNumber != null)
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: Colors.grey[600],
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    '#${item.driverNumber}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              const SizedBox(width: 4),
              if (item.lapNumber != null)
                Text(
                  'Lap ${item.lapNumber}',
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
              if (item.sector != null)
                Padding(
                  padding: const EdgeInsets.only(left: 4),
                  child: Text(
                    'S${item.sector}',
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ),
              const Spacer(),
              Text(
                DateFormat('HH:mm:ss').format(item.date),
                style: const TextStyle(fontSize: 11, color: Colors.grey),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            item.message,
            style: TextStyle(
              fontWeight: _isImportantMessage(item.message)
                  ? FontWeight.bold
                  : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }

  bool _isImportantMessage(String message) {
    final importantKeywords = [
      'incident',
      'penalty',
      'investigation',
      'crash',
      'safety car',
      'red flag',
      'session',
      'stopped',
      'resumed'
    ];
    return importantKeywords.any(
        (keyword) => message.toLowerCase().contains(keyword.toLowerCase()));
  }
}

class FlagIndicator extends StatelessWidget {
  final String flag;

  const FlagIndicator({
    super.key,
    required this.flag,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 16,
      height: 16,
      decoration: BoxDecoration(
        color: _getFlagColor(),
        border: Border.all(color: Colors.black, width: 0.5),
        borderRadius: BorderRadius.circular(2),
      ),
      child: flag.contains('CHEQUERED')
          ? CustomPaint(painter: ChequeredFlagPainter())
          : null,
    );
  }

  Color _getFlagColor() {
    if (flag.contains('GREEN') || flag.contains('CLEAR')) {
      return Colors.green;
    } else if (flag.contains('YELLOW')) {
      return Colors.yellow;
    } else if (flag.contains('CHEQUERED')) {
      return Colors.white;
    } else if (flag.contains('BLUE')) {
      return Colors.blue;
    } else if (flag.contains('RED')) {
      return Colors.red;
    } else if (flag.contains('WHITE')) {
      return Colors.white;
    } else {
      return Colors.grey;
    }
  }
}

class ChequeredFlagPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.fill;

    final squareSize = size.width / 4;

    for (int i = 0; i < 4; i++) {
      for (int j = 0; j < 4; j++) {
        if ((i + j) % 2 == 0) {
          canvas.drawRect(
            Rect.fromLTWH(
                i * squareSize, j * squareSize, squareSize, squareSize),
            paint,
          );
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

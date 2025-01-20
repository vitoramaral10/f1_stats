import 'package:f1_stats/domain/entities/entities.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RaceControlCard extends StatelessWidget {
  final List<RaceControlEntity> raceControl;

  const RaceControlCard({
    super.key,
    required this.raceControl,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Text(
            'Race Control',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          Divider(),
          SizedBox(
            height: 200,
            child: Obx(
              () => ListView.builder(
                itemCount: raceControl.length,
                itemBuilder: (context, index) {
                  final item = raceControl[index];
                  return Container(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: Colors.grey),
                      ),
                    ),
                    child: Row(
                      children: [
                        if (item.flag != null)
                          Icon(
                            Icons.flag,
                            color: item.flag!.contains('GREEN') ||
                                    item.flag!.contains('CLEAR')
                                ? Colors.green
                                : item.flag!.contains('YELLOW')
                                    ? Colors.yellow
                                    : item.flag!.contains('CHEQUERED')
                                        ? Colors.black
                                        : item.flag!.contains('BLUE')
                                            ? Colors.blue
                                            : item.flag!.contains('RED')
                                                ? Colors.red
                                                : null,
                          ),
                        SizedBox(width: 8),
                        Expanded(child: Text(item.message)),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

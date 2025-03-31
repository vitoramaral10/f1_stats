import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../domain/entities/entities.dart';

class StandingsCard extends StatelessWidget {
  final List<DriverEntity> drivers;

  const StandingsCard({
    super.key,
    required this.drivers,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Obx(
          () => ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: drivers.length,
            itemBuilder: (context, index) {
              final driver = drivers[index];
              return Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 4.0,
                ),
                child: Row(
                  children: [
                    SizedBox(
                      width: 16,
                      child: Text(
                        (index + 1).toString(),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(width: 8),
                    Container(
                      width: 4,
                      height: 24,
                      color: driver.teamColour,
                    ),
                    SizedBox(width: 8),
                    Text(driver.nameAcronym),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

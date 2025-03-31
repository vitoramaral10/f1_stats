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
          child: Obx(() => ListView(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                children: drivers
                    .map(
                      (driver) => ListTile(
                        title: Row(
                          children: [
                            Container(
                              width: 4,
                              height: 24,
                              color: driver.teamColour,
                            ),
                            SizedBox(width: 8),
                            Text(driver.nameAcronym),
                          ],
                        ),
                      ),
                    )
                    .toList(),
              ))),
    );
  }
}

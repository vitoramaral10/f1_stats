import 'package:flutter/material.dart';

import '../../domain/entities/entities.dart';
import '../pages/drivers/components/components.dart';

mixin MergeDriversManager {
  void openMergeDrivers(BuildContext context, List<DriverEntity> drivers) {
    showDialog(
      context: context,
      builder: (context) {
        return MergeDriversDialog();
      },
    );
  }
}

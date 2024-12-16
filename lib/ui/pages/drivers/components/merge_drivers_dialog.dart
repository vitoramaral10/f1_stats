import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../presentation/presenters/presenters.dart';

class MergeDriversDialog extends GetView<GetxDriversController> {
  const MergeDriversDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Merge drivers'),
      content: Text('Are you sure you want to merge the selected drivers?'),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Cancel'),
        ),
        TextButton(
          onPressed: () async {
            await controller.mergeDrivers();

            Get.back();
          },
          child: Text('Merge'),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../presentation/presenters/presenters.dart';

class HomePage extends GetView<GetxHomePresenter> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('F1 Stats'),
      ),
      body: Obx(
        () => ListView.builder(
          itemCount: controller.meetings.length,
          itemBuilder: (context, index) {
            final meeting = controller.meetings[index];
            return ListTile(
              title: Text(meeting.name),
              subtitle: Text(DateFormat.yMMMd().format(meeting.dateStart)),
            );
          },
        ),
      ),
    );
  }
}

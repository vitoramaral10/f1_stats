import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../presentation/presenters/presenters.dart';
import '../pages.dart';

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
            return MeetingTile(meeting: controller.meetings[index]);
          },
        ),
      ),
    );
  }
}

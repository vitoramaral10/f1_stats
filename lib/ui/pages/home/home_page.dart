import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../presentation/presenters/presenters.dart';
import '../../helpers/helpers.dart';
import '../pages.dart';

class HomePage extends GetView<GetxHomePresenter> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('F1 Stats'),
      ),
      body: FutureBuilder(
          future: controller.loadData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.hasError) {
              return Center(
                child: Text((snapshot.error! as UiError).description),
              );
            }
            return Obx(
              () => ListView.builder(
                key: Key(controller.selectedMeeting.toString()),
                itemCount: controller.meetings.length,
                itemBuilder: (context, index) {
                  return MeetingTile(
                    isExpanded: controller.selectedMeeting == index,
                    meeting: controller.meetings[index],
                    index: index,
                  );
                },
              ),
            );
          }),
    );
  }
}

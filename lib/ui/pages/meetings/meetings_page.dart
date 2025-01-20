import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../main/routes.dart';
import '../../../presentation/presenters/presenters.dart';

class MeetingsPage extends GetView<GetxMeetingsPresenter> {
  const MeetingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('F1 Stats'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              'Aqui você encontra todas as corridas da temporada.',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ),
          Expanded(
              child: ListView.builder(
            itemCount: controller.meetings.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text('Temporada ${2023 + index}'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  Get.toNamed('${Routes.meetings}/${2023 + index}');
                },
              );
            },
          )),
        ],
      ),
    );
  }
}

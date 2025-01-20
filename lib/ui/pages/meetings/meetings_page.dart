import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

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
            child: Obx(
              () => ListView.builder(
                itemCount: controller.meetings.length,
                itemBuilder: (context, index) {
                  final meeting = controller.meetings[index];
                  return ListTile(
                    leading: CountryFlag.fromCountryCode(
                      meeting.countryCode,
                      width: 32,
                      height: 18,
                    ),
                    title: Text(meeting.meetingName),
                    subtitle: Text(
                      '${meeting.location} - ${DateFormat.yMMMd().add_jm().format(meeting.dateStart)}',
                    ),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () {
                      Get.toNamed('${Routes.sessions}/${meeting.meetingKey}');
                    },
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

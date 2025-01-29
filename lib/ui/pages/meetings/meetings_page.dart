import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../domain/entities/meeting_entity.dart';
import '../../../main/routes.dart';
import '../../../presentation/presenters/presenters.dart';

class MeetingsPage extends GetView<GetxMeetingsPresenter> {
  static const String pageDescription =
      'Aqui você encontra todas as corridas da temporada.';

  const MeetingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${controller.year} Season'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              pageDescription,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ),
          Expanded(
            child: Obx(
              () => controller.isLoading.value
                  ? const Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      itemCount: controller.meetings.length,
                      itemBuilder: (_, index) => _MeetingListTile(
                        meeting: controller.meetings[index],
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MeetingListTile extends StatelessWidget {
  final MeetingEntity meeting;

  const _MeetingListTile({required this.meeting});

  @override
  Widget build(BuildContext context) {
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
      onTap: () => Get.toNamed(
        '${Routes.sessions}/${meeting.meetingKey}',
        arguments: {"meeting": meeting},
      ),
    );
  }
}

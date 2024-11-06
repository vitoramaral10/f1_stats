import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../domain/entities/entities.dart';
import '../../../../presentation/presenters/presenters.dart';

class MeetingTile extends GetView<GetxHomePresenter> {
  final MeetingEntity meeting;
  final bool isExpanded;
  final int index;

  const MeetingTile({
    super.key,
    required this.meeting,
    required this.isExpanded,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final dateStartString = DateFormat.yMMMMEEEEd().format(meeting.dateStart);

    return Card(
      child: Obx(
        () => ExpansionTile(
          key: PageStorageKey<int>(meeting.meetingKey),
          initiallyExpanded: isExpanded,
          title: Text(meeting.meetingName),
          subtitle: Text('${meeting.location}, $dateStartString'),
          onExpansionChanged: (bool expanded) async {
            await controller.getSessions(meeting.meetingKey);

            if (expanded) {
              controller.selectedMeeting = index;
            } else {
              controller.selectedMeeting = -1;
            }
          },
          children: controller.sessions
              .map(
                (session) => ListTile(
                  title: Text(session.sessionName),
                  subtitle: Text(
                    '${DateFormat.yMMM().format(session.dateStart)}, from ${DateFormat.jm().format(session.dateStart)} to ${DateFormat.jm().format(session.dateEnd)}',
                  ),
                  // onTap: () => Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //       builder: (context) =>
                  //           DriversScreen(meeting: meeting, session: session)),
                  // ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}

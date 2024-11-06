import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../domain/entities/entities.dart';
import '../../../../presentation/presenters/presenters.dart';

class MeetingTile extends GetView<GetxHomePresenter> {
  final MeetingEntity meeting;
  final int index;

  const MeetingTile({
    super.key,
    required this.meeting,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final dateStartString =
        DateFormat.yMMMMEEEEd().format(meeting.dateStart.toLocal());

    return Card(
      child: Obx(
        () => ExpansionTile(
          key: Key(meeting.meetingKey.toString()),
          initiallyExpanded: controller.selectedMeeting == meeting.meetingKey,
          title: Text(meeting.meetingName),
          subtitle: Text('${meeting.location}, $dateStartString'),
          onExpansionChanged: (bool expanded) async {
            if (expanded) {
              await controller.getSessions(meeting.meetingKey);

              controller.selectedMeeting = meeting.meetingKey;
            } else {
              controller.selectedMeeting = -1;
            }
          },
          children: controller.sessions.isEmpty
              ? [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
                ]
              : controller.sessions
                  .map(
                    (session) => ListTile(
                      title: Text(session.sessionName),
                      subtitle: Text(
                        '${DateFormat.yMMMd().format(session.dateStart.toLocal())}, '
                        'from ${DateFormat.jm().format(session.dateStart.toLocal())} '
                        'to ${DateFormat.jm().format(session.dateEnd.toLocal())}',
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

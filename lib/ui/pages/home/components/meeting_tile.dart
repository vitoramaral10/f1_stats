import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../domain/entities/entities.dart';
import '../../../../presentation/presenters/presenters.dart';

class MeetingTile extends GetView<GetxHomePresenter> {
  final MeetingEntity meeting;

  const MeetingTile({super.key, required this.meeting});

  @override
  Widget build(BuildContext context) {
    final dateStartString = DateFormat.yMMMMEEEEd().format(meeting.dateStart);

    return Card(
      child: ExpansionTile(
        key: PageStorageKey<int>(meeting.id),
        title: Text(meeting.name),
        subtitle: Text('${meeting.location}, $dateStartString'),
        onExpansionChanged: (bool expanded) {
          // _toggleExpansion(meeting.id);
        },
        children: const <Widget>[
          // FutureBuilder<List<Session>>(
          //   future: sessionsFutures[meeting.meetingKey],
          //   builder: (context, snapshot) {
          //     if (snapshot.connectionState == ConnectionState.waiting) {
          //       return const Center(child: CircularProgressIndicator());
          //     } else if (snapshot.hasError) {
          //       return Text('Error: ${snapshot.error}');
          //     } else if (snapshot.hasData) {
          //       return Column(
          //         children: snapshot.data!.map((session) {
          //           final dateString =
          //               DateFormat('MMMM d').format(session.dateStart);
          //           final startTimeString =
          //               DateFormat('HH:mm').format(session.dateStart);
          //           final endTimeString =
          //               DateFormat('HH:mm').format(session.dateEnd);

          //           return ListTile(
          //             title: Text(session.sessionName),
          //             subtitle: Text(
          //                 '$dateString, from $startTimeString to $endTimeString'),
          //             onTap: () => Navigator.push(
          //               context,
          //               MaterialPageRoute(
          //                   builder: (context) => DriversScreen(
          //                       meeting: meeting, session: session)),
          //             ),
          //           );
          //         }).toList(),
          //       );
          //     } else {
          //       return const Text('No sessions found');
          //     }
          //   },
          // ),
        ],
      ),
    );
  }
}

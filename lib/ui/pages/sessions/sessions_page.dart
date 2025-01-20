import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../main/routes.dart';
import '../../../presentation/presenters/presenters.dart';

class SessionsPage extends GetView<GetxSessionsPresenter> {
  const SessionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          controller.meeting.meetingOfficialName,
        ),
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
                itemCount: controller.sessions.length,
                itemBuilder: (context, index) {
                  final session = controller.sessions[index];
                  return ListTile(
                    leading: CountryFlag.fromCountryCode(
                      session.countryCode,
                      width: 32,
                      height: 18,
                    ),
                    title: Text(session.sessionName),
                    subtitle: Text(
                      '${session.circuitShortName} - ${DateFormat.yMMMd().format(session.dateStart)} ${DateFormat.Hm().format(session.dateStart)} - ${DateFormat.Hm().format(session.dateEnd)}',
                    ),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () {
                      Get.toNamed(Routes.session,
                          arguments: {"session": session});
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

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
        title: Text(controller.meeting.meetingOfficialName),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.red, Colors.transparent],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: Obx(
        () => controller.isLoading
            ? const Center(child: CircularProgressIndicator())
            : ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: controller.sessions.length,
                itemBuilder: (context, index) => _SessionListItem(
                  session: controller.sessions[index],
                  onTap: () => Get.toNamed(
                    Routes.session,
                    arguments: {"session": controller.sessions[index]},
                  ),
                ),
              ),
      ),
    );
  }
}

class _SessionListItem extends StatelessWidget {
  final dynamic session;
  final VoidCallback onTap;

  const _SessionListItem({
    required this.session,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: ListTile(
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
        onTap: onTap,
      ),
    );
  }
}

// Adicione esta classe no final do arquivo
class GridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 1;

    // Desenha linhas horizontais
    for (var i = 0; i < size.height; i += 20) {
      canvas.drawLine(
        Offset(0, i.toDouble()),
        Offset(size.width, i.toDouble()),
        paint,
      );
    }

    // Desenha linhas verticais
    for (var i = 0; i < size.width; i += 20) {
      canvas.drawLine(
        Offset(i.toDouble(), 0),
        Offset(i.toDouble(), size.height),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

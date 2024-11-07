import 'package:f1_stats/domain/entities/entities.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../presentation/presenters/presenters.dart';
import '../../helpers/helpers.dart';

class RaceDashboardPage extends GetView<GetxRaceDashboardPresenter> {
  const RaceDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: FutureBuilder(
          future: controller.loadLatestMeeting(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              if (snapshot.error is UiError) {
                return Center(
                  child: Text((snapshot.error! as UiError).description),
                );
              } else {
                return const Center(
                  child: Text('Erro inesperado'),
                );
              }
            }

            if (controller.meeting == null) {
              return const Center(
                child: Text('No meeting found'),
              );
            }

            return Column(
              children: [
                Header(meeting: controller.meeting!),
                Expanded(child: DriversList()),
              ],
            );
          }),
    );
  }
}

class Header extends StatelessWidget {
  final MeetingEntity meeting;
  const Header({
    super.key,
    required this.meeting,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Row(
        children: [
          Text(
            meeting.meetingOfficialName,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Spacer(),
          Text(
            'LAP 54/70',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}

class DriversList extends StatelessWidget {
  final List<Map<String, dynamic>> drivers = [
    {
      "pos": 1,
      "name": "VER",
      "gap": "LEADER",
      "interval": "0.000",
      "lastLap": "2:04.402"
    },
    {
      "pos": 2,
      "name": "SAI",
      "gap": "+0.844",
      "interval": "0.844",
      "lastLap": "2:04.223"
    },
    {
      "pos": 3,
      "name": "HAM",
      "gap": "+1.827",
      "interval": "0.983",
      "lastLap": "2:03.753"
    },
    // Adicione mais pilotos conforme necessário
  ];

  DriversList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: drivers.length,
      itemBuilder: (context, index) {
        final driver = drivers[index];
        return DriverRow(driver: driver);
      },
    );
  }
}

class DriverRow extends StatelessWidget {
  final Map<String, dynamic> driver;

  const DriverRow({super.key, required this.driver});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.grey.shade800),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            driver["pos"].toString(),
            style: const TextStyle(color: Colors.white, fontSize: 16),
          ),
          Expanded(
            child: Row(
              children: [
                // Icone da Equipe (Placeholder)
                const Icon(Icons.circle, color: Colors.orange, size: 16),
                const SizedBox(width: 8),
                Text(
                  driver["name"],
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                ),
              ],
            ),
          ),
          Text(
            driver["gap"],
            style: const TextStyle(color: Colors.white, fontSize: 16),
          ),
          Text(
            driver["interval"],
            style: const TextStyle(color: Colors.white, fontSize: 16),
          ),
          Text(
            driver["lastLap"],
            style: const TextStyle(color: Colors.white, fontSize: 16),
          ),
        ],
      ),
    );
  }
}

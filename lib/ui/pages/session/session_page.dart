import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../presentation/presenters/presenters.dart';
import '../pages.dart';

class SessionPage extends GetView<GetxSessionPresenter> {
  const SessionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(controller.session.sessionName),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            WeatherCard(weather: controller.weather),
            SizedBox(height: 8),
            RaceControlCard(raceControl: controller.raceControl),
          ],
        ),
      ),
    );
  }
}

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
      body: Column(
        children: [
          Row(
            children: [
              Expanded(
                  child: RaceControlCard(raceControl: controller.raceControl)),
              Expanded(child: WeatherCard(weather: controller.weather)),
            ],
          ),
        ],
      ),
    );
  }
}

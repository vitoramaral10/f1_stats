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
        title: Obx(
            () => Text(controller.session?.sessionName ?? 'Unknown Session')),
      ),
      body: Obx(
        () => ListView(
          children: [
            SessionTitle(session: controller.session),
            if (controller.weather != null)
              WeatherCard(weather: controller.weather),
          ],
        ),
      ),
    );
  }
}

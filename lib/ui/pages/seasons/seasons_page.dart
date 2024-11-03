import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../presentation/presenters/presenters.dart';

class SeasonsPage extends GetView<GetxSeasonsPresenter> {
  const SeasonsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Seasons'),
      ),
      body: Obx(
        () => ListView.builder(
          itemCount: controller.seasons.length,
          itemBuilder: (context, index) {
            final season = controller.seasons[index];
            return ListTile(
              title: Text('Season ${season.year}'),
              onTap: () {},
            );
          },
        ),
      ),
    );
  }
}

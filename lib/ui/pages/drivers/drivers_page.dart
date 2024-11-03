import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../presentation/presenters/presenters.dart';

class DriversPage extends GetView<GetxDriversPresenter> {
  const DriversPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Drivers'),
      ),
      body: Obx(
        () => ListView.builder(
          itemCount: controller.drivers.length,
          itemBuilder: (context, index) {
            final driver = controller.drivers[index];
            return ListTile(
              title: Text(driver.name),
              onTap: () {},
            );
          },
        ),
      ),
    );
  }
}

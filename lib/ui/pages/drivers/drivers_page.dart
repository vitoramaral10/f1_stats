import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../presentation/presenters/presenters.dart';
import '../../mixins/mixins.dart';

class DriversPage extends GetView<GetxDriversController>
    with LoadingManager, UIErrorManager, MergeDriversManager {
  const DriversPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        handleLoading(context, controller.isLoadingStream);
        handleMainError(context, controller.mainErrorStream);

        return Obx(
          () => Scaffold(
              appBar: AppBar(
                title: Text('Drivers'),
                actions: [
                  if (controller.driversSelected.isNotEmpty)
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        controller.deleteSelectedDrivers();
                      },
                    ),
                  if (controller.driversSelected.isNotEmpty)
                    IconButton(
                      icon: const Icon(Icons.deselect),
                      onPressed: () {
                        controller.driversSelected.clear();
                      },
                    ),
                  if (controller.driversSelected.isNotEmpty)
                    IconButton(
                      icon: const Icon(Icons.merge),
                      onPressed: () {
                        // Open merge dialog
                        final driversSelected = controller.driversSelected
                            .map((id) => controller.drivers
                                .firstWhere((driver) => driver.id == id))
                            .toList();

                        openMergeDrivers(context, driversSelected);
                      },
                    ),
                  // Import icon button
                  IconButton(
                    icon: const Icon(Icons.download),
                    onPressed: () async {
                      await controller.importDrivers();
                    },
                  ),
                ],
              ),
              body: ListView.builder(
                itemCount: controller.drivers.length,
                itemBuilder: (context, index) {
                  final driver = controller.drivers[index];

                  return ListTile(
                    selected: controller.driversSelected.contains(driver.id),
                    key: Key(driver.id ?? ''),
                    onLongPress: () {
                      controller.selectDriver(driver);
                    },
                    onTap: () {
                      if (controller.driversSelected.isNotEmpty) {
                        controller.selectDriver(driver);
                      } else {
                        Get.toNamed('/drivers/${driver.id}');
                      }
                    },
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(
                        driver.headshotUrl ??
                            'https://static.thenounproject.com/png/2677568-200.png',
                      ),
                    ),
                    title: Text(driver.fullName),
                    subtitle: Text(driver.seasons.toString()),
                    selectedTileColor: Colors.grey[200],
                  );
                },
              )),
        );
      },
    );
  }
}

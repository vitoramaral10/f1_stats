import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../presentation/presenters/presenters.dart';
import '../../helpers/helpers.dart';
import '../../mixins/mixins.dart';

class DriversPage extends GetView<GetxDriversController>
    with LoadingManager, UIErrorManager {
  const DriversPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        handleLoading(context, controller.isLoadingStream);
        handleMainError(context, controller.mainErrorStream);

        return Scaffold(
          appBar: AppBar(
            title: Text('Drivers'),
            actions: [
              // Import icon button
              IconButton(
                icon: const Icon(Icons.download),
                onPressed: () async {
                  try {
                    await controller.importDrivers();
                  } on UiError catch (e) {
                    Get.snackbar(
                      'Error',
                      e.description,
                      backgroundColor: Colors.red,
                    );
                  }
                },
              ),
            ],
          ),
          body: Obx(() => ListView.builder(
                itemCount: controller.drivers.length,
                itemBuilder: (context, index) {
                  final driver = controller.drivers[index];

                  return ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(
                        driver.headshotUrl ??
                            'https://static.thenounproject.com/png/2677568-200.png',
                      ),
                    ),
                    title: Text(driver.fullName),
                    subtitle: Text('aqui vai o time'),
                  );
                },
              )),
        );
      },
    );
  }
}

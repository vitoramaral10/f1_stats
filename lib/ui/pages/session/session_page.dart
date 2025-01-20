import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../presentation/presenters/presenters.dart';

class SessionPage extends GetView<GetxSessionPresenter> {
  const SessionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('F1 Stats'),
      ),
      body: Column(
        children: [
          Card(
            child: Column(
              children: [
                Text(
                  'Race Control',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Divider(),
                SizedBox(
                  height: 200,
                  child: Obx(
                    () => ListView.builder(
                      itemCount: controller.raceControl.length,
                      itemBuilder: (context, index) {
                        final item = controller.raceControl[index];
                        return ListTile(
                          leading: item.flag != null
                              ? Icon(
                                  Icons.flag,
                                  color: item.flag!.contains('GREEN') ||
                                          item.flag!.contains('CLEAR')
                                      ? Colors.green
                                      : item.flag!.contains('YELLOW')
                                          ? Colors.yellow
                                          : item.flag!.contains('CHEQUERED')
                                              ? Colors.black
                                              : item.flag!.contains('BLUE')
                                                  ? Colors.blue
                                                  : item.flag!.contains('RED')
                                                      ? Colors.red
                                                      : null,
                                )
                              : null,
                          title: Text(item.message),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

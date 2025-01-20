import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../main/routes.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('F1 Stats'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              'Para começar, escolha uma temporada.',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ),
          Expanded(
              child: ListView.builder(
            itemCount: DateTime.now().year - 2023,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text('Temporada ${2023 + index}'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  Get.toNamed('${Routes.meetings}/${2023 + index}');
                },
              );
            },
          )),
        ],
      ),
    );
  }
}

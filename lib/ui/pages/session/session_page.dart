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
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              'Aqui você encontra todas as corridas da temporada.',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ),
        ],
      ),
    );
  }
}

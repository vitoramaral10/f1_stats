import '../components/components.dart';

import 'package:flutter/material.dart';

import '../helpers/helpers.dart';

mixin UIErrorManager {
  void handleMainError(BuildContext context, Stream<UiError?> stream) {
    stream.listen((error) {
      if (error != null && context.mounted) {
        showErrorMessage(context, error.description);
      }
    });
  }
}

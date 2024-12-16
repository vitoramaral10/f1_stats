import 'dart:async';

import 'package:flutter/material.dart';

void showLoading(BuildContext context) {
  unawaited(
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => SimpleDialog(
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CircularProgressIndicator(),
              SizedBox(height: 10),
              Text(
                'Loading...',
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

void hideLoading(BuildContext context) {
  if (Navigator.canPop(context)) {
    Navigator.of(context).pop();
  }
}

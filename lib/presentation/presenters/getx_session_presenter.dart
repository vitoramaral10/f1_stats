import 'dart:async';
import 'dart:developer';

import 'package:f1_stats/domain/helpers/helpers.dart';
import 'package:f1_stats/ui/pages/pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../domain/entities/entities.dart';
import '../../domain/usecases/usecases.dart';

class GetxSessionPresenter extends GetxController implements SessionPresenter {
  final LoadRaceControl loadRaceControl;

  GetxSessionPresenter({
    required this.loadRaceControl,
  });

  final _session = Rx<SessionEntity>(SessionEntity.empty());
  final _raceControl = RxList<RaceControlEntity>([]);

  @override
  SessionEntity get session => _session.value;
  @override
  List<RaceControlEntity> get raceControl => _raceControl;

  @override
  void onInit() {
    super.onInit();

    _session.value = Get.arguments['session'];

    // Timer.periodic(Duration(seconds: 10), (timer) {
    getRaceControl();
    // });
  }

  @override
  Future<void> getRaceControl() async {
    try {
      _raceControl.clear();

      _raceControl.value =
          await loadRaceControl.call(sessionKey: session.sessionKey);
    } on DomainError catch (error) {
      log(error.toString(), name: 'GetxSessionPresenter.getRaceControl');
      Get.snackbar(
        'Error',
        error.toString(),
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
}

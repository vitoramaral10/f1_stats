import 'dart:developer';

import 'package:f1_stats/domain/entities/session_entity.dart';
import 'package:f1_stats/ui/pages/pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../domain/usecases/usecases.dart';

class GetxSessionsPresenter extends GetxController
    implements SessionsPresenter {
  final LoadSessions loadSessions;

  GetxSessionsPresenter({required this.loadSessions});

  final _sessions = Rx<List<SessionEntity>>([]);
  final _meetingKey = RxInt(0);

  @override
  List<SessionEntity> get sessions => _sessions.value;
  @override
  int get meetingKey => _meetingKey.value;

  @override
  void onInit() {
    super.onInit();

    _meetingKey.value = Get.parameters['meetingKey'] != null
        ? int.parse(Get.parameters['meetingKey']!)
        : 0;

    getSessions();
  }

  @override
  Future<void> getSessions() async {
    try {
      _sessions.value = await loadSessions.call(
        meetingKey: meetingKey,
      );
    } catch (error) {
      log(error.toString(), name: 'GetxSessionsPresenter.getSessions');
      Get.snackbar(
        'Erro',
        'Erro ao carregar as corridas. Tente novamente em breve. ($error)',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
}

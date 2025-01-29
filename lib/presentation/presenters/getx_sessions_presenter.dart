import 'dart:developer';

import 'package:f1_stats/ui/pages/pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../domain/entities/entities.dart';
import '../../domain/usecases/usecases.dart';

class GetxSessionsPresenter extends GetxController
    implements SessionsPresenter {
  final LoadSessions loadSessions;

  GetxSessionsPresenter({required this.loadSessions});

  final _sessions = Rx<List<SessionEntity>>([]);
  final _meetingKey = RxInt(0);
  final _meeting = Rx<MeetingEntity>(
    MeetingEntity.empty(),
  );
  final _isLoading = false.obs;

  @override
  List<SessionEntity> get sessions => _sessions.value;
  @override
  int get meetingKey => _meetingKey.value;
  @override
  MeetingEntity get meeting => _meeting.value;
  bool get isLoading => _isLoading.value;

  @override
  void onInit() {
    super.onInit();

    _meetingKey.value = Get.parameters['meetingKey'] != null
        ? int.parse(Get.parameters['meetingKey']!)
        : 0;

    _meeting.value = Get.arguments['meeting'] ?? MeetingEntity.empty();

    getSessions();
  }

  @override
  Future<void> getSessions() async {
    try {
      _isLoading.value = true;
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
    } finally {
      _isLoading.value = false;
    }
  }
}

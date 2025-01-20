import 'dart:developer';

import 'package:f1_stats/domain/entities/meeting_entity.dart';
import 'package:f1_stats/ui/pages/pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../domain/usecases/usecases.dart';

class GetxMeetingsPresenter extends GetxController
    implements MeetingsPresenter {
  final LoadMeetings loadMeetings;

  GetxMeetingsPresenter({required this.loadMeetings});

  final _meetings = Rx<List<MeetingEntity>>([]);
  final _year = Rx<int>(DateTime.now().year);

  @override
  List<MeetingEntity> get meetings => _meetings.value;
  @override
  int get year => _year.value;

  @override
  void onInit() {
    super.onInit();

    _year.value = Get.parameters['year'] != null
        ? int.parse(Get.parameters['year']!)
        : DateTime.now().year;

    getMeetings();
  }

  @override
  Future<void> getMeetings() async {
    try {
      _meetings.value = await loadMeetings.call(
        year: _year.value,
      );
    } catch (error) {
      log(error.toString(), name: 'GetxMeetingsPresenter.getMeetings');
      Get.snackbar(
        'Erro',
        'Erro ao carregar as corridas. Tente novamente em breve. ($error)',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
}

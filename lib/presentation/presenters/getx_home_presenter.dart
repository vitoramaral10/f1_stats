import 'dart:developer';

import 'package:get/get.dart';

import '../../domain/entities/entities.dart';
import '../../domain/helpers/helpers.dart';
import '../../domain/usecases/usecases.dart';
import '../../ui/pages/pages.dart';

class GetxHomePresenter extends GetxController implements HomePresenter {
  final LoadMeetings loadMeetings;

  GetxHomePresenter({required this.loadMeetings});

  final _year = DateTime.now().year.obs;
  final _meetings = <MeetingEntity>[].obs;

  @override
  int get year => _year.value;
  @override
  List<MeetingEntity> get meetings => _meetings;

  @override
  Future<void> onInit() async {
    super.onInit();
    await loadData();
  }

  @override
  Future<void> loadData() async {
    try {
      _meetings.assignAll([]);

      var result = await loadMeetings.call(year: _year.value);

      result.sort((a, b) => b.dateStart.compareTo(a.dateStart));
      _meetings.assignAll(result);
    } on DomainError catch (error) {
      log(error.toString(), name: 'GetxHomePresenter.loadData');
    }
  }
}

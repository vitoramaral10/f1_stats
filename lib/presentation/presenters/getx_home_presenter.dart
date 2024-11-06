import 'dart:developer';

import 'package:get/get.dart';

import '../../domain/entities/entities.dart';
import '../../domain/helpers/helpers.dart';
import '../../domain/usecases/usecases.dart';
import '../../ui/helpers/helpers.dart';
import '../../ui/pages/pages.dart';

class GetxHomePresenter extends GetxController implements HomePresenter {
  final LoadMeetings loadMeetings;
  final LoadSessions loadSessions;

  GetxHomePresenter({
    required this.loadMeetings,
    required this.loadSessions,
  });

  final _year = DateTime.now().year.obs;
  final _meetings = <MeetingEntity>[].obs;
  final _sessions = <SessionEntity>[].obs;
  final _selectedMeeting = Rx<int>(-1);

  @override
  int get year => _year.value;
  @override
  List<MeetingEntity> get meetings => _meetings;
  @override
  List<SessionEntity> get sessions => _sessions;
  @override
  int get selectedMeeting => _selectedMeeting.value;

  set selectedMeeting(int value) => _selectedMeeting.value = value;

  @override
  Future<void> loadData() async {
    try {
      _meetings.assignAll([]);

      var result = await loadMeetings.call(year: _year.value);

      result.sort((a, b) => b.dateStart.compareTo(a.dateStart));
      _meetings.assignAll(result);
    } on DomainError catch (error) {
      log(error.toString(), name: 'GetxHomePresenter.loadData');
      throw UiError.unexpected;
    }
  }

  @override
  Future<void> getSessions(int meetingKey) async {
    try {
      _sessions.value = [];

      var result = await loadSessions.call(meetingKey: meetingKey);

      result.sort((a, b) => a.dateStart.compareTo(b.dateStart));
      _sessions.assignAll(result);
    } on DomainError catch (error) {
      log(error.toString(), name: 'GetxHomePresenter.loadSessions');
    }
  }
}

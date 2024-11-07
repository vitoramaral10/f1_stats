import 'dart:developer';

import 'package:get/get.dart';

import '../../domain/entities/entities.dart';
import '../../domain/helpers/helpers.dart';
import '../../domain/usecases/usecases.dart';
import '../../ui/helpers/helpers.dart';
import '../../ui/pages/pages.dart';

class GetxRaceDashboardPresenter extends GetxController
    implements RaceDashboardPresenter {
  LoadMeetings loadMeetings;

  GetxRaceDashboardPresenter({required this.loadMeetings});

  final _meeting = Rxn<MeetingEntity>();

  @override
  MeetingEntity? get meeting => _meeting.value;

  @override
  Future<void> loadLatestMeeting() async {
    try {
      final result = await loadMeetings.call(
        meetingKey: 'latest', // Ensure this is not null
      );
      if (result.isEmpty) {
        throw UiError.notFound;
      }
      _meeting.value = result.first;
    } on DomainError catch (error) {
      log(error.toString(),
          name: 'GetxRaceDashboardPresenter.loadLatestMeeting');
      throw UiError.unexpected;
    }
  }
}

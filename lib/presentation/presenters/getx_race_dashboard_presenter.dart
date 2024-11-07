import 'dart:async';
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
  LoadDrivers loadDrivers;
  LoadPositions loadPositions;

  GetxRaceDashboardPresenter({
    required this.loadMeetings,
    required this.loadDrivers,
    required this.loadPositions,
  });

  Timer _timer = Timer(Duration.zero, () {});

  final _meeting = Rxn<MeetingEntity>();
  final _drivers = Rx<List<DriverEntity>>([]);
  final _latestPositions = Rx<List<PositionEntity>>([]);
  final _firstpositions = Rx<List<PositionEntity>>([]);

  @override
  MeetingEntity? get meeting => _meeting.value;
  @override
  List<DriverEntity> get drivers => _drivers.value;
  @override
  List<PositionEntity> get latestPositions => _latestPositions.value;
  @override
  List<PositionEntity> get firstPositions => _firstpositions.value;

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

      await getDrivers();

      Timer.periodic(
        const Duration(seconds: 5),
        (timer) async {
          _timer.cancel();
          await getLatestPosition();
          _timer = timer;
        },
      );
    } on DomainError catch (error) {
      log(error.toString(),
          name: 'GetxRaceDashboardPresenter.loadLatestMeeting');
      throw UiError.unexpected;
    }
  }

  @override
  Future<void> getDrivers() async {
    try {
      final result = await loadDrivers.call(
        meetingKey: _meeting.value?.meetingKey.toString() ?? 'latest',
        sessionKey: 'latest',
      );
      if (result.isEmpty) {
        throw UiError.notFound;
      }

      _drivers.value = result;
    } on DomainError catch (error) {
      log(error.toString(),
          name: 'GetxRaceDashboardPresenter.loadLatestMeeting');
      throw UiError.unexpected;
    }
  }

  @override
  Future<void> getLatestPosition() async {
    try {
      final result = await loadPositions.call(
        meetingKey: _meeting.value?.meetingKey.toString() ?? 'latest',
        sessionKey: 'latest',
      );

      // deixa somente a primeira e a ultima posição de cada piloto com base no date
      final latestPositions = result
          .fold<Map<int, PositionEntity>>(
            {},
            (acc, position) {
              final driverId = position.driverNumber;
              if (acc[driverId] == null ||
                  acc[driverId]!.date.isBefore(position.date)) {
                acc[driverId] = position;
              }
              return acc;
            },
          )
          .values
          .toList();

      final firstPositions = result
          .fold<Map<int, PositionEntity>>(
            {},
            (acc, position) {
              final driverId = position.driverNumber;
              if (acc[driverId] == null ||
                  acc[driverId]!.date.isAfter(position.date)) {
                acc[driverId] = position;
              }
              return acc;
            },
          )
          .values
          .toList();

      // ordena a lista de acordo com a posição
      latestPositions.sort((a, b) => a.position.compareTo(b.position));

      _latestPositions.value = latestPositions;
      _firstpositions.value = firstPositions;
    } on DomainError catch (error) {
      log(error.toString(),
          name: 'GetxRaceDashboardPresenter.getLatestPosition');
      rethrow;
    }
  }

  @override
  void onClose() {
    _timer.cancel();
    super.onClose();
  }
}

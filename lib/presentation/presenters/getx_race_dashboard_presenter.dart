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
  LoadIntervals loadIntervals;

  GetxRaceDashboardPresenter({
    required this.loadMeetings,
    required this.loadDrivers,
    required this.loadPositions,
    required this.loadIntervals,
  });

  Timer _timer1 = Timer(Duration.zero, () {});
  Timer _timer2 = Timer(Duration.zero, () {});

  final _meeting = Rxn<MeetingEntity>();
  final _drivers = Rx<List<DriverEntity>>([]);
  final _latestPositions = Rx<List<PositionEntity>>([]);
  final _firstpositions = Rx<List<PositionEntity>>([]);
  final _intervals = Rx<List<IntervalEntity>>([]);

  @override
  MeetingEntity? get meeting => _meeting.value;
  @override
  List<DriverEntity> get drivers => _drivers.value;
  @override
  List<PositionEntity> get latestPositions => _latestPositions.value;
  @override
  List<PositionEntity> get firstPositions => _firstpositions.value;
  @override
  List<IntervalEntity> get intervals => _intervals.value;

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
    } on DomainError catch (error) {
      log(error.toString(),
          name: 'GetxRaceDashboardPresenter.loadLatestMeeting');

      switch (error) {
        case DomainError.tooManyRequests:
          throw UiError.tooManyRequests;
        default:
          throw UiError.unexpected;
      }
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
      log(error.toString(), name: 'GetxRaceDashboardPresenter.getDrivers');
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
    }
  }

  @override
  void onClose() {
    _timer1.cancel();
    _timer2.cancel();
    super.onClose();
  }

  @override
  dispose() {
    _timer1.cancel();
    _timer2.cancel();
    super.dispose();
  }

  @override
  Future<void> getLatestInterval() async {
    try {
      final result = await loadIntervals.call(
        meetingKey: _meeting.value?.meetingKey.toString() ?? 'latest',
        sessionKey: 'latest',
      );

      final latestIntervals = result
          .fold<Map<int, IntervalEntity>>(
            {},
            (acc, interval) {
              final driverId = interval.driverNumber;
              if (acc[driverId] == null ||
                  acc[driverId]!.date.isBefore(interval.date)) {
                acc[driverId] = interval;
              }
              return acc;
            },
          )
          .values
          .toList();

      _intervals.value = latestIntervals;
    } on DomainError catch (error) {
      log(error.toString(),
          name: 'GetxRaceDashboardPresenter.getLatestInterval');
    }
  }

  @override
  Future<void> startLiveUpdates() async {
    _timer1 = Timer.periodic(const Duration(seconds: 5), (_) async {
      await getLatestPosition();
    });

    _timer2 = Timer.periodic(const Duration(seconds: 5), (_) async {
      await getLatestInterval();
    });
  }
}

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
  final LoadWeather loadWeather;
  final LoadDrivers loadDrivers;
  final LoadPositions loadPositions;
  final LoadIntervals loadIntervals;
  final LoadLaps loadLaps;

  GetxSessionPresenter({
    required this.loadRaceControl,
    required this.loadWeather,
    required this.loadDrivers,
    required this.loadPositions,
    required this.loadIntervals,
    required this.loadLaps,
  });

  Timer _weatherTimer = Timer(Duration(minutes: 1), () {});
  Timer _raceControlTimer = Timer(Duration(seconds: 1), () {});
  DateTime? _lastUpdatePositions;
  DateTime? _lastUpdateWeather;
  DateTime? _lastUpdateRaceControl;
  DateTime? _lastUpdateIntervals;
  DateTime? _lastUpdateLaps;

  final _session = Rx<SessionEntity>(SessionEntity.empty());
  final _raceControl = RxList<RaceControlEntity>([]);
  final _weather = RxList<WeatherEntity>([]);
  final _drivers = RxList<DriverEntity>([]);
  final _intervals = RxList<IntervalEntity>([]);
  final _laps = RxList<LapEntity>([]);

  @override
  SessionEntity get session => _session.value;
  @override
  List<RaceControlEntity> get raceControl => _raceControl;
  @override
  List<WeatherEntity> get weather => _weather;
  @override
  List<DriverEntity> get drivers => _drivers;
  @override
  List<IntervalEntity> get intervals => _intervals;
  @override
  List<LapEntity> get laps => _laps;

  @override
  Future<void> onInit() async {
    super.onInit();

    _session.value = Get.arguments['session'];

    getRaceControl();
    getWeather();
    await getDrivers();
    getPositions();
    if (_session.value.sessionType == "Race") getIntervals();
    if (_session.value.sessionType != "Race") getLaps();

    _raceControlTimer = Timer.periodic(Duration(seconds: 5), (timer) {
      getRaceControl();
      getPositions();
      if (_session.value.sessionType == "Race") getIntervals();
      if (_session.value.sessionType != "Race") getLaps();
    });

    _weatherTimer = Timer.periodic(Duration(minutes: 1), (timer) {
      getWeather();
    });
  }

  @override
  Future<void> getRaceControl() async {
    try {
      List<RaceControlEntity> result = await loadRaceControl.call(
        sessionKey: session.sessionKey,
        lastUpdate: _lastUpdateRaceControl,
      );

      if (result.isEmpty) {
        return;
      }

      // Sort new entries by date (newest first)
      result.sort((a, b) => b.date.compareTo(a.date));

      // Add new results to the existing list
      _raceControl.addAll(result);

      // Re-sort the entire list to ensure proper order
      _raceControl.sort((a, b) => b.date.compareTo(a.date));

      // Update last update time with the newest entry
      _lastUpdateRaceControl = result.first.date;
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

  @override
  Future<void> getWeather() async {
    try {
      List<WeatherEntity> result = await loadWeather.call(
        sessionKey: session.sessionKey,
        lastUpdate: _lastUpdateWeather,
      );

      if (result.isEmpty) {
        return;
      }

      // Ordena por data (mais recente primeiro)
      result.sort((a, b) => a.date.compareTo(b.date));

      // Adiciona os novos resultados à lista existente
      _weather.addAll(result);

      // Reordena a lista inteira para garantir a ordem correta
      _weather.sort((a, b) => a.date.compareTo(b.date));

      // Atualiza o horário da última atualização com a entrada mais recente
      _lastUpdateWeather = result.last.date;
    } on DomainError catch (error) {
      log(error.toString(), name: 'GetxSessionPresenter.getWeather');
      Get.snackbar(
        'Error',
        error.toString(),
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  @override
  Future<void> getDrivers() async {
    try {
      List<DriverEntity> result = await loadDrivers.call(
        sessionKey: session.sessionKey,
      );

      _drivers.assignAll(result);
    } on DomainError catch (error) {
      log(error.toString(), name: 'GetxSessionPresenter.getDrivers');
      Get.snackbar(
        'Error',
        error.toString(),
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  @override
  Future<void> getPositions() async {
    try {
      List<PositionEntity> result = await loadPositions.call(
          sessionKey: session.sessionKey, lastUpdate: _lastUpdatePositions);

      if (result.isEmpty) {
        return;
      }

      // Ordena por data (mais recente primeiro)
      result.sort((a, b) => b.date.compareTo(a.date));

      // Cria um mapa para armazenar a posição mais recente de cada piloto
      Map<int, PositionEntity> latestPositionByDriver = {};

      // Percorre todas as posições e mantém apenas a mais recente para cada piloto
      for (var position in result) {
        if (!latestPositionByDriver.containsKey(position.driverNumber)) {
          latestPositionByDriver[position.driverNumber] = position;
        }
      }

      // Converte o mapa de volta para uma lista
      List<PositionEntity> filteredPositions =
          latestPositionByDriver.values.toList();

      // Ordena por posição (1º ao último)
      filteredPositions.sort((a, b) => a.position.compareTo(b.position));

      final reorderDrivers = filteredPositions.map((position) {
        return drivers.firstWhere(
            (driver) => driver.driverNumber == position.driverNumber);
      }).toList();

      _drivers.value = reorderDrivers;

      _lastUpdatePositions = result.first.date;
    } on DomainError catch (error) {
      log(error.toString(), name: 'GetxSessionPresenter.getPositions');
      Get.snackbar(
        'Error',
        error.toString(),
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  @override
  Future<void> getIntervals() async {
    try {
      List<IntervalEntity> result = await loadIntervals.call(
          sessionKey: session.sessionKey, lastUpdate: _lastUpdateIntervals);

      if (result.isEmpty) {
        return;
      }

      // Ordena por data (mais recente primeiro)
      result.sort((a, b) => b.date.compareTo(a.date));

      // Cria um mapa para armazenar o intervalo mais recente de cada piloto
      Map<int, IntervalEntity> latestIntervalByDriver = {};

      // Percorre todos os intervalos e mantém apenas o mais recente para cada piloto
      for (var interval in result) {
        if (!latestIntervalByDriver.containsKey(interval.driverNumber)) {
          latestIntervalByDriver[interval.driverNumber] = interval;
        } else {
          // Se o intervalo atual for mais recente, atualiza o mapa
          if (interval.date
              .isAfter(latestIntervalByDriver[interval.driverNumber]!.date)) {
            latestIntervalByDriver[interval.driverNumber] = interval;
          }
        }
      }

      // Converte o mapa de volta para uma lista
      List<IntervalEntity> filteredIntervals =
          latestIntervalByDriver.values.toList();

      _intervals.value = filteredIntervals;
      _lastUpdateIntervals = result.first.date;
    } on DomainError catch (error) {
      log(error.toString(), name: 'GetxSessionPresenter.getIntervals');
      Get.snackbar(
        'Error',
        error.toString(),
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  @override
  Future<void> getLaps() async {
    try {
      List<LapEntity> result =  await loadLaps.call(
          sessionKey: session.sessionKey, lastUpdate: _lastUpdateLaps);

      if (result.isEmpty) {
        return;
      }

      // Ordena por data (mais recente primeiro)
      result.sort((a, b) => b.date!.compareTo(a.date!));

      // Cria um mapa para armazenar o intervalo mais recente de cada piloto
      Map<int, LapEntity> latestLapByDriver = {};

      // Percorre todos os intervalos e mantém apenas o mais recente para cada piloto
      for (var interval in result) {
        if (!latestLapByDriver.containsKey(interval.driverNumber)) {
          latestLapByDriver[interval.driverNumber] = interval;
        } else {
          // Se o intervalo atual for mais recente, atualiza o mapa
          if (interval.date!
              .isAfter(latestLapByDriver[interval.driverNumber]!.date!)) {
            latestLapByDriver[interval.driverNumber] = interval;
          }
        }
      }

      // Converte o mapa de volta para uma lista
      List<LapEntity> filteredIntervals = latestLapByDriver.values.toList();

      _laps.value = filteredIntervals;
      _lastUpdateLaps = result.first.date;
    } on DomainError catch (error) {
      log(error.toString(), name: 'GetxSessionPresenter.getLaps');
      Get.snackbar(
        'Error',
        error.toString(),
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  @override
  void onClose() {
    _raceControlTimer.cancel();
    _weatherTimer.cancel();
    super.onClose();
  }
}

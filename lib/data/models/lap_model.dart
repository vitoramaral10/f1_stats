import 'package:f1_stats/domain/entities/entities.dart';

class LapModel {
  final DateTime? dateStart;
  final int driverNumber;
  final double? durationSector1;
  final double? durationSector2;
  final double? durationSector3;
  final int? i1Speed;
  final int? i2Speed;
  final bool isPitOutLap;
  final double? lapDuration;
  final int lapNumber;
  final int meetingKey;
  final List<int> segmentsSector1;
  final List<int> segmentsSector2;
  final List<int> segmentsSector3;
  final int sessionKey;
  final int? stSpeed;

  LapModel({
    this.dateStart,
    required this.driverNumber,
    this.durationSector1,
    this.durationSector2,
    this.durationSector3,
    this.i1Speed,
    this.i2Speed,
    required this.isPitOutLap,
    this.lapDuration,
    required this.lapNumber,
    required this.meetingKey,
    required this.segmentsSector1,
    required this.segmentsSector2,
    required this.segmentsSector3,
    required this.sessionKey,
     this.stSpeed,
  });

  factory LapModel.fromJson(Map json) {
    return LapModel(
      dateStart: json['date_start'] != null
          ? DateTime.parse(json['date_start'])
          : null,
      driverNumber: json['driver_number'],
      durationSector1: json['duration_sector1'],
      durationSector2: json['duration_sector2'],
      durationSector3: json['duration_sector3'],
      i1Speed: json['i1_speed'],
      i2Speed: json['i2_speed'],
      isPitOutLap: json['is_pit_out_lap'],
      lapDuration: json['lap_duration'],
      lapNumber: json['lap_number'],
      meetingKey: json['meeting_key'],
      segmentsSector1: [],
      segmentsSector2: [],
      segmentsSector3: [],
      sessionKey: json['session_key'],
      stSpeed: json['st_speed'],
    );
  }

  LapEntity toEntity() => LapEntity(
        dateStart: dateStart,
        driverNumber: driverNumber,
        durationSector1: durationSector1,
        durationSector2: durationSector2,
        durationSector3: durationSector3,
        i1Speed: i1Speed,
        i2Speed: i2Speed,
        isPitOutLap: isPitOutLap,
        lapDuration: lapDuration,
        lapNumber: lapNumber,
        meetingKey: meetingKey,
        segmentsSector1: segmentsSector1,
        segmentsSector2: segmentsSector2,
        segmentsSector3: segmentsSector3,
        sessionKey: sessionKey,
        stSpeed: stSpeed,
      );
}

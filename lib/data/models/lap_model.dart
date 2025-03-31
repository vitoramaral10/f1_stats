import '../../domain/entities/entities.dart';

class LapModel {
  final DateTime date;
  final int driverNumber;
  final Duration durationSector1;
  final Duration durationSector2;
  final Duration durationSector3;
  final int i1Speed;
  final int i2Speed;
  final bool isPitOutLap;
  final Duration lapDuration;
  final int lapNumber;
  final int meetingKey;
  final int sessionKey;
  final int stSpeed;
  final List<int> segmentsSector1;
  final List<int> segmentsSector2;
  final List<int> segmentsSector3;

  LapModel({
    required this.date,
    required this.driverNumber,
    required this.durationSector1,
    required this.durationSector2,
    required this.durationSector3,
    required this.i1Speed,
    required this.i2Speed,
    required this.isPitOutLap,
    required this.lapDuration,
    required this.lapNumber,
    required this.meetingKey,
    required this.sessionKey,
    required this.stSpeed,
    required this.segmentsSector1,
    required this.segmentsSector2,
    required this.segmentsSector3,
  });

  factory LapModel.fromJson(Map<String, dynamic> json) {
    return LapModel(
      date: DateTime.parse(json['date']),
      driverNumber: json['driver_number'],
      durationSector1: Duration(
        milliseconds: (json['duration_sector_1'] * 1000).round(),
      ),
      durationSector2: Duration(
        milliseconds: (json['duration_sector_2'] * 1000).round(),
      ),
      durationSector3: Duration(
        milliseconds: (json['duration_sector_3'] * 1000).round(),
      ),
      i1Speed: json['i1_speed'],
      i2Speed: json['i2_speed'],
      isPitOutLap: json['is_pit_out_lap'],
      lapDuration: Duration(
        milliseconds: (json['lap_duration'] * 1000).round(),
      ),
      lapNumber: json['lap_number'],
      meetingKey: json['meeting_key'],
      sessionKey: json['session_key'],
      stSpeed: json['st_speed'],
      segmentsSector1:
          (json['segments_sector_1'] as List).map((e) => e as int).toList(),
      segmentsSector2:
          (json['segments_sector_2'] as List).map((e) => e as int).toList(),
      segmentsSector3:
          (json['segments_sector_3'] as List).map((e) => e as int).toList(),
    );
  }

  LapEntity toEntity() {
    return LapEntity(
      date: date,
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
      sessionKey: sessionKey,
      stSpeed: stSpeed,
      segmentsSector1: segmentsSector1,
      segmentsSector2: segmentsSector2,
      segmentsSector3: segmentsSector3,
    );
  }
}

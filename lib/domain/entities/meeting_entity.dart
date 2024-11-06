class MeetingEntity {
  final int meetingKey;
  final String meetingName;
  final DateTime dateStart;
  final String location;

  MeetingEntity({
    required this.meetingKey,
    required this.meetingName,
    required this.dateStart,
    required this.location,
  });
}

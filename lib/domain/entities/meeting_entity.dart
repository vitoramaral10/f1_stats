class MeetingEntity {
  final int meetingKey;
  final String meetingName;
  final String meetingOfficialName;
  final DateTime dateStart;
  final String location;

  MeetingEntity({
    required this.meetingKey,
    required this.meetingName,
    required this.meetingOfficialName,
    required this.dateStart,
    required this.location,
  });
}

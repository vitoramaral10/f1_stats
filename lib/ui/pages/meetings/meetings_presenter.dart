import '../../../domain/entities/entities.dart';

abstract class MeetingsPresenter {
  List<MeetingEntity> get meetings;
  int get year;

  Future<void> getMeetings();
}

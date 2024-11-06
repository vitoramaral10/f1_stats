import '../../../domain/entities/entities.dart';

abstract class HomePresenter {
  int get year;
  List<MeetingEntity> get meetings;

  Future<void> loadData();
}

import '../../../domain/entities/entities.dart';

abstract class SessionPresenter {
  SessionEntity get session;
  List<RaceControlEntity> get raceControl;

  Future<void> getRaceControl();
}

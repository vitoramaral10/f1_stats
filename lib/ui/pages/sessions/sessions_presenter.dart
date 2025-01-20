import '../../../domain/entities/entities.dart';

abstract class SessionsPresenter {
  List<SessionEntity> get sessions;
  int get meetingKey;

  Future<void> getSessions();
}

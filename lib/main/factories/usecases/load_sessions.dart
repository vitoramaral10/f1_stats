import '../../../data/usecases/usecases.dart';
import '../../../domain/usecases/usecases.dart';
import '../factories.dart';

LoadSessions makeRemoteLoadSessions() => RemoteLoadSessions(
      httpClient: makeHttpAdapter(),
      url: makeApiUrl('sessions'),
    );

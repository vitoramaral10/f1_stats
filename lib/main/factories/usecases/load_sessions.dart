import 'package:f1_stats/domain/usecases/load_sessions.dart';

import '../../../data/usecases/usecases.dart';
import '../factories.dart';

LoadSessions makeRemoteLoadSessions() => RemoteLoadSessions(
      httpClient: makeHttpAdapter(),
      url: makeApiUrl('sessions'),
    );

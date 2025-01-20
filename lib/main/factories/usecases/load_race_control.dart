import '../../../data/usecases/usecases.dart';
import '../../../domain/usecases/usecases.dart';
import '../factories.dart';

LoadRaceControl makeRemoteLoadRaceControl() => RemoteLoadRaceControl(
      httpClient: makeHttpAdapter(),
      url: makeApiUrl('race_control'),
    );

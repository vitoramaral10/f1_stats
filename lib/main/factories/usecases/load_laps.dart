import '../../../data/usecases/usecases.dart';
import '../../../domain/usecases/usecases.dart';
import '../factories.dart';

LoadLaps makeRemoteLoadLaps() => RemoteLoadLaps(
      httpClient: makeHttpAdapter(),
      url: makeApiUrl('laps'),
    );

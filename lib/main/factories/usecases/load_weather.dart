import '../../../data/usecases/usecases.dart';
import '../../../domain/usecases/usecases.dart';
import '../factories.dart';

LoadWeather makeRemoteLoadWeather() => RemoteLoadWeather(
      httpClient: makeHttpAdapter(),
      url: makeApiUrl('weather'),
    );

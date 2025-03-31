import 'dart:developer';

import '../../../domain/entities/entities.dart';
import '../../../domain/helpers/helpers.dart';
import '../../../domain/usecases/usecases.dart';
import '../../http/http.dart';
import '../../models/models.dart';

class RemoteLoadWeather implements LoadWeather {
  final HttpClient httpClient;
  final String url;

  RemoteLoadWeather({required this.httpClient, required this.url});

  @override
  Future<List<WeatherEntity>> call({
    required int sessionKey,
    DateTime? lastUpdate,
  }) async {
    try {
      final result = await httpClient.request(
        url: url,
        method: 'get',
        queryParameters: {
          'session_key=': sessionKey,
          if (lastUpdate != null) 'date>': lastUpdate.toIso8601String(),
        },
      );

      return result!
          .map<WeatherEntity>((json) => WeatherModel.fromJson(json).toEntity())
          .toList();
    } on HttpError catch (error) {
      log(error.toString(), name: 'RemoteLoadWeather.call');
      throw DomainError.unexpected;
    }
  }
}

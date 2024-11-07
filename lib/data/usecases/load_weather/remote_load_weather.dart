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
  }) async {
    try {
      Uri urlRequest = Uri(
        scheme: 'https',
        host: url,
        path: '/v1/weather',
        queryParameters: {
          'session_key': sessionKey.toString(),
        },
      );

      final response = await httpClient.request(
        url: urlRequest,
        method: HttpMethod.get,
      );

      return response
          .map<WeatherEntity>((json) => WeatherModel.fromJson(json).toEntity())
          .toList();
    } on HttpError catch (error) {
      log(error.toString(), name: 'RemoteLoadWeather.call');
      throw DomainError.unexpected;
    }
  }
}

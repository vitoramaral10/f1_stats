import 'dart:developer';

import '../../../domain/entities/entities.dart';
import '../../../domain/helpers/helpers.dart';
import '../../../domain/usecases/usecases.dart';
import '../../http/http.dart';
import '../../models/models.dart';

class RemoteLoadPositions implements LoadPositions {
  final HttpClient httpClient;
  final String url;

  RemoteLoadPositions({
    required this.httpClient,
    required this.url,
  });

  @override
  Future<List<PositionEntity>> call({
    required int sessionKey,
  }) async {
    try {
      final result = await httpClient.request(
        url: url,
        method: 'get',
        queryParameters: {'session_key=': sessionKey},
      );

      return result!
          .map<PositionEntity>(
              (json) => PositionModel.fromJson(json).toEntity())
          .toList();
    } on HttpError catch (error) {
      log(error.toString(), name: 'RemoteLoadWeather.call');
      throw DomainError.unexpected;
    }
  }
}

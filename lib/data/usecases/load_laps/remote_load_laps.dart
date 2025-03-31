import 'dart:developer';

import '../../../domain/entities/entities.dart';
import '../../../domain/helpers/helpers.dart';
import '../../../domain/usecases/usecases.dart';
import '../../http/http.dart';
import '../../models/models.dart';

class RemoteLoadLaps implements LoadLaps {
  final HttpClient httpClient;
  final String url;

  RemoteLoadLaps({
    required this.httpClient,
    required this.url,
  });

  @override
  Future<List<LapEntity>> call({
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
          .map<LapEntity>((json) => LapModel.fromJson(json).toEntity())
          .toList();
    } on HttpError catch (error) {
      log(error.toString(), name: 'RemoteLoadLaps.call');
      throw DomainError.unexpected;
    }
  }
}

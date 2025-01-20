import 'dart:developer';

import '../../../domain/entities/entities.dart';
import '../../../domain/helpers/helpers.dart';
import '../../../domain/usecases/usecases.dart';
import '../../http/http.dart';
import '../../models/models.dart';

class RemoteLoadRaceControl implements LoadRaceControl {
  final HttpClient httpClient;
  final String url;

  RemoteLoadRaceControl({required this.httpClient, required this.url});

  @override
  Future<List<RaceControlEntity>> call({
    required int sessionKey,
  }) async {
    try {
      final result = await httpClient.request(
        url: url,
        method: 'get',
        queryParameters: {'session_key=': sessionKey},
      );

      return result!
          .map<RaceControlEntity>(
              (json) => RaceControlModel.fromJson(json).toEntity())
          .toList();
    } on HttpError catch (error) {
      log(error.toString(), name: 'RemoteLoadRaceControl.call');
      throw DomainError.unexpected;
    }
  }
}

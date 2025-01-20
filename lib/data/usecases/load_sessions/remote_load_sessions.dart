import 'dart:developer';

import 'package:f1_stats/domain/entities/session_entity.dart';

import '../../../domain/helpers/helpers.dart';
import '../../../domain/usecases/usecases.dart';
import '../../http/http.dart';
import '../../models/models.dart';

class RemoteLoadSessions implements LoadSessions {
  final HttpClient httpClient;
  final String url;

  RemoteLoadSessions({required this.httpClient, required this.url});

  @override
  Future<List<SessionEntity>> call({
    required int meetingKey,
  }) async {
    try {
      final result = await httpClient.request(
        url: url,
        method: 'get',
        queryParameters: {'meeting_key=': meetingKey},
      );

      return result!
          .map<SessionEntity>((json) => SessionModel.fromJson(json).toEntity())
          .toList();
    } on HttpError catch (error) {
      log(error.toString(), name: 'RemoteLoadSessions.call');
      throw DomainError.unexpected;
    }
  }
}

import 'dart:developer';

import 'package:f1_stats/domain/entities/session_entity.dart';
import 'package:f1_stats/domain/usecases/load_sessions.dart';

import '../../../domain/helpers/helpers.dart';
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
      final response = await httpClient.request(
        url: '$url/sessions?meeting_key=$meetingKey',
        method: HttpMethod.get,
      );

      return response
          .map<SessionEntity>((json) => SessionModel.fromJson(json).toEntity())
          .toList();
    } on HttpError catch (error) {
      log(error.toString(), name: 'RemoteLoadSessions.call');
      throw DomainError.unexpected;
    }
  }
}

import 'dart:developer';

import '../../../domain/entities/entities.dart';
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
      Uri urlRequest = Uri(
        scheme: 'https',
        host: url,
        path: '/v1/sessions',
        queryParameters: {
          'meeting_key': meetingKey,
        },
      );

      final response = await httpClient.request(
        url: urlRequest,
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

import 'dart:developer';

import '../../../domain/entities/entities.dart';
import '../../../domain/helpers/helpers.dart';
import '../../../domain/usecases/usecases.dart';
import '../../http/http.dart';
import '../../models/models.dart';

class RemoteLoadIntervals implements LoadIntervals {
  final HttpClient httpClient;
  final String url;

  RemoteLoadIntervals({required this.httpClient, required this.url});

  @override
  Future<List<IntervalEntity>> call({
    required String meetingKey,
    required String sessionKey,
  }) async {
    try {
      Uri urlRequest = Uri(
        scheme: 'https',
        host: url,
        path: '/v1/intervals',
        queryParameters: {
          'meeting_key': meetingKey.toString(),
          'session_key': sessionKey,
        },
      );
      final response = await httpClient.request(
        url: urlRequest,
        method: HttpMethod.get,
      );
      return response
          .map<IntervalEntity>(
              (json) => IntervalModel.fromJson(json).toEntity())
          .toList();
    } on HttpError catch (error) {
      log(error.toString(), name: 'RemoteLoadIntervals.call');

      switch (error) {
        case HttpError.tooManyRequests:
          throw DomainError.tooManyRequests;
        default:
          throw DomainError.unexpected;
      }
    }
  }
}

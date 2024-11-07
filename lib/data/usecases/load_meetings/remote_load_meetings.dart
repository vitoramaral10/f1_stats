import 'dart:developer';

import '../../../domain/entities/entities.dart';
import '../../../domain/helpers/helpers.dart';
import '../../../domain/usecases/usecases.dart';
import '../../http/http.dart';
import '../../models/models.dart';

class RemoteLoadMeetings implements LoadMeetings {
  final HttpClient httpClient;
  final String url;

  RemoteLoadMeetings({required this.httpClient, required this.url});

  @override
  Future<List<MeetingEntity>> call({
    int? year,
    String? meetingKey,
  }) async {
    try {
      Uri urlRequest = Uri(
        scheme: 'https',
        host: url,
        path: '/v1/meetings',
        queryParameters: {
          if (year != null) 'year': year.toString(),
          'meeting_key': meetingKey,
        },
      );
      final response = await httpClient.request(
        url: urlRequest,
        method: HttpMethod.get,
      );
      return response
          .map<MeetingEntity>((json) => MeetingModel.fromJson(json).toEntity())
          .toList();
    } on HttpError catch (error) {
      log(error.toString(), name: 'RemoteLoadMeetings.call');
      throw DomainError.unexpected;
    }
  }
}

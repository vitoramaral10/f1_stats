import 'dart:developer';

import 'package:f1_stats/domain/entities/meeting_entity.dart';
import 'package:f1_stats/domain/usecases/load_meetings.dart';

import '../../../domain/helpers/helpers.dart';
import '../../http/http.dart';
import '../../models/models.dart';

class RemoteLoadMeetings implements LoadMeetings {
  final HttpClient httpClient;
  final String url;

  RemoteLoadMeetings({required this.httpClient, required this.url});

  @override
  Future<List<MeetingEntity>> call({
    required int year,
  }) async {
    try {
      final response = await httpClient.request(
        url: '$url/meetings?year=$year',
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

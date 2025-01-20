import 'dart:developer';

import 'package:f1_stats/domain/entities/meeting_entity.dart';

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
    required int year,
  }) async {
    try {
      final result = await httpClient.request(
        url: url,
        method: 'get',
        queryParameters: {'year=': year},
      );

      return result!
          .map<MeetingEntity>((json) => MeetingModel.fromJson(json).toEntity())
          .toList();
    } on HttpError catch (error) {
      log(error.toString(), name: 'RemoteLoadMeetings.call');
      throw DomainError.unexpected;
    }
  }
}

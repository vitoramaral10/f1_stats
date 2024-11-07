import 'http.dart';

abstract class HttpClient {
  Future<dynamic> request({
    required Uri url,
    required HttpMethod method,
    Map? body,
    Map? headers,
  });
}

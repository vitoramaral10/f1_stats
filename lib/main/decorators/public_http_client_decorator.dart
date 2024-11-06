import '../../data/http/http.dart';

class PublicHttpClientDecorator implements HttpClient {
  final HttpClient decoratee;

  PublicHttpClientDecorator({
    required this.decoratee,
  });

  @override
  Future request({
    required String url,
    required HttpMethod method,
    Map? body,
    Map? headers,
    bool useRefreshToken = false,
  }) async {
    try {
      return await decoratee.request(
        url: url,
        method: method,
        body: body,
      );
    } on HttpError {
      rethrow;
    }
  }
}

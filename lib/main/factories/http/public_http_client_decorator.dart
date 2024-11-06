import '../../../data/http/http.dart';
import '../../factories/factories.dart';

HttpClient makePublicHttpClientDecorator() =>
    PublicHttpClientDecorator(decoratee: makeHttpAdapter());

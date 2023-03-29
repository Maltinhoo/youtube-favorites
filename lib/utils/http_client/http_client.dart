import 'package:http/http.dart';

abstract class HttpService {
  Future<Response> get<T>(
    String url, {
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
  });
}

class HttpServiceImp implements HttpService {
  final Client client;

  HttpServiceImp(this.client);

  @override
  Future<Response> get<T>(
    String url, {
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
  }) async {
    return await client.get(
      Uri.parse(url),
      headers: headers,
    );
  }
}

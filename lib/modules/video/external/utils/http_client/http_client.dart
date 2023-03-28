import 'package:http/http.dart';

abstract class HttpClient {
  Future<Response> get<T>(
    String url, {
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
  });
}

class HttpClientImp implements HttpClient {
  final Client client;

  HttpClientImp(this.client);

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

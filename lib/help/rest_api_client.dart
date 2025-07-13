import 'package:dio/dio.dart';

class RestApiClient {
  static final RestApiClient _instance = RestApiClient._internal();

  late Dio _dio;
  late String baseUrl;
  Map<String, dynamic> headers = {};

  // 내부 생성자
  RestApiClient._internal();

  // 싱글턴 인스턴스 접근
  factory RestApiClient({String? baseUrl, Map<String, dynamic>? headers}) {
    if (baseUrl != null) {
      _instance.baseUrl = baseUrl;
      _instance._dio = Dio(BaseOptions(baseUrl: baseUrl));
    }
    if (headers != null) {
      _instance.headers = headers;
    }
    return _instance;
  }

  // GET 요청
  Future<Response> get(String path,
      {Map<String, dynamic>? queryParameters}) async {
    return _dio.get(
      path,
      queryParameters: queryParameters,
      options: _options(),
    );
  }

  // POST 요청
  Future<Response> post(String path, dynamic data) async {
    return _dio.post(
      path,
      data: data,
      options: _options(),
    );
  }

  // PUT 요청
  Future<Response> put(String path, dynamic data) async {
    return _dio.put(
      path,
      data: data,
      options: _options(),
    );
  }

  // DELETE 요청
  Future<Response> delete(String path, {dynamic data}) async {
    return _dio.delete(
      path,
      data: data,
      options: _options(),
    );
  }

  // 공통 옵션 설정
  Options _options() {
    return Options(headers: headers);
  }
}

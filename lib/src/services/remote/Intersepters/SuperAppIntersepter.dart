import 'package:dio/dio.dart';

class SuperAppApiInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers = {
      ...options.headers,
      "Authorization": "Basic UGZpemVyQXBpOngyRnN0VnN6"
    };
    super.onRequest(options, handler);
  }
}
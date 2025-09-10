import 'package:dio/dio.dart';
import 'package:firebase_performance/firebase_performance.dart';

class FirebaseInterceptor extends Interceptor {
  HttpMetric? metric;

  @override
  onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    super.onRequest(options, handler);
    _startHttpMetric(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    super.onResponse(response, handler);
    _stopHttpMetric(
      statusCode: response.statusCode ?? 0,
      responsePayloadSize: response.data.toString().length,
    );
  }

  @override
  Future onError(DioException err, ErrorInterceptorHandler handler) async {
    super.onError(err, handler);
    _stopHttpMetric(statusCode: err.response?.statusCode ?? 400);
  }

  Future<void> _startHttpMetric(RequestOptions options) async {
    HttpMethod method = HttpMethod.Get;
    if (options.method == "POST") {
      method = HttpMethod.Post;
    } else if (options.method == "PUT") {
      method = HttpMethod.Put;
    }

    metric = FirebasePerformance.instance.newHttpMetric(options.uri.toString(), method);

    String decodedUrl = Uri.decodeComponent(options.uri.toString());
    Uri uri = Uri.parse(decodedUrl);
    String? route = uri.queryParameters['route'];
    metric?.putAttribute('Route', route ?? "");

    // Start the trace
    await metric?.start();
  }

  void _stopHttpMetric({int statusCode = 0, int? responsePayloadSize}) {
    metric?.httpResponseCode = statusCode;
    if (responsePayloadSize != null) metric?.responsePayloadSize = responsePayloadSize;
    metric?.stop();
  }
}

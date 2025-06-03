import 'package:dio/dio.dart';
import 'package:zoozitest/app.dart';
import 'package:zoozitest/base/api/session_dialog.dart';
import 'package:zoozitest/base/utils/cache_manager.dart';

import '../utils/logger.dart';

const String unkownErrorMsg = 'unknown error occurred';

class Api {
  static final Api _instance = Api._internal();
  static final String baseUrl = 'https://wallet-testing-murex.vercel.app';
  static final String unkownErrorMsg = 'unknown error occurred';
  final Dio dio = Dio();

  Api._internal() {
    initialize();
  }

  void initialize() async {
    dio.interceptors.add(MyInterceptor());
  }

  static Dio get client => _instance.dio;
}

class MyInterceptor extends Interceptor {
  _log(String url, [dynamic data]) {
    logger.i(url);
    if (data != null) {
      if (data is Map && data.isEmpty) {
        return;
      }
      logger.d(data);
    }
  }

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await CacheManager.retrieve(CacheConstants.accessToken);
    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    _log("=> ${options.method} ${options.uri.toString()}", options.data);

    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    final result = response.data;
    _log(
      "<= ${response.requestOptions.method} ${response.requestOptions.uri.toString()}",
      result,
    );

    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    logger.e(err);
    Response<dynamic>? response = err.response;
    _log(
      "<= ${err.requestOptions.method} ${err.requestOptions.uri.toString()}",
      response?.data,
    );
    final urlPath = err.requestOptions.path;
    if (response?.statusCode == 401 &&
        urlPath != '/login' &&
        urlPath != '/register') {
      SessionDialogManager.showSessionExpiredDialog(
        navigatorKey.currentContext!,
      );
    }
    if (response != null && response.data is Map<String, dynamic>) {
      Map result = response.data;
      if (result.containsKey('error')) {
        err = err.copyWith(message: result['error']);
      }
    }
    super.onError(err, handler);
  }
}

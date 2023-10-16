import 'dart:developer';
import 'dart:math' as math;

import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../app_setting.dart';
import '../config/config.dart';

class AppInterceptor extends Interceptor {
  AppInterceptor({
    this.request = true,
    this.requestHeader = true,
    this.requestBody = true,
    this.responseHeader = true,
    this.responseBody = true,
    this.error = true,
    this.compact = true,
    this.maxWidth = 120,
  });

  /// Print request [Options]
  final bool request;

  /// Print request header [Options.headers]
  final bool requestHeader;

  /// Print request data [Options.data]
  final bool requestBody;

  /// Print [Response.data]
  final bool responseBody;

  /// Print [Response.headers]
  final bool responseHeader;

  /// Print error message
  final bool error;

  final int maxWidth;
  final bool compact;

  static const int initialTab = 1;

  static const String tabStep = '    ';
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    options.queryParameters.addAll({
      "lang": GetIt.I.get<AppSetting>().currentLocale.value ?? "th",
      "apiKey": Config.apiKey
    });
    if (request) {
      _printRequestHeader(options);
    }
    if (requestHeader) {
      _printMapAsTable(options.queryParameters, header: 'Query Parameters');
      final Map<String, dynamic> requestHeaders = <String, dynamic>{};
      requestHeaders.addAll(options.headers);
      // requestHeaders['contentType'] = options.contentType?.toString();
      // requestHeaders['responseType'] = options.responseType.toString();
      // requestHeaders['followRedirects'] = options.followRedirects;
      // requestHeaders['connectTimeout'] = options.connectTimeout;
      // requestHeaders['receiveTimeout'] = options.receiveTimeout;

      // requestHeaders['memId'] = memId;
      // if (options.path.contains("logout")) {
      //   requestHeaders['accessToken'] = accessToken;
      // } else if (options.path.contains("refreshToken")) {
      //   requestHeaders['refreshToken'] = refreshToken;
      // }
      _printMapAsTable(requestHeaders, header: 'Headers');
      _printMapAsTable(options.extra, header: 'Extras');
    }
    if (requestBody && options.method != 'GET') {
      final dynamic data = options.data;
      if (data != null) {
        if (data is Map) {
          _printMapAsTable(options.data as Map<dynamic, dynamic>?,
              header: 'Body');
        } else {
          if (data is FormData) {
            final Map<String, dynamic> formDataMap = <String, dynamic>{}
              ..addEntries(data.fields)
              ..addEntries(data.files);
            _printMapAsTable(formDataMap,
                header: 'Form data | ${data.boundary}');
          } else {
            _printBlock(data.toString());
          }
        }
      }
    }
    super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    log('ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}');
    if (error) {
      if (err.type == DioExceptionType.badResponse) {
        final Uri? uri = err.response?.requestOptions.uri;
        _printBoxed(
            header: 'DioError ║ Status: ${err.response?.statusCode}'
                ' ${err.response?.statusMessage}',
            text: uri.toString());
        if (err.response != null && err.response?.data != null) {
          log('╔ ${err.type.toString()}');
          _printResponse(err.response!);
        }
        _printLine('╚');
        log('');
      } else {
        _printBoxed(header: 'DioError ║ ${err.type}', text: err.message);
      }
    }
    super.onError(err, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    // if (response.statusCode == 200) {
    //   handler.next(response);
    // }
    _printResponseHeader(response);
    if (responseHeader) {
      final Map<String, String> responseHeaders = <String, String>{};
      response.headers.forEach((String k, List<String> list) =>
          responseHeaders[k] = list.toString());
      _printMapAsTable(responseHeaders, header: 'Headers');
    }

    if (responseBody) {
      log('╔ Body');
      log('║');
      _printResponse(response);
      log('║');
      _printLine('╚');
    }
    super.onResponse(response, handler);
  }

  void _printBoxed({String? header, String? text}) {
    log('');
    log('╔╣ $header');
    log('║  $text');
    _printLine('╚');
  }

  void _printResponse(Response<dynamic> response) {
    if (response.data != null) {
      if (response.data is Map) {
        _printPrettyMap(response.data as Map<dynamic, dynamic>);
      } else if (response.data is List) {
        log('║${_indent()}[');
        _printList(response.data as List<dynamic>);
        log('║${_indent()}[');
      } else {
        _printBlock(response.data.toString());
      }
    }
  }

  void _printResponseHeader(Response<dynamic> response) {
    final Uri uri = response.requestOptions.uri;
    final String method = response.requestOptions.method;
    _printBoxed(
        header: 'Response ║ $method ║ Status: ${response.statusCode}'
            ' ${response.statusMessage}',
        text: uri.toString());
  }

  void _printRequestHeader(RequestOptions options) {
    final Uri uri = options.uri;
    final String method = options.method;
    _printBoxed(header: 'Request ║ $method ', text: uri.toString());
  }

  void _printLine([String pre = '', String suf = '╝']) =>
      log('$pre${'═' * maxWidth}$suf');

  void _printKV(String? key, Object? v) {
    final String pre = '╟ $key: ';
    final String msg = v.toString();

    if (pre.length + msg.length > maxWidth) {
      log(pre);
      _printBlock(msg);
    } else {
      log('$pre$msg');
    }
  }

  void _printBlock(String msg) {
    final int lines = (msg.length / maxWidth).ceil();
    for (int i = 0; i < lines; ++i) {
      log((i >= 0 ? '║ ' : '') +
          msg.substring(i * maxWidth,
              math.min<int>(i * maxWidth + maxWidth, msg.length)));
    }
  }

  String _indent([int tabCount = initialTab]) => "\t" * tabCount;

  void _printPrettyMap(
    Map<dynamic, dynamic> data, {
    int tabs = initialTab,
    bool isListItem = false,
    bool isLast = false,
  }) {
    int newTabs = tabs;
    final bool isRoot = tabs == initialTab;
    final String initialIndent = _indent(tabs);
    tabs++;

    if (isRoot || isListItem) log('║$initialIndent{');

    data.keys.toList().asMap().forEach((int index, dynamic key) {
      final bool isLast = index == data.length - 1;
      dynamic value = data[key];
      if (value is String) {
        value = '"${value.toString().replaceAll(RegExp(r'(\r|\n)+'), " ")}"';
      }
      if (value is Map) {
        if (compact && _canFlattenMap(value)) {
          log('║${_indent(newTabs)} $key: $value${!isLast ? ',' : ''}');
        } else {
          log('║${_indent(newTabs)} $key: {');
          _printPrettyMap(value, tabs: newTabs);
        }
      } else if (value is List) {
        if (compact && _canFlattenList(value)) {
          log('║${_indent(newTabs)} $key: ${value.toString()}');
        } else {
          log('║${_indent(newTabs)} $key: [');
          _printList(value, tabs: newTabs);
          log('║${_indent(newTabs)} ]${isLast ? '' : ','}');
        }
      } else {
        final String msg = value.toString().replaceAll('\n', '');
        final String indent = _indent(newTabs);
        final int linWidth = maxWidth - indent.length;
        if (msg.length + indent.length > linWidth) {
          final int lines = (msg.length / linWidth).ceil();
          for (int i = 0; i < lines; ++i) {
            log('║${_indent(newTabs)} ${msg.substring(i * linWidth, math.min<int>(i * linWidth + linWidth, msg.length))}');
          }
        } else {
          log('║${_indent(newTabs)} $key: $msg${!isLast ? ',' : ''}');
        }
      }
    });

    log('║$initialIndent}${isListItem && !isLast ? ',' : ''}');
  }

  void _printList(List<dynamic> list, {int tabs = initialTab}) {
    list.asMap().forEach((int i, dynamic e) {
      final bool isLast = i == list.length - 1;
      if (e is Map) {
        if (compact && _canFlattenMap(e)) {
          log('║${_indent(tabs)}  $e${!isLast ? ',' : ''}');
        } else {
          _printPrettyMap(e, tabs: tabs + 1, isListItem: true, isLast: isLast);
        }
      } else {
        log('║${_indent(tabs + 2)} $e${isLast ? '' : ','}');
      }
    });
  }

  bool _canFlattenMap(Map<dynamic, dynamic> map) {
    return map.values
            .where((dynamic val) => val is Map || val is List)
            .isEmpty &&
        map.toString().length < maxWidth;
  }

  bool _canFlattenList(List<dynamic> list) {
    return list.length < 10 && list.toString().length < maxWidth;
  }

  void _printMapAsTable(Map<dynamic, dynamic>? map, {String? header}) {
    if (map == null || map.isEmpty) return;
    log('╔ $header ');
    map.forEach(
        (dynamic key, dynamic value) => _printKV(key.toString(), value));
    _printLine('╚');
  }
}

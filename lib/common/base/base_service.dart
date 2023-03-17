import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../config/config.dart';
import 'api_exception.dart';

enum HttpMethod { post, get }

enum UrlType { deufaultUrl, urlWithUnencodePath, absoluteUrl }

enum ServiceUrl { topHeadlines }

enum ApiState { loading, completed, error }

extension AppUrl on ServiceUrl {
  String get fullUrl {
    switch (this) {
      case ServiceUrl.topHeadlines:
        return "top-headlines";
      default:
        return toString();
    }
  }
}

class AppService {
  //use witg config api path
  static String getUrl(ServiceUrl url) {
    return Config.apiService + url.fullUrl;
  }

  //use witg config api path
  static String getUrlWithUnencodePath(ServiceUrl url, String params) {
    return Config.apiService + url.fullUrl + params;
  }

  //other paths that not set in config
  static String getAbsoluteUrl(ServiceUrl url) {
    return url.fullUrl;
  }
}

class BaseService {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final Map<String, String> _header = {
    "Accept": "application/json",
    "content-type": "application/json",
    'Authorization': Config.apiKey,
  };

  @protected
  Future<String> execute(ServiceUrl url,
      {required Map<String, dynamic> request,
      required HttpMethod method,
      UrlType urlType = UrlType.deufaultUrl,
      String? unencodePath,
      bool needAuth = true}) async {
    String finalUrl = '';
    if (urlType == UrlType.urlWithUnencodePath) {
      finalUrl = AppService.getUrlWithUnencodePath(url, unencodePath ?? '');
    } else if (urlType == UrlType.absoluteUrl) {
      finalUrl = AppService.getAbsoluteUrl(url);
    } else {
      finalUrl = AppService.getUrl(url);
    }
    try {
      var response = await _executeRequest(finalUrl, request, method,
          header: _header, needAuth: needAuth);
      log("********** result **********");
      log('response code: ${response.statusCode}');
      log('response body: ${response.body}');
      switch (response.statusCode) {
        case 200:
          return response.body;
        case 400:
          throw BadRequestException(response.body.toString());
        case 401:
        case 403:
          throw UnauthorisedException(response.body.toString());
        case 500:
        default:
          throw FetchDataException(
              '${response.statusCode} ${response.reasonPhrase}');
      }
    } on ApiException catch (_) {
      rethrow;
    } on SocketException catch (e) {
      //throw FetchDataException('No Internet connection');
      throw FetchDataException(e.message);
    } on TimeoutException catch (e) {
      throw FetchDataException(e.message ?? 'Contection timeout');
    } catch (e) {
      log(e.toString());
      throw UnknowException(e.toString());
    }
  }

  Future<http.Response> _executeRequest(
      String url, Map<String, dynamic> request, HttpMethod method,
      {Map<String, String>? header, bool needAuth = true}) async {
    var client = needAuth
        ? AuthClient(getAccessToken: () async {
            return _prefs.then((value) => value.getString('token'));
          })
        : http.Client();
    try {
      if (method == HttpMethod.get) {
        log("********** http get **********");
        var queryString = _generateQueryString(request);
        log("queryString: $queryString");
        log("header: $header");
        log("final url: $url$queryString");
        var response =
            await client.get(Uri.parse('$url$queryString'), headers: header);
        return response;
      } else {
        log("********** http post **********");
        // log("request : " + request.toString());
        request.removeWhere((key, value) {
          return value == null;
        });
        log("header : $header");
        log("url: $url");
        log("request body: ${jsonEncode(request)}");
        var response = await client.post(Uri.parse(url),
            headers: header, body: jsonEncode(request));
        return response;
      }
    } catch (e) {
      rethrow;
    } finally {
      client.close();
    }
  }

  String _generateQueryString(Map<String, dynamic> request) {
    if (request.isEmpty) return "";

    String result = "?";
    request.forEach((key, value) {
      if (value != null) {
        result += "$key=$value";
        result += "&";
      }
    });
    result = result.substring(0, result.length - 1).replaceAll(" ", "%20");
    return result;
  }
}

typedef GetAccessToken = Future<String?> Function();

class AuthClient extends http.BaseClient {
  AuthClient({
    required this.getAccessToken,
  });

  final _client = http.Client();
  final GetAccessToken getAccessToken;

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) async {
    if (request.headers['authorization'] == null) {
      // add authorization header if it isn't exists
      final accessToken = await getAccessToken();
      if (accessToken != null) {
        request.headers['authorization'] = 'Bearer $accessToken';
      }
    }

    return _client.send(request);
  }

  @override
  void close() {
    _client.close();

    super.close();
  }
}

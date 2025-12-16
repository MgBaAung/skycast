// 💾 CachingInterceptor.dart
import 'dart:async';
import 'package:http_interceptor/http_interceptor.dart';
import 'package:http/http.dart' as http;

class CacheEntry {
  final http.Response response;
  final DateTime expiryTime;
  CacheEntry({required this.response, required this.expiryTime});
}

class CachingInterceptor implements InterceptorContract {
  final Duration cacheDuration = const Duration(seconds: 30); 
  final Map<String, CacheEntry> _responseCache = {}; 

  @override
  FutureOr<BaseRequest> interceptRequest({required BaseRequest request}) async {
    if (request.method == 'GET') {
      final cacheKey = request.url.toString();
      if (_responseCache.containsKey(cacheKey)) {
        final cacheEntry = _responseCache[cacheKey]!;
        
        if (DateTime.now().isBefore(cacheEntry.expiryTime)) {
          request.headers['X-CACHE-HIT'] = 'true';
        } else {
          _responseCache.remove(cacheKey);
        }
      }
    }
    return request;
  }

  @override
  FutureOr<BaseResponse> interceptResponse({required BaseResponse response}) async {
    final cacheKey = response.request?.url.toString();

    if (response.request?.headers['X-CACHE-HIT'] == 'true' && cacheKey != null) {
      final cacheEntry = _responseCache[cacheKey]!;      
      return cacheEntry.response; 
    }

    if (response.statusCode >= 200 && response.statusCode < 300 && cacheKey != null && response is http.Response) {
      _responseCache[cacheKey] = CacheEntry(
        response: response,
        expiryTime: DateTime.now().add(cacheDuration),
      );
    }
    return response;
  }
  
  @override
  FutureOr<bool> shouldInterceptRequest() {
    return true;
  }
  
  @override
  FutureOr<bool> shouldInterceptResponse() {
    return true;
  }
}
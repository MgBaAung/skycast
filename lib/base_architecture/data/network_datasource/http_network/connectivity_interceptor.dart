
import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:http_interceptor/http_interceptor.dart';

class ConnectivityInterceptor extends InterceptorContract{
  @override
  FutureOr<BaseRequest> interceptRequest({required BaseRequest request}) async{
   final connectivityResults = await Connectivity().checkConnectivity();

   if(connectivityResults.contains(ConnectivityResult.none)){
     throw const SocketException("No internet connection available on the device.");
   }
    
    try{
   final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return request; 
      }
    } on SocketException catch (_) {
      throw const SocketException('Internet is available but access is restricted.');
    }

  
  return request;
  }

  @override
  FutureOr<BaseResponse> interceptResponse({required BaseResponse response}) {
    return response;
  }
}
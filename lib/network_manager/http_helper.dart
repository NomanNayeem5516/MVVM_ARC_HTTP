
import 'dart:convert';



import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'dart:io';

import 'package:mvvm_arc_with_http/utils/print_value.dart';
import 'package:mvvm_arc_with_http/utils/toast_massage.dart';

class HttpHelper{
  ///Get Api
  Future<dynamic>get({required String url,bool isRequireAuthorization=false}) async{
    Map<String,String>apiHeaders={"Contact Type":"application/json"};
    if(isRequireAuthorization){
      apiHeaders={
        "Contact Type":"application/json",
        "CAuthorization":'Bearer"userBearerToken"'
      };
    }
    try{
      final apiResponse= await http.get(Uri.parse(url),headers:apiHeaders);

      printValue(url,tag: "API GET URL");
      printValue(apiHeaders,tag: "API HEADER");
      printValue(apiResponse,tag: "API RESPONSE");
      return _returnResponse(response:apiResponse);

    }on SocketException{
      return null;
    }
  }


  ///Post Api
  Future<dynamic>post({required String url,Object? requestBody,  bool isRequireAuthorization=false}) async{
    Map<String,String>apiHeaders={"Contact Type":"application/json"};
    if(isRequireAuthorization){
      apiHeaders={
        "Contact Type":"application/json",
        "CAuthorization":'Bearer"userBearerToken"'
      };
    }
    try{
      http.Response apiResponse;
      if(requestBody==null){

        apiResponse=await http.post(Uri.parse(url),headers: apiHeaders);
      }else{
        apiResponse=await http.post(Uri.parse(url),body: jsonEncode(requestBody),headers: apiHeaders);
      }

      printValue(url,tag: "API GET URL");
      printValue(apiHeaders,tag: "API HEADER");
      printValue(apiResponse,tag: "API RESPONSE");
      return _returnResponse(response:apiResponse);

    }on SocketException{
      return null;
    }
  }

  ///Put Api
  Future<dynamic>put({required String url,Object? requestBody,  bool isRequireAuthorization=false}) async{
    Map<String,String>apiHeaders={"Contact Type":"application/json"};
    if(isRequireAuthorization){
      apiHeaders={
        "Contact Type":"application/json",
        "CAuthorization":'Bearer"userBearerToken"'
      };
    }
    try{
      http.Response apiResponse;
      if(requestBody==null){

        apiResponse=await http.put(Uri.parse(url),headers: apiHeaders);
      }else{
        apiResponse=await http.put(Uri.parse(url),body: jsonEncode(requestBody),headers: apiHeaders);
      }

      printValue(url,tag: "API GET URL");
      printValue(apiHeaders,tag: "API HEADER");
      printValue(apiResponse,tag: "API RESPONSE");
      return _returnResponse(response:apiResponse);

    }on SocketException{
      return null;
    }
  }

  ///Delete Api
  Future<dynamic>delete({required String url,Object? requestBody,  bool isRequireAuthorization=false}) async{
    Map<String,String>apiHeaders={"Contact Type":"application/json"};
    if(isRequireAuthorization){
      apiHeaders={
        "Contact Type":"application/json",
        "CAuthorization":'Bearer"userBearerToken"'
      };
    }
    try{
      http.Response apiResponse;
      if(requestBody==null){

        apiResponse=await http.delete(Uri.parse(url),headers: apiHeaders);
      }else{
        apiResponse=await http.delete(Uri.parse(url),body: jsonEncode(requestBody),headers: apiHeaders);
      }

      printValue(url,tag: "API GET URL");
      printValue(apiHeaders,tag: "API HEADER");
      printValue(apiResponse,tag: "API RESPONSE");
      return _returnResponse(response:apiResponse);

    }on SocketException{
      return null;
    }
  }

  ///Multiple Api

  Future<dynamic> uploadImage({required File imageFile,required String url}) async{
    try{
      var request = http.MultipartRequest('POST', Uri.parse(url));
      request.headers.addAll({"Contact Type":"multipart/form-data"});
      request.files.add(
        await http.MultipartFile.fromPath(
          'file',
          imageFile.path,
          filename: imageFile.toString().split("/").last
        )
      );
      StreamedResponse streamedResponse = await request.send();
      http.Response response= await http.Response.fromStream(streamedResponse);

      printValue(url,tag: "API MULTIPLE URL:",);
      printValue({"Contact Type":"multipart/form-data"},tag: "API Header:",);
      printValue(response.body,tag: "API RESPONSE:",);

      return _returnResponse(response:response);
    }on SocketException{
      return null;
    }
  }

}

dynamic _returnResponse ({required http.Response response}){
  switch(response.statusCode){
    case 200:
      var responseJson=json.decode(response.body);
      return responseJson;
    case 201:
      var responseJson=json.decode(response.body);
      return responseJson;
    case 400:
      var decodeError=json.decode(response.body);
      if(decodeError.containsKey('message')){
        toastMassage(decodeError['message'].toString());
      }throw Exception('ERROR');
    case 401:throw Exception('ERROR statusCode 401');
    case 500:throw Exception('ERROR statusCode 500');
    default :throw Exception('ERROR  occurred while Communication with Serve with StatusCode ${response.statusCode.toString()}');
  }
}



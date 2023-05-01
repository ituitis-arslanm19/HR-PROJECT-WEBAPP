import 'dart:convert';

import 'package:http/http.dart';
import 'package:webapp/core/base/base_model.dart';
import 'package:http/http.dart' as http;
import 'package:webapp/core/cache/secure_storage.dart';
import 'package:webapp/core/constant/enum/enums.dart';
import 'package:webapp/core/constant/strings.dart';
import 'package:webapp/core/network/model/response_model.dart';
import 'package:webapp/screen/model/employee.dart';

class NetworkManager {
  final SecureStorage secureStorage;
  static const SERVER = SERVER_ADDRESS;

  NetworkManager(this.secureStorage);

  Future<ResponseModel<R>> send<R, T>(String url, HttpMethod httpMethod,
      BaseModel<T> baseModel, String? data, String? token) async {
    ResponseModel<R> responseModel = ResponseModel();

    try {
      token ??= await secureStorage.readSecureData("accessToken");

      var res = await getResponse(httpMethod, url, token, data);

      //Refresh token mekanizması için
      if (res.statusCode == 401) {
        String? refreshToken =
            await secureStorage.readSecureData("refreshToken");
        if (refreshToken != null) {
          var refreshTokenResponse =
              await http.get(Uri.http(SERVER, url), headers: <String, String>{
            "Access-Control-Allow-Origin": "*",
            'Content-Type': 'application/json',
            'Accept': '*/*',
            'Authorization': "Bearer " + refreshToken,
          });
          var result = handleResponse<Employee, Employee>(
              refreshTokenResponse, Employee());
          if (!result.error! && result.data != null) {
            //Yeni alınan token eski tokenın üzerine yazılıp istek tekrar yollanıyor.
            token = result.data!.accessToken;
            secureStorage.writeSecureData("accessToken", token ?? "");
            secureStorage.writeSecureData(
                "refreshToken", result.data!.refreshToken ?? "");
            res = await getResponse(httpMethod, url, token, data);
          } else {
            secureStorage.deleteSecureData("accessToken");
            secureStorage.deleteSecureData("refreshToken");
          }
        }
      }

      return handleResponse(res, baseModel);
    } catch (e) {
      responseModel.error = true;
      responseModel.description = "Servise bağlanılamadı";
      print(e);
    }

    return responseModel;
  }

  // Future<ResponseModel<R>> postData<R, T>(
  //     String url, BaseModel<T> baseModel, String? data, String? token) async {
  //   Response res;

  //   try {
  //     res =
  //         await http.post(Uri.parse(url), body: data, headers: <String, String>{
  //       "Access-Control-Allow-Origin": "*",
  //       'Content-Type': 'application/json',
  //       'Accept': '*/*',
  //       'Authorization': token ?? "",
  //     });
  //     //Refresh token mekanizması için
  //     if (res.statusCode == 401) {}

  //     return handleResponse(res, baseModel);
  //   } catch (e) {
  //     print(e);
  //   }
  //   return ResponseModel<R>(error: true, description: "Servise bağlanılamadı.");
  // }

  // Future<ResponseModel<R>> getData<R, T>(
  //     String url, BaseModel<T> baseModel, String? token) async {
  //   ResponseModel<R> responseModel = ResponseModel();

  //   try {
  //     var res = await http.get(Uri.parse(url), headers: <String, String>{
  //       'Authorization': token ?? "",
  //     });
  //     //Refresh token mekanizması için
  //     if (res.statusCode == 401) {}
  //     return handleResponse(res, baseModel);
  //   } catch (e) {
  //     responseModel.error = true;
  //     responseModel.description = "Servise bağlanılamadı";
  //     print(e);
  //   }

  //   return responseModel;
  // }

  // Future<ResponseModel<R>> putData<R, T>(
  //     String url, BaseModel<T> baseModel, String? data, String? token) async {
  //   Response res;

  //   try {
  //     res =
  //         await http.put(Uri.parse(url), body: data, headers: <String, String>{
  //       "Access-Control-Allow-Origin": "*",
  //       'Content-Type': 'application/json',
  //       'Accept': '*/*',
  //       'Authorization': token ?? "",
  //     });
  //     return handleResponse(res, baseModel);
  //   } catch (e) {
  //     print(e);
  //   }
  //   return ResponseModel<R>(error: true, description: "Servise bağlanılamadı");
  // }

  Future<Response> getResponse(
      HttpMethod httpMethod, String url, String? token, String? data) async {
    Response res;
    switch (httpMethod) {
      case HttpMethod.GET:
        res = await http.get(Uri.http(SERVER, url), headers: <String, String>{
          "Access-Control-Allow-Origin": "*",
          'Content-Type': 'application/json',
          'Accept': '*/*',
          'Authorization': "Bearer " + (token ?? ""),
        });
        break;

      case HttpMethod.POST:
        res = await http
            .post(Uri.http(SERVER, url), body: data, headers: <String, String>{
          "Access-Control-Allow-Origin": "*",
          'Content-Type': 'application/json',
          'Accept': '*/*',
          'Authorization': "Bearer " + (token ?? ""),
        });
        break;

      case HttpMethod.PUT:
        res = await http
            .put(Uri.http(SERVER, url), body: data, headers: <String, String>{
          "Access-Control-Allow-Origin": "*",
          'Content-Type': 'application/json',
          'Accept': '*/*',
          'Authorization': "Bearer " + (token ?? ""),
        });
        break;
    }
    return res;
  }

  ResponseModel<R> handleResponse<R, T>(Response res, BaseModel<T> baseModel) {
    ResponseModel<R> result = ResponseModel();
    switch (res.statusCode) {
      case 200:
        if (jsonDecode(utf8.decode(res.body.codeUnits)) != null) {
          var jsonBody = jsonDecode(utf8.decode(res.body.codeUnits));
          result = result.fromJson(jsonBody);
          if ((!result.error!) && jsonBody['data'] != null) {
            if (jsonBody['data'] is List) {
              result.data = jsonBody['data']
                  .map((json) => baseModel.fromJson(json))
                  .toList()
                  .cast<T>() as R;
            } else {
              result.data = baseModel.fromJson(jsonBody["data"]) as R;
            }
          }

          //result.data =
          //  resultList.map((json) => baseModel.fromJson(json)).toList() as R;
        } else {
          result.error = true;
          result.description = "Servise bağlanılamadı";
        }
        break;
      default:
        result.error = true;
        break;
    }
    return result;
  }
}

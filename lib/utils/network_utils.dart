import 'dart:convert';

import 'package:http/http.dart';
import 'package:nb_utils/nb_utils.dart';

import 'config.dart';

Future<Response> postRequest(String endPoint, body,
    {String baseUrl = 'http://127.0.0.1:8000'}) async {
  try {
    if (!await isNetworkAvailable()) throw noInternetMsg;

    final String url = "$baseUrl$endPoint";

    //
    //

    final Response response = await post(Uri.parse(url),
            body: jsonEncode(body),
            headers: {"Content-Type": "application/json"})
        .timeout(const Duration(seconds: timeoutDuration),
            onTimeout: (() => throw "request timeout. try again"));

    return response;
  } catch (e) {
    //

    if (!await isNetworkAvailable()) {
      // toast("Check your internet");
      throw noInternetMsg;
    } else if (e.toString().contains("SocketException")) {
      // toast("Check your internet");
      throw noInternetMsg;
    } else if (e.toString().contains("request timeout. try again")) {
      // print(e);
      throw "request timeout. try again";
    } else {
      // print(e);
      throw "Please try again";
    }
  }
}

Future<Response> getRequest(String endPoint) async {
  try {
    if (!await isNetworkAvailable()) throw noInternetMsg;

    final String url = '$baseURL$endPoint';

    final Response response = await get(Uri.parse(url)).timeout(
        const Duration(seconds: timeoutDuration),
        onTimeout: (() => throw "Please try again"));

    return response;
  } catch (e) {
    //
    if (!await isNetworkAvailable()) {
      throw noInternetMsg;
    } else {
      throw "Please try again";
    }
  }
}

Future handleResponse(Response response) async {
  if (response.statusCode.isSuccessful()) {
    return jsonDecode(response.body);
  } else {
    if (response.body.isJson()) {
      // print(response.body);
      throw jsonDecode(response.body);
    } else {
      if (!await isNetworkAvailable()) {
        throw noInternetMsg;
      } else {
        // print(response.body);
        throw 'try again';
      }
    }
  }
}

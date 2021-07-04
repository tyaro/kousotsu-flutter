import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'model/ChangeRateInfo.dart';

//final endpoint = 'https://kousotsu-py.info/cryptoinfo/json/';
final endpoint = 'http://localhost:8082/';

List<ChangeRateInfo> parseChangeRateInfo(String responseBody){
  var list = json.decode(responseBody) as List;
  List<ChangeRateInfo> changeRateInfos = list.map((model) => ChangeRateInfo.fromJson(model)).toList();
  return changeRateInfos;
}

Future<List<ChangeRateInfo>> fetchChangeRateInfo() async{
  final uri = endpoint + 'ChangeRate';
  http.Response response = await http.get(Uri.parse(uri));
  //print(response.body);
  if (response.statusCode == 200){
    return compute(parseChangeRateInfo,response.body);
  }else{
    throw Exception('response error');
  }
}

Future<List<ChangeRateInfo>> fetchChangeRateSpotInfo() async{
  final uri = endpoint + 'ChangeRateSpot';
  http.Response response = await http.get(Uri.parse(uri));
  //print(response.body);
  if (response.statusCode == 200){
    return compute(parseChangeRateInfo,response.body);
  }else{
    throw Exception('response error');
  }
}
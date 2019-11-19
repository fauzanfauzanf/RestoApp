
import 'package:http/http.dart';
import 'package:resto_app/model/resto.dart';
import 'dart:convert';

class ApiClient {

  static var baseUrl = "http://ec2-54-255-192-5.ap-southeast-1.compute.amazonaws.com:3333";

  Future<Resto> getListResto(lat, long) async {
    try {
      Response _response = await doGet(lat, long);
      Resto resto = Resto.fromJson(json.decode(_response.body));
      print(_response.body);

      return resto;
    } catch(e){
      print(e);
      return null;
    }
  }

  Future<Response> doGet(lat, long) async {
    var client = new Client();
    String url = "$baseUrl/map?location=$lat,$long";
    url = '$url';
//    print(url);
    return client
        .get(url,)
        .catchError((e){
      print(e);
    });
  }
}
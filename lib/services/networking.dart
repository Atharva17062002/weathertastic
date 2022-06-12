import 'dart:convert';

import 'package:http/http.dart';

class NetworkHelper{
  String Url;

  NetworkHelper( this.Url);

  Future getData() async{
    Response response =await get(Uri.parse(Url));
    if(response.statusCode == 200){
      String data =response.body;
      return jsonDecode(data);
    }else{
      print(response.statusCode);
    }
  }
}
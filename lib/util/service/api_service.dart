import 'dart:async';
import 'dart:developer';

import 'package:dio/dio.dart';

class ApiService{
  final Dio dio = Dio( BaseOptions(
    baseUrl: 'https://jsonplaceholder.typicode.com',
  ));

  Future<dynamic> getApi({required String url})async{
    try{
     var response = await dio.get(url);
     if(response.statusCode == 200){
       if(response.data != null ){
         log('Data from Api :: ${response.data}');
         return response.data;
       }
     }
    }catch(e){
      log('Error :: ${e.toString()}');

    }
    return null;
  }
}
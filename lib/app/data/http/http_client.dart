/*
//
//Criando uma classe abstrata que contém a função get e implementando ela na classe HttpClient onde 
//será reescrita a função get e tratada a url que irá receber
//
// @autor Vitor Reis
*/

import 'package:http/http.dart' as http;

abstract class IHttpClient {
  Future get({required String url});
}

class HttpClient implements IHttpClient {
  final client = http.Client();

  @override
  Future get({required String url}) async {
    return await client.get(Uri.parse(url));
  }
}

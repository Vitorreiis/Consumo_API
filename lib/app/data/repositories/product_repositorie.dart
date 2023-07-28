/*
//
//Criando uma classe abstrata que contém a função getProducts e implementando ela na classe ProductRepository onde 
//será reescrita a função getProducts e tratar o retorno da API e tratada as excessões
//
// @autor Vitor Reis
*/

import 'dart:convert';

import 'package:app_consumo_api/app/data/http/exceptions.dart';
import 'package:app_consumo_api/app/data/http/http_client.dart';
import 'package:app_consumo_api/app/models/product_model.dart';

abstract class IProductRepository {
  Future<List<ProductModel>> getProducts();
}

class ProductRepository implements IProductRepository {
  final IHttpClient client;

  ProductRepository({required this.client});

  @override
  Future<List<ProductModel>> getProducts() async {
    //armazenando o que será retornado do link da API na variavel response
    final response = await client.get(
      url: 'https://jsonplaceholder.typicode.com/todos',
    );

//tratamento de excessões
    if (response == null) {
      throw Exception('Resposta nula ao tentar obter produtos');
    } else if (response.statusCode == 200) {
      final List<ProductModel> products = [];

      final body = jsonDecode(response.body);

      body.forEach((item) {
        final ProductModel produto = ProductModel.fromMap(item);
        products.add(produto);
      });

      return products;
    } else if (response.statusCode == 404) {
      throw NotFoundException(mensage: 'A url informada não é válida');
    } else {
      throw Exception('Não foi possível carregar os produtos');
    }
  }
}

/*
//
//Classe onde será tratada cada estado do app
//
// @autor Vitor Reis
*/

import 'package:app_consumo_api/app/data/http/exceptions.dart';
import 'package:app_consumo_api/app/data/repositories/product_repositorie.dart';
import 'package:app_consumo_api/app/models/product_model.dart';
import 'package:flutter/material.dart';

class ProdutoStore {
  final IProductRepository repository;

  ProdutoStore({required this.repository});

//Variavel reativa para o loading
  final ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);
//Variavel reativa para o state
  final ValueNotifier<List<ProductModel>> state =
      ValueNotifier<List<ProductModel>>([]);
//Variavel reativa para o erro
  final ValueNotifier<String> erro = ValueNotifier<String>('');

  Future getProducts() async {
    isLoading.value = true;

    try {
      final result = await repository.getProducts();

      state.value = result;
    } on NotFoundException catch (e) {
      erro.value = e.mensage;
    } catch (e) {
      erro.value = e.toString();
    }

    isLoading.value = false;
  }
}

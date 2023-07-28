/*
//
//Classe onde será construida a tela de HomePage para cada estado do app
//
// @autor Vitor Reis
*/

import 'package:app_consumo_api/app/data/http/http_client.dart';
import 'package:app_consumo_api/app/data/repositories/product_repositorie.dart';
import 'package:app_consumo_api/app/pages/stores/product_store.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ProdutoStore store = ProdutoStore(
    repository: ProductRepository(
      client: HttpClient(),
    ),
  );

  @override
  void initState() {
    super.initState();
    store.getProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Consumindo API"),
      ),
      body: AnimatedBuilder(
        animation: Listenable.merge([
          store.erro,
          store.isLoading,
          store.state,
        ]),
        builder: (context, child) {
          if (store.isLoading.value) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (store.erro.value.isNotEmpty) {
            return Center(
              child: Text(
                store.erro.value,
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                ),
                textAlign: TextAlign.center,
              ),
            );
          }

          if (store.state.value.isEmpty) {
            return const Center(
              child: Text(
                'Nenhum item na lista',
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                ),
                textAlign: TextAlign.center,
              ),
            );
          } else {
            return ListView.builder(
                itemCount: store.state.value.length,
                padding: const EdgeInsets.all(16),
                itemBuilder: (_, index) {
                  final item = store.state.value[index];
                  return Text(item.title);
                });
          }
        },
      ),
    );
  }
}

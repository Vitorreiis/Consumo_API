/*
//
//Criando uma classe onde será o modelo do produto, passando as variaveis onde será armazenadas cada conteúdo
// e passsando para o construtor
//
// @autor Vitor Reis
*/

class ProductModel {
  final String title;

  ProductModel({
    required this.title,
  });

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      title: map['title'],
    );
  }
}

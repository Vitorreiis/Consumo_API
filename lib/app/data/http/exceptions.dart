/*
//
//Criando uma classe personalizada que implementa de Exception e que recebe uma String no construtor
//
// @autor Vitor Reis
*/

class NotFoundException implements Exception {
  final String mensage;

  NotFoundException({required this.mensage});
}

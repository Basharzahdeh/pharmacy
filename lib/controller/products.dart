import 'dart:io';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Product {
  final  id;
  final  title;
  final  description;
  final  price;
  final  imageUrl;
  final  section;

  Product({
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.price,
    @required this.imageUrl,
    @required this.section,
  });
}

class Products extends GetxController {
  List<Product> productsList = <Product>[].obs ;
  List nameProducts=[].obs;
  List descProducts=[].obs;
  String? authToken;

  //Products(this.authToken,this.productsList);
  final database = FirebaseDatabase.instance.reference().child('product');
  Reference storage = FirebaseStorage.instance.ref().child('product_image');

  getData(String authToken2, List<Product> productsList2) {
    authToken = authToken2;
    productsList = productsList2;
  }
  Future<void> fetchData() async {
    try {
      final extractedData = await database.once().then((DataSnapshot snapshot) {
        Map<dynamic, dynamic> values = snapshot.value;
        values.forEach((prodId, prodData) {
          final prodIndex =
              productsList.indexWhere((element) => element.id == prodId);
          if (prodIndex >= 0) {
            productsList[prodIndex] = Product(
                id: prodData['id'],
                title: prodData['title'],
                description: prodData['description'],
                price: prodData['price'],
                imageUrl: prodData['imageUrl'],
              section: prodData['section']
                );
            nameProducts=[prodData['title'],prodData['id']];
            descProducts=[prodData['description'],prodData['id']];
          } else {
            productsList.add(Product(
                id: prodData['id'],
                title: prodData['title'],
                description: prodData['description'],
                price: prodData['price'].toDouble(),
                imageUrl: prodData['imageUrl'],
              section: prodData['section']
                ));
            nameProducts.add(prodData['title']);
            descProducts.add(prodData['description']);
          }
        });
      });
    } catch (error) {
      throw error;
    }
  }
}
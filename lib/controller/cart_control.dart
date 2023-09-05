import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_proj/utils/storage.dart';

class Cart {
  final  id;
  final  title;
  final  price;
  final  imageUrl;
  double? total;
  int? itemCount;

  Cart({
    required this.id,
    required this.title,
    required this.price,
    required this.imageUrl,
    required this.itemCount,
    required this.total,
  });
}

class Cart_Control extends GetxController {

  List<Cart> carttsList = <Cart>[].obs;
  String? authToken;
  List idProducts = [].obs;

  getData(String authToken2, List<Cart> cartList2) {
    authToken = authToken2;
    carttsList = cartList2;
  }

  DatabaseReference database=FirebaseDatabase.instance.reference().child('Cart').child(Storage().getUid());
 /* @override
  void onInit() async {

    print("call onInit");  // this line not printing
    final i= Storage().getUid();
    print("call onInit:::::::::::"+i);
    database=FirebaseDatabase.instance.reference().child('Cart').child(i);
    super.onInit();
  }*/
  Future<void> fetchData() async {
    try {
      final extractedData = await database
          .child('ProductCart')
          .once()
          .then((DataSnapshot snapshot) {
        Map<dynamic, dynamic> values = snapshot.value;
        values.forEach((prodId, prodData) {
          final prodIndex =
              carttsList.indexWhere((element) => element.id == prodId);
          if (prodIndex >= 0) {
            carttsList[prodIndex] = Cart(
              id: prodData['id'],
              title: prodData['title'],
              price: prodData['price'].toDouble(),
              imageUrl: prodData['imageUrl'],
              itemCount: prodData['itemCount'], total: prodData['total'],
            );
            idProducts.add(prodData['id']);
          } else {
            carttsList.add(Cart(
              id: prodData['id'],
              title: prodData['title'],
              price: prodData['price'].toDouble(),
              imageUrl: prodData['imageUrl'],
              itemCount: prodData['itemCount'],
                total: prodData['total']
            ));
            idProducts.add(prodData['id']);
          }
        });
      });
    } catch (error) {
      throw error;
    }
  }

  Future<void> add(
      {String? id,
      String? title,
      double? price,
      String? imageUrl,
      int? itemCount}) async {
    try {
      idProducts.add(id);
      await database.child('ProductCart').child(id!).set({
        "title": title,
        "id": id,
        "price": price,
        "imageUrl": imageUrl,
        "itemCount": itemCount,
      });
      carttsList.add(Cart(
          id: id!,
          title: title!,
          price: price!,
          imageUrl: imageUrl!,
          itemCount: itemCount!, total: price,
      ));
    } catch (error) {
      throw error;
    }
  }

  Future<void> updateCount(String id, int count, double pri) async {
    final prodIndex = carttsList.indexWhere((element) => element.id == id);
    try {
      await database.child('ProductCart').child(id).update({
        'itemCount': count,
      });
    } catch (error) {
      throw error;
    }
  }

  Future<void> delete(String id) async {
    final prodIndex = carttsList.indexWhere((element) => element.id == id);
    var prodItem = carttsList[prodIndex];
    carttsList.removeAt(prodIndex);
    await database.child('ProductCart').child(id).remove();
    prodItem = null!;
  }

  Future<void> addInfo(
      {String? name,
      String? number,
      String? address,
      String? dropdownValue}) async {
    try {
      await database.child('Info').set({
        "Name": name,
        "address": address,
        "number": number,
        "payment_method": dropdownValue,
        "time":
            DateFormat('MM/dd/yyyy hh:mm:ss').format(DateTime.now()).toString(),
      });
    } catch (error) {
      throw error;
    }
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_proj/controller/cart_control.dart';
import 'package:test_proj/controller/products.dart';


class ProductDetails extends StatefulWidget {
  final String id;

  ProductDetails(this.id);

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  final Cart_Control CartController = Get.put(Cart_Control());

  @override
  Widget build(BuildContext context) {
    var prodList = Get
        .put(Products())
        .productsList;
    final Products productsController = Get.put(Products());
    var filteredItem =
    prodList.firstWhere((element) => element.id == widget.id,
        orElse: () => null!);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: filteredItem == null ? null : Text(filteredItem.title),
      ),
      body: filteredItem == null
          ? null
          : ListView(
        children: [
          const SizedBox(height: 10),
          buildContainer(filteredItem.imageUrl, filteredItem.id),
          const SizedBox(height: 10),
          buildCard(filteredItem.title, filteredItem.description,
              filteredItem.price),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                  color: Colors.orangeAccent,
                  borderRadius: BorderRadius.circular(100)),
              child: TextButton(
                onPressed: () async {
                  print(CartController.idProducts);
                  if(CartController.idProducts.contains(filteredItem.id) == false){
                    await CartController.add(
                        title: filteredItem.title,
                        price: filteredItem.price,
                        id: filteredItem.id,
                        imageUrl: filteredItem.imageUrl,
                        itemCount: 1
                    ).then((value) async{
                     return
                          showDialog<Null>(
                            context: context,
                            builder: (innerContext) =>
                            const AlertDialog(
                              title: Text("Product!"),
                              content: Text('Product added.'),
                            ),
                          );
                    });}else{
                    return showDialog<Null>(
                      context: context,
                      builder: (innerContext) =>
                      const AlertDialog(
                        title: Text("Product!"),
                        content: Text('The product has already been added.'),
                      ),
                    );
                  }
                },
                child: const Text(
                  "Add To Bag",
                  style: TextStyle(fontSize: 20, color: Colors.black),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
  SizedBox buildContainer(String image, String id) {
    return SizedBox(
      width: double.infinity,
      child: Center(
        child: Hero(
          tag: id,
          child: (image != null)
              ? Image.network(
            image,
            fit: BoxFit.fill,
            height: 200,
          )
              : Image.network('https://i.imgur.com/sUFH1Aq.png'),
        ),
      ),
    );
  }

  Card buildCard(String title, String desc, double price) {
    return Card(
      elevation: 10,
      margin: const EdgeInsets.all(7),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              title,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const Divider(color: Colors.black),
            Text(desc,
                style: const TextStyle(fontSize: 16),
                textAlign: TextAlign.justify),
            const Divider(color: Colors.black),
            Text(
              "\$$price",
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}

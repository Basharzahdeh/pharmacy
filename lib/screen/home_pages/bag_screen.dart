import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_proj/controller/cart_control.dart';
import 'package:test_proj/screen/auth_screen/login_page.dart';
import 'package:test_proj/screen/home_pages/product_details.dart';
import 'package:test_proj/utils/storage.dart';

import 'checkout_screen.dart';

class Bag_screen extends StatefulWidget {
  @override
  State<Bag_screen> createState() => _Bag_screenState();
}

class _Bag_screenState extends State<Bag_screen> {
  final Cart_Control cartList = Get.find();
  int _itemCount = 1;

  @override
  void initState() {
    Get.put(Cart_Control()).fetchData().then((_) {
      setState(() {

      });
    });
    super.initState();
  }

  @override
  void didUpdateWidget(covariant Bag_screen oldWidget) {
    super.didUpdateWidget(oldWidget);
    Get.put(Cart_Control()).fetchData().then((_) {
      setState(() {});
    });
  }

  double tot() {
    double cartTotal = 0.0;
    cartList.carttsList.forEach((element) {
      if (element.itemCount > 1) {
        cartTotal += (element.price * element.itemCount);
      } else {
        cartTotal += element.price;
      }
    });

    return cartTotal;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: Obx(() {
        return ListView(children: [
          Column(
            children: cartList.carttsList.map((item) {
              if (item.title != '') {
                return Column(children: [
                  Row(
                    children: [
                      Builder(
                        builder: (innerContext) => Container(
                          width: 310,
                          child: FlatButton(
                            onPressed: () {
                              Get.to(() => ProductDetails(item.id));
                            },
                            child: Column(
                              children: [
                                Card(
                                  elevation: 10,
                                  color: Colors.grey,
                                  child: Row(
                                    children: <Widget>[
                                      Expanded(
                                        flex: 1,
                                        child: Container(
                                          padding:
                                              const EdgeInsets.only(right: 10),
                                          width: 70,
                                          height: 100,
                                          child: (item.imageUrl != null)
                                              ? Image.network(
                                                  item.imageUrl,
                                                  fit: BoxFit.fill,
                                                  width: 50,
                                                  height: 50,
                                                )
                                              : Image.network(
                                                  'https://i.imgur.com/sUFH1Aq.png'),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            const SizedBox(height: 10),
                                            Text(
                                              item.title,
                                              style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold),
                                              softWrap: true,
                                              textAlign: TextAlign.left,
                                              maxLines: 3,
                                            ),
                                            SizedBox(width: 13),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 5),
                                        child: Text(
                                          "\$${item.price}",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 18),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      IconButton(
                          onPressed: () async {
                            await cartList
                                .delete(item.id)
                                .then((value) => null);
                          },
                          icon: Icon(Icons.delete, color: Colors.amberAccent))
                    ],
                  ),
                  Container(
                    color: Colors.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        item.itemCount != 0
                            ? IconButton(
                                icon: const Icon(Icons.remove),
                                onPressed: () async {
                                  await cartList.updateCount(
                                      item.id, item.itemCount - 1, item.price);
                                  Get.put(Cart_Control()).fetchData().then((_) {
                                    setState(() {});
                                  });
                                },
                              )
                            : Container(),
                        Text(item.itemCount.toString()),
                        IconButton(
                            icon: const Icon(Icons.add),
                            onPressed: () async {
                              await cartList.updateCount(
                                  item.id, item.itemCount + 1, item.price);
                              Get.put(Cart_Control()).fetchData().then((_) {
                                setState(() {});
                              });
                            })
                      ],
                    ),
                  ),
                ]);
              } else {
                return const SizedBox();
              }
            }).toList(),
          ),
          Center(
              child: Text(
            'Total :${tot()}',
            style: const TextStyle(fontSize: 15),
          )),
          Container(
            color: Colors.amberAccent,
            child: ListTile(
              title: const Center(
                  child: Text('Check Out', style: TextStyle(fontSize: 20))),
              onTap: () async {
                await Storage().getLoginValue().then((value) => value
                    ? Get.to(() => AddAddress())
                    : showDialog<void>(
                        context: context,
                        builder: (innerContext) => AlertDialog(
                          title: const Text("Log In!"),
                          content: const Text(
                              'You must be logged in before placing your order.'),
                          actions: <Widget>[
                            ElevatedButton(
                              child: const Text("Ok"),
                              onPressed: () {
                                return Get.to(() => const LoginPage());
                              },
                            ),
                          ],
                        ),
                      ));
              },
            ),
          )
        ]);
      })),
    );
  }
}

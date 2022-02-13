import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_proj/controller/products.dart';
import 'package:test_proj/screen/home_pages/product_details.dart';
import 'package:url_launcher/url_launcher.dart';

import 'detail_card.dart';

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int currentInex = 0;
  List imageList = [
    'image/drugs.jpg',
    'image/beautyCare.jpg',
    'image/PersonalCare.jpg',
  ];
  bool _isLoading = true;

  @override
  void didUpdateWidget(covariant MyHomePage oldWidget) {
    super.didUpdateWidget(oldWidget);
    Get.put(Products()).fetchData().then((_) {
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    Get.put(Products()).fetchData().then((_) {
      setState(() {
        _isLoading = false;
      });
    }).catchError((onError) => print(onError));
  }

  @override
  Widget build(BuildContext context) {
    void whatsappr() async {
      var whatsapp = "+962780156624";
      var whatsappURl_android =
          "whatsapp://send?phone=" + whatsapp + "&text=مرحبا";
      var whatappURL_ios = "https://wa.me/$whatsapp?text=${Uri.parse("hello")}";
      if (Platform.isIOS) {
        // for iOS phone only
        if (await canLaunch(whatappURL_ios)) {
          await launch(whatappURL_ios, forceSafariVC: false);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("whatsapp no installed")));
        }
      } else {
        if (await canLaunch(whatsappURl_android)) {
          await launch(whatsappURl_android);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("whatsapp no installed")));
        }
      }
    }

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 8,
            ),
            child: CarouselSlider.builder(
              itemCount: imageList.length,
              itemBuilder: (BuildContext ctx, int index, _) {
                return Container(
                  width: double.infinity,
                  child: Image.asset(
                    imageList[index],
                    fit: BoxFit.fitWidth,
                  ),
                );
              },
              options: CarouselOptions(
                onPageChanged: (index, _) {
                  setState(() {
                    currentInex = index;
                  });
                },
                scrollDirection: Axis.horizontal,
                autoPlayInterval: const Duration(seconds: 2),
                enableInfiniteScroll: false,
                autoPlay: true,
                height: 150,
                initialPage: 0,
                enlargeCenterPage: true,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Container(
            child: Container(
              child: Column(
                children: [
                  ListTile(
                    title: const Text('Drugs And Medicines Section'),
                    trailing: const Icon(Icons.arrow_forward_ios),
                    onTap: () => Get.to(() => detailCard('Medicine')),
                    tileColor: Colors.grey.shade300,
                  ),
                  Container(
                      child: CarouselSlider(
                    items: [
                      {
                        "url":
                            "https://firebasestorage.googleapis.com/v0/b/pharmacy-feb4d.appspot.com/o/product_image%2F123.jpg?alt=media&token=ecda3a75-3ad3-4e84-821a-8d8251b0763e",
                        "routeName": "123",
                      },
                      {
                        "url":
                            "https://firebasestorage.googleapis.com/v0/b/pharmacy-feb4d.appspot.com/o/product_image%2F1457.jpg?alt=media&token=ece2da33-7ee9-45ed-b992-89b9f60d0460",
                        "routeName": "1457"
                      },
                      {
                        "url":
                            "https://firebasestorage.googleapis.com/v0/b/pharmacy-feb4d.appspot.com/o/product_image%2F49rj.jpg?alt=media&token=77476188-603a-40a9-ab74-0b10cc1f6681",
                        "routeName": "49rj"
                      },
                    ].map((i) {
                      return Builder(
                        builder: (BuildContext context) {
                          return Container(
                              width: MediaQuery.of(context).size.width,
                              margin: EdgeInsets.symmetric(horizontal: 5.0),
                              child: GestureDetector(
                                  child:
                                      Image.network(i["url"], fit: BoxFit.fill),
                                  onTap: () {
                                    print('i $i');
                                    Get.to(
                                        () => ProductDetails(i["routeName"]));
                                  }));
                        },
                      );
                    }).toList(),
                    options: CarouselOptions(
                      scrollDirection: Axis.horizontal,
                      autoPlayInterval: const Duration(seconds: 2),
                      enableInfiniteScroll: false,
                      height: 150,
                      initialPage: 0,
                    ),
                  ))
                ],
              ),
            ),
          ),
          Container(
            child: Column(
              children: [
                ListTile(
                  title: const Text('Beauty Care Section'),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () => Get.to(() => detailCard('Beauty Tools')),
                  tileColor: Colors.grey.shade300,
                ),
                Container(
                    child: CarouselSlider(
                  items: [
                    {
                      "url":
                          "https://firebasestorage.googleapis.com/v0/b/pharmacy-feb4d.appspot.com/o/product_image%2F79wj.jpg?alt=media&token=13ff04e6-da7e-4719-a8c1-38a384dc3853",
                      "routeName": "79wj",
                    },
                    {
                      "url":
                          "https://firebasestorage.googleapis.com/v0/b/pharmacy-feb4d.appspot.com/o/product_image%2F83hdjs.jpg?alt=media&token=d8755f36-27e3-4c3a-92ca-87b944ed407b",
                      "routeName": "83hdjs"
                    },
                    {
                      "url":
                          "https://firebasestorage.googleapis.com/v0/b/pharmacy-feb4d.appspot.com/o/product_image%2F83ih.jpg?alt=media&token=008b2125-12b6-4d07-941d-fb95ea3d3443",
                      "routeName": "83ih"
                    },
                  ].map((i) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Container(
                            width: MediaQuery.of(context).size.width,
                            margin: EdgeInsets.symmetric(horizontal: 5.0),
                            child: GestureDetector(
                                child:
                                    Image.network(i["url"], fit: BoxFit.fill),
                                onTap: () {
                                  print('i $i');
                                  Get.to(() => ProductDetails(i["routeName"]));
                                }));
                      },
                    );
                  }).toList(),
                  options: CarouselOptions(
                    scrollDirection: Axis.horizontal,
                    autoPlayInterval: const Duration(seconds: 2),
                    enableInfiniteScroll: false,
                    height: 150,
                    initialPage: 0,
                  ),
                ))
              ],
            ),
          ),
          Container(
            child: Column(
              children: [
                ListTile(
                  title: const Text('Personal Care Section'),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () => Get.to(() => detailCard('Body Care')),
                  tileColor: Colors.grey.shade300,
                ),
                Container(
                    child: CarouselSlider(
                  items: [
                    {
                      "url":
                          "https://firebasestorage.googleapis.com/v0/b/pharmacy-feb4d.appspot.com/o/product_image%2F93b.jpg?alt=media&token=ab3cd7bd-f4bd-4db4-8f86-6729dc471bfb",
                      "routeName": "93b",
                    },
                    {
                      "url":
                          "https://firebasestorage.googleapis.com/v0/b/pharmacy-feb4d.appspot.com/o/product_image%2F78y.jpg?alt=media&token=12eb0843-c008-45bb-84c5-e5a90d8e5bac",
                      "routeName": "78y"
                    },
                    {
                      "url":
                          "https://firebasestorage.googleapis.com/v0/b/pharmacy-feb4d.appspot.com/o/product_image%2F39ej.jpg?alt=media&token=852e8a98-66ad-44b3-ad1c-df84951eb5e4",
                      "routeName": "39ej"
                    },
                  ].map((i) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Container(
                            width: MediaQuery.of(context).size.width,
                            margin: EdgeInsets.symmetric(horizontal: 5.0),
                            child: GestureDetector(
                                child:
                                    Image.network(i["url"], fit: BoxFit.fill),
                                onTap: () {
                                  print('i $i');
                                  Get.to(() => ProductDetails(i["routeName"]));
                                }));
                      },
                    );
                  }).toList(),
                  options: CarouselOptions(
                    scrollDirection: Axis.horizontal,
                    autoPlayInterval: const Duration(seconds: 2),
                    enableInfiniteScroll: false,
                    height: 150,
                    initialPage: 0,
                  ),
                ))
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 30,left: 20,right: 20),
            child: Container(
              height: 180,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage(
                    'image/contact3.jpg',
                  ),
                ),
              ),
              child: ListTile(
                contentPadding:
                    const EdgeInsets.only(top: 20, left: 10, right: 10),
                tileColor: Colors.orangeAccent,
                onTap: whatsappr,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

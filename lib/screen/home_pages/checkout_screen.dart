import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_proj/controller/cart_control.dart';
import 'package:test_proj/utils/storage.dart';
import 'package:toast/toast.dart';

class AddAddress extends StatefulWidget {
  @override
  State<AddAddress> createState() => _AddAddressState();
}

class _AddAddressState extends State<AddAddress> {
  final Cart_Control cartController = Get.put(Cart_Control());

  String dropdownValue = 'Cash';
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneNumController = TextEditingController();
  TextEditingController adreesController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.amberAccent,
            title: const Text(
              'To Complete Your Order',
              style: TextStyle(
                color: Colors.black,
                fontSize: 18.0,
              ),
            )),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const SizedBox(
                  height: 25.0,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20.0),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: Colors.white60,
                      borderRadius: BorderRadius.circular(0)),
                  child: TextField(
                      controller: nameController,
                      cursorColor: Colors.black,
                      decoration: const InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(width: 0.0),
                          ),
                          hintText: 'Enter Your Name',
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(width: 0.0),
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.lightGreen, width: 0.0),
                          ))),
                ),
                const SizedBox(
                  height: 30.0,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20.0),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: Colors.white60,
                      borderRadius: BorderRadius.circular(20)),
                  child: TextField(
                      controller: phoneNumController,
                      cursorColor: Colors.black,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(width: 0.0),
                          ),
                          hintText: 'Enter Your Number',
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(width: 0.0),
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.lightGreen, width: 0.0),
                          ))),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20.0),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: Colors.white60,
                      borderRadius: BorderRadius.circular(20)),
                  child: TextField(
                      controller: adreesController,
                      cursorColor: Colors.black,
                      decoration: const InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(width: 0.0),
                          ),
                          hintText: 'Enter Your Address',
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(width: 0.0),
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.lightGreen, width: 0.0),
                          ))),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Payment method :',
                      style: TextStyle(fontSize: 20),
                    ),
                    const SizedBox(
                      width: 10.0,
                    ),
                    DropdownButton<String>(
                      value: dropdownValue,
                      items: <String>['Cash', 'Visa'].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (newValue) {
                        setState(() {
                          dropdownValue = newValue;
                        });
                        if (newValue == 'Visa') {
                          showModalBottomSheet<void>(
                              context: context,
                              builder: (BuildContext context) {
                                return Container(
                                  height: 500,
                                  color: Colors.grey.shade300,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Container(
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 20.0),
                                        alignment: Alignment.center,
                                        decoration: const BoxDecoration(
                                          color: Colors.white60,
                                        ),
                                        child: const TextField(
                                            cursorColor: Colors.black,
                                            decoration: InputDecoration(
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderSide:
                                                      BorderSide(width: 0.0),
                                                ),
                                                hintText: 'Card Number',
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderSide:
                                                      BorderSide(width: 0.0),
                                                ),
                                                border: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.lightGreen,
                                                      width: 0.0),
                                                ))),
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Container(
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 20.0),
                                        alignment: Alignment.center,
                                        decoration: const BoxDecoration(
                                          color: Colors.white60,
                                        ),
                                        child: const TextField(
                                            cursorColor: Colors.black,
                                            decoration: InputDecoration(
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderSide:
                                                      BorderSide(width: 0.0),
                                                ),
                                                hintText: 'CVV',
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderSide:
                                                      BorderSide(width: 0.0),
                                                ),
                                                border: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.lightGreen,
                                                      width: 0.0),
                                                ))),
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Container(
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 20.0),
                                        alignment: Alignment.center,
                                        decoration: const BoxDecoration(
                                          color: Colors.white60,
                                        ),
                                        child: const TextField(
                                            cursorColor: Colors.black,
                                            decoration: InputDecoration(
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderSide:
                                                      BorderSide(width: 0.0),
                                                ),
                                                hintText: 'Expiry Date',
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderSide:
                                                      BorderSide(width: 0.0),
                                                ),
                                                border: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.lightGreen,
                                                      width: 0.0),
                                                ))),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              primary: Colors
                                                  .amberAccent, // background
                                            ),
                                            child: const Text('Close'),
                                            onPressed: () =>
                                                Navigator.pop(context),
                                          ),
                                          const SizedBox(
                                            width: 60,
                                          ),
                                          ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              primary: Colors
                                                  .amberAccent, // background
                                            ),
                                            child: const Text('Save'),
                                            onPressed: () =>
                                                Navigator.pop(context),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                );
                              });
                        }
                      },
                    ),
                  ],
                ),
                const SizedBox(
                  height: 40,
                ),
                Center(
                    child: GestureDetector(
                  onTap: () async {
                    if (nameController.text == "" ||
                        adreesController.text == "" ||
                        phoneNumController.text == "" ||
                        dropdownValue == "") {
                      Toast.show("Please enter all field", context,
                          duration: Toast.LENGTH_LONG);
                    } else {
                      await cartController
                          .addInfo(
                            name: nameController.text,
                            address: adreesController.text,
                            dropdownValue: dropdownValue,
                            number: phoneNumController.text,
                          )
                          .then((value) => Toast.show(
                              "Thank You For Your Order", context,
                              duration: Toast.LENGTH_LONG));
                      await Storage().setcheck(true);
                    }
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: 60,
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: Colors.amberAccent,
                        borderRadius: BorderRadius.circular(20.0)),
                    child: const Text(
                      'Save!',
                      style: TextStyle(fontSize: 30.0),
                    ),
                  ),
                )),
                const SizedBox(
                  height: 25,
                ),
                const SizedBox(
                  height: 25,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project_inmakes/Service/firebase_service.dart';
import 'package:project_inmakes/provider/cart_provider.dart';
import 'package:provider/provider.dart';
import 'package:random_string/random_string.dart';

class ShoppingCart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text("Shopping Cart")),
      body: cart.cartItems.isEmpty
          ? Center(child: Text("Your Cart is Empty"))
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: cart.cartItems.length,
                    itemBuilder: (context, index) {
                      final item = cart.cartItems[index];
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width / 2.5,
                              height: MediaQuery.of(context).size.height / 6,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: (item["image"] != null &&
                                          item["image"].toString().isNotEmpty)
                                      ? NetworkImage(item["image"])
                                      : AssetImage("assets/placeholder.png")
                                          as ImageProvider,
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item["name"] ?? "No Name",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(height: 5),
                                  Row(
                                    children: [
                                      CircleAvatar(
                                        radius: 10,
                                        backgroundColor: Colors.black,
                                        child: Icon(
                                          Icons.check,
                                          color: Colors.white,
                                          size: 15,
                                        ),
                                      ),
                                      SizedBox(width: 5),
                                      Text("M"),
                                      SizedBox(width: 5),
                                      Container(
                                        height: 20,
                                        width:
                                            MediaQuery.of(context).size.width /
                                                7,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              width: 1,
                                              color: Color.fromARGB(
                                                  157, 182, 178, 134)),
                                        ),
                                        child: Text("Qty: 1"),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    "\$${item["price"] ?? "0.0"}",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Color.fromARGB(
                                            255, 189, 200, 200)),
                                  ),
                                  SizedBox(height: 5),
                                  Row(
                                    children: [
                                      Icon(Icons.bookmark_border_outlined),
                                      SizedBox(width: 5),
                                      Text("Next Time Buy"),
                                      Spacer(),
                                      IconButton(
                                        icon: Icon(Icons.delete,
                                            color: Colors.black),
                                        onPressed: () {
                                          cart.removeFromCart(index);
                                        },
                                      ),
                                      Text("Remove")
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                      height: MediaQuery.of(context).size.height / 4,
                      width: double.maxFinite,
                      decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.all(Radius.circular(20.0)),
                          border: Border.all(
                              width: 1,
                              color: Color.fromARGB(255, 231, 214, 214))),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "Payment Details",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 19),
                                ),
                                Spacer(),
                                InkWell(
                                  child: Text(
                                    "Check Order Details",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 19,
                                        color: Colors.blue),
                                  ),
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, "/OrderList");
                                  },
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            Row(
                              children: [
                                Text(
                                  "Offer -",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w100,
                                      fontSize: 19),
                                ),
                                SizedBox(width: 5),
                                Text("Offer not available",
                                    style: TextStyle(fontSize: 19))
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  "Shipping Charge -",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w100,
                                      fontSize: 19),
                                ),
                                SizedBox(width: 5),
                                Text("Free",
                                    style: TextStyle(
                                        color: Colors.green, fontSize: 19))
                              ],
                            ),
                            Row(
                              children: [
                                Column(
                                  children: [
                                    Text("\$${cart.totalPrice}"),
                                    Text("see price details",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w100)),
                                  ],
                                ),
                                SizedBox(width: 10),
                                InkWell(
                                  child: Container(
                                    height:
                                        MediaQuery.of(context).size.height /
                                            16,
                                    width:
                                        MediaQuery.of(context).size.width /
                                            1.6,
                                    color: Colors.deepOrangeAccent,
                                    child: Center(
                                        child: Text("Continue",
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.white))),
                                  ),
                                  onTap: () async {
                                    String orderId = randomAlphaNumeric(10);

                                    List<Map<String, dynamic>> items = cart
                                        .cartItems
                                        .map((item) {
                                      return {
                                        "name": item["name"],
                                        "image": item["image"],
                                        "price": item["price"],
                                        "quantity": 1,
                                      };
                                    }).toList();

                                    Map<String, dynamic> orderData = {
                                      "items": items,
                                      "totalPrice": cart.totalPrice,
                                      "timestamp":
                                          FieldValue.serverTimestamp(),
                                    };

                                    await DatabaseHelper()
                                        .addDetails(orderData, orderId);

                                     

                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(
                                      SnackBar(
                                          content: Text(
                                              "Order placed successfully!")),
                                    );
                                  },
                                )
                              ],
                            )
                          ],
                        ),
                      )),
                )
              ],
            ),
    );
  }
}

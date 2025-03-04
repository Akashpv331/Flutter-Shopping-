import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_inmakes/provider/cart_provider.dart';
import 'package:provider/provider.dart';

class BabyKidz extends StatelessWidget {
  const BabyKidz({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Baby & Kidz"),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.pushNamed(context, "/Cart");
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              sectionTitle("Newest Arrivals", context),
              const SizedBox(height: 5),
              StreamBuilder<QuerySnapshot>(
                stream:
                    FirebaseFirestore.instance.collection('Kidz').snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return const Center(child: Text("No Products Available"));
                  }

                  final products = snapshot.data!.docs;

                  return SizedBox(
                    height: MediaQuery.of(context).size.height / 4,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: products.length,
                      itemBuilder: (context, index) {
                        final productData =
                            products[index].data() as Map<String, dynamic>;

                        String name = productData["name"] ?? "No Name";
                        double price =
                            (productData["price"] as num?)?.toDouble() ?? 0.00;
                        String imageUrl = productData["imageUrl"] ?? "";

                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: InkWell(
                            onTap: () {
                              cart.addToCart({
                                "name": name,
                                "image": imageUrl,
                                "price": price,
                              });

                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text("$name added to cart!"),
                                  duration: const Duration(seconds: 1),
                                ),
                              );
                              Navigator.pushNamed(context, "/Cart");
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: 140,
                                  width: 130,
                                  decoration: BoxDecoration(border: Border.all(width: 1,color: const Color.fromARGB(185, 226, 217, 217)),
                                    image: DecorationImage(
                                      image: NetworkImage(imageUrl),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 5),
                                // Product Name
                                Text(
                                  name,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                // Product Price
                                Text(
                                  "\$${price.toStringAsFixed(2)}",
                                  style: const TextStyle(color: Colors.grey),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
              const SizedBox(height: 20),
              sectionTitle("Featured Products", context),
              const SizedBox(height: 5),
              CarouselSlider(
                items: [
                  "https://img.freepik.com/free-photo/little-fashionista-colored-background-mom-s-shoes_169016-3424.jpg",
                  "https://t4.ftcdn.net/jpg/03/18/30/85/240_F_318308547_FALKncfWsTmjzwd0y0muNeCFOULPLB7Q.jpg",
                  "https://t4.ftcdn.net/jpg/03/18/72/63/240_F_318726381_nEjCk0I7HlQvGFI5HFuUsd85zCad7ONk.jpg",
                  "https://t4.ftcdn.net/jpg/03/18/30/89/240_F_318308901_3q3o1xqc64hpkw1wm3ZV8A8ilkGciWFb.jpg"
                ].map((url) {
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    height: MediaQuery.of(context).size.height / 6,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(url),
                        fit: BoxFit.fill,
                      ),
                    ),
                  );
                }).toList(),
                options: CarouselOptions(
                  height: MediaQuery.of(context).size.height / 5,
                  enlargeCenterPage: true,
                  autoPlay: true,
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enableInfiniteScroll: true,
                  autoPlayAnimationDuration: const Duration(milliseconds: 800),
                  viewportFraction: 0.6,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Section Title Widget
  Widget sectionTitle(String title, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title,
              style:
                  const TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
          const Text(
            "View All",
            style: TextStyle(
                fontSize: 14, color: Color.fromARGB(255, 153, 171, 186)),
          ),
        ],
      ),
    );
  }
}

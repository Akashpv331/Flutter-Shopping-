import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:project_inmakes/provider/cart_provider.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}




class _HomeState extends State<Home> {
  final List<Map<String, dynamic>> productsNewest = [
    {
      "id": "1",
      "name": "Sleeve Dress",
      "price": 499.0,
      "image":
          "https://images.unsplash.com/photo-1550639525-c97d455acf70?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8OHx8ZHJlc3N8ZW58MHx8MHx8fDA%3D",
    },
    {
      "id": "2",
      "name": "Salwar Kameez",
      "price": 599.0,
      "image":
          "https://surekacollection.com/wp-content/uploads/2024/07/Salwar-Kameez-308x462.png",
    },
    {
      "id": "3",
      "name": "Ethnic Maxi Dress",
      "price": 449.0,
      "image":
          "https://surekacollection.com/wp-content/uploads/2024/07/Ethnic-Maxi-Dress-308x462.png"
    },
    {
      "id": "4",
      "name": "Boho Dress",
      "price": 569.0,
      "image":
          "https://makylacreates.com/wp-content/uploads/2022/11/types-of-dresses-blouson-dress-2.webp",
    },
    {
      "id": "5",
      "name": "Corset Dress",
      "price": 569.0,
      "image":
          "https://makylacreates.com/wp-content/uploads/2022/11/types-of-dresses-cocktail-dress-2-1229x1536.webp",
    },
    {
      "id": "6",
      "name": "Corset Dress",
      "price": 569.0,
      "image":
          "https://images.unsplash.com/photo-1605763240000-7e93b172d754?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8N3x8ZHJlc3N8ZW58MHx8MHx8fDA%3D"
    }
  ];
  final List<String> imageUrlsFeature = [
    "https://t4.ftcdn.net/jpg/03/54/36/69/240_F_354366971_n0scSjKZjqmXeJgIwfGp4NbMcdHCu5zX.jpg",
    "https://thumbs.dreamstime.com/b/top-view-fashion-trendy-look-kids-clothes-103930087.jpg",
    "https://www.shutterstock.com/image-photo/composition-fashionable-children-clothes-trendy-260nw-1803148129.jpg",
  ];

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("HOME"),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            tooltip: 'Search',
            onPressed: () {},
          ),
        ],
        leading: IconButton(
          icon: const Icon(Icons.menu),
          tooltip: 'Menu',
          onPressed: () {},
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            
            Container(
              height: MediaQuery.of(context).size.height / 5,
              width: double.infinity,
              color: Colors.amber,
              child: Image.network(
                "https://t4.ftcdn.net/jpg/02/49/50/15/240_F_249501541_XmWdfAfUbWAvGxBwAM0ba2aYT36ntlpH.jpg",
                fit: BoxFit.fill,
              ),
            ),

            SizedBox(height: 10),

            
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  categoryIcon(
                      Icons.person_2_outlined, "Men", Colors.redAccent),
                  categoryIcon(
                      Icons.woman_2_rounded, "Women", Colors.lightBlueAccent),
                  InkWell(
                    child: categoryIcon(Icons.face, "Baby & Kids",
                        const Color.fromARGB(255, 221, 221, 9)),
                    onTap: () {
                      Navigator.pushNamed(context, "/Baby&kidz");
                    },
                  ),
                  categoryIcon(
                      Icons.shopping_bag_outlined, "Bags", Colors.blue),
                  categoryIcon(Icons.living, "Decor", Colors.green),
                ],
              ),
            ),

            SizedBox(height: 10),

            // Newest Arrival Section
            sectionTitle("Newest Arrival"),
            CarouselSlider(
              items: List.generate(productsNewest.length, (index) {
                 var product = productsNewest[index];
                return InkWell(
                  child: Column(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height / 4,
                        width: MediaQuery.of(context).size.width * 0.5,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(image:NetworkImage(product["image"]))
                        ),
                        
                        
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(product["name"],
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold)),
                          SizedBox(height: 5),
                          Text(product["price"].toString(),
                              style: TextStyle(color: Colors.grey)),
                        ],
                      )
                    ],
                  ),
                  onTap: () {
                    cart.addToCart(product);
                          Navigator.pushNamed(context,"/Cart" );
                  },
                );
              }),
              options: CarouselOptions(
                height: MediaQuery.of(context).size.height / 2.5,
                enlargeCenterPage: true,
                autoPlay: true,
                aspectRatio: 16 / 9,
                autoPlayCurve: Curves.fastOutSlowIn,
                enableInfiniteScroll: true,
                autoPlayAnimationDuration: Duration(milliseconds: 800),
                viewportFraction: 0.4,
              ),
            ),

            // Featured Products Section
            sectionTitle("Featured Products"),
            CarouselSlider(
              items: imageUrlsFeature.map((url) {
                return Column(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height / 5,
                      width: MediaQuery.of(context).size.width * 0.5,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Image.network(
                        url,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ],
                );
              }).toList(),
              options: CarouselOptions(
                height: 250,
                enlargeCenterPage: true,
                autoPlay: true,
                aspectRatio: 16 / 9,
                autoPlayCurve: Curves.fastOutSlowIn,
                enableInfiniteScroll: true,
                autoPlayAnimationDuration: Duration(milliseconds: 800),
                viewportFraction: 0.6,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget for Category Icons
  Widget categoryIcon(IconData icon, String label, Color bgColor) {
    return Column(
      children: [
        CircleAvatar(
          radius: 25,
          backgroundColor: bgColor,
          child: Icon(icon, color: Colors.white),
        ),
        SizedBox(height: 5),
        Text(label,
            style: TextStyle(color: bgColor, fontWeight: FontWeight.bold)),
      ],
    );
  }

  // Widget for Section Titles
  Widget sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 8.0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title,
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20)),
          Text("View All",
              style: TextStyle(
                  fontWeight: FontWeight.w300,
                  fontSize: 17,
                  color: const Color.fromARGB(255, 155, 180, 207)))
        ],
      ),
    );
  }
}

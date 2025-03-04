import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;

    List<String> profilelist = [
      "Address Manager",
      "My Order",
      "My Offers",
      "Wishlist",
      "Quick Pay Cards",
      "Help Center"
    ];

     return Theme(
      data: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.black, 
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.black87, 
          titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
          iconTheme: IconThemeData(color: Colors.white),
        ),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.white),
          bodyMedium: TextStyle(color: Colors.white70),
        ),
      ),child: 

     Scaffold(
      appBar: AppBar(
        title: Text("Account"),
        backgroundColor: isDark ? Colors.black : Colors.black, 
      ),
      backgroundColor: isDark ? Colors.black : Colors.white, 
      body: 

         Container(decoration: BoxDecoration(color: Colors.black),
        child: Column(
          children: [
            SizedBox(height: 20),
            CircleAvatar(
              radius: 40,        
              backgroundColor: isDark ? Colors.grey[800] : Colors.grey[300],
              child: Icon(
                Icons.person,  
                size: 60,
                color: isDark ? const Color.fromARGB(255, 110, 81, 81) : Colors.black,
              ),
            ),
            SizedBox(height: 10),
            Text(
              "Akash",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.white : Colors.white,
              ),
            ),
            SizedBox(height: 15),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(12),
              margin: EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                 
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(width: 1, color: Colors.white),),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          "Please verify your email or number",
                          style: TextStyle(
                            fontSize: 16,
                            color: isDark ? Colors.white : Colors.white,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Icon(Icons.email,
                          color: isDark ? Colors.blue[300] : Colors.blue),
                    ],
                  ),
                  SizedBox(height: 8),
                  Center(
                    child: Text(
                      "Get newest offers",
                      style: TextStyle(
                          fontSize: 14,
                          color: isDark ? Colors.grey[400] : Colors.white),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Container(
                        height: 40,
                        width: MediaQuery.of(context).size.width / 1.7,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(9)),
                          border: Border.all(width: .2, color: Colors.white),
                        ),
                        child: Center(child: Text("akash@gmail.com")),
                      ),
                      Container(
                        height: 40,
                        width: MediaQuery.of(context).size.width / 4,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                            border: Border.all(width: .2, color: Colors.white),
                            color: const Color.fromARGB(255, 225, 121, 11)),
                        child: Center(
                            child: Text(
                          "Verify now",
                          style: TextStyle(fontSize: 19),
                        )),
                      ),
                    ],
                  )
                ],
              ),
            ),
            SizedBox(height: 15),
            Expanded(
              child: ListView.builder(
                itemCount: profilelist.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: MediaQuery.of(context).size.height / 15,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              border: Border.all(width: 1, color: Colors.white)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  profilelist[index],
                                ),
                                Icon(Icons.arrow_forward_ios)
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
      ) );
  }
}

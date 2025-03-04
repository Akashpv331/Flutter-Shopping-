import 'package:flutter/material.dart';
import 'package:project_inmakes/Admin/Add_homepage_product.dart';

import 'package:project_inmakes/Admin/Add_kidz_product.dart';

class AdminHome extends StatefulWidget {
  const AdminHome({super.key});

  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Admin Home"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            children: [
              InkWell(
                child: Container(
                    width: double.infinity,
                    height: 50,
                    color: Colors.amber,
                    child: Center(child: Text("kidz dress add"))),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddKidzProduct(),
                      ));
                },
              ),
              SizedBox(
                height: 10,
              ),
              InkWell(
                child: Container(height: 50,width: double.infinity,color: Colors.red,
                  child: Center(child: Text("Home Page Newest Product"))),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>AddHomepageProduct(),
                      ));
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

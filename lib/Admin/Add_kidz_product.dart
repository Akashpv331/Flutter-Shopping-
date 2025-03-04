import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project_inmakes/Screens/Login.dart';

class AddKidzProduct extends StatefulWidget {
  @override
  _AddKidzProductState createState() => _AddKidzProductState();
}

class _AddKidzProductState extends State<AddKidzProduct> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController imageUrlController = TextEditingController();
  bool isLoading = false;

  Future<void> addDress() async {
    if (nameController.text.isEmpty ||
        priceController.text.isEmpty ||
        imageUrlController.text.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Fill all fields!")));
      return;
    }

    setState(() => isLoading = true);

    try {
      await FirebaseFirestore.instance.collection('Kidz').add({
        'name': nameController.text,
        'price': double.parse(priceController.text),
        'imageUrl': imageUrlController.text,
      });

      nameController.clear();
      priceController.clear();
      imageUrlController.clear();
      setState(() => isLoading = false);

      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Dress Added!")));
    } catch (e) {
      setState(() => isLoading = false);
      print("Error: $e");
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Failed to add dress!")));
    }
  }

  Future<void> deleteDress(String docId) async {
    try {
      await FirebaseFirestore.instance.collection('Kidz').doc(docId).delete();
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Dress Deleted!")));
    } catch (e) {
      print("Error: $e");
    }
  }

  Widget DressList() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('Kidz').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Center(child: Text("No Dresses Found"));
        }

        List<QueryDocumentSnapshot> docs = snapshot.data!.docs;

        return Expanded(
          child: ListView.builder(
            itemCount: docs.length,
            itemBuilder: (context, index) {
              var doc = docs[index];
              Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

              return Card(
                elevation: 6,
                margin: EdgeInsets.all(10),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height / 4,
                        width: double.infinity,
                        child: Image.network(
                          data['imageUrl'] ?? "",
                          width: double.infinity,
                          height: 150,
                          fit: BoxFit.fill,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        data['name'],
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 5),
                      Text(
                        "\$${data['price']}",
                        style: TextStyle(fontSize: 16, color: Colors.green),
                      ),
                      IconButton(
                          icon: Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            deleteDress(doc.id);
                          }),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Kids' Dresses"),
        actions: [Icon(Icons.arrow_back_ios_new_outlined)],
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), labelText: "Dress Name"),
            ),
            SizedBox(height: 10),
            TextField(
              controller: priceController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), labelText: "Dress Price"),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 10),
            TextField(
              controller: imageUrlController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), labelText: "Image URL"),
            ),
            SizedBox(height: 10),
            isLoading
                ? CircularProgressIndicator()
                : ElevatedButton(onPressed: addDress, child: Text("Add Dress")),
            SizedBox(height: 20),
            ElevatedButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Login(),
                      ),
                      (route) => false);
                },
                child: Text("Back To Login")),
            DressList(),
          ],
        ),
      ),
    );
  }
}

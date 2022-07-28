import 'package:flutter/material.dart';
import 'package:makerstudio/models/product.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ListingScreen extends StatefulWidget {
  DocumentSnapshot document;
  ListingScreen(this.document);

  @override
  State<ListingScreen> createState() => _ListingScreenState(this.document);
}

class _ListingScreenState extends State<ListingScreen> {
  DocumentSnapshot document;
  _ListingScreenState(this.document);
  var userID;

  Future<void> addToUserFavorites(DocumentSnapshot document) async {

    userID = (await FirebaseAuth.instance.currentUser)?.uid;

    await FirebaseFirestore.instance
        .collection("users")
        .doc(userID)
        .collection('favorites')
        .add({
          'name' : document['name'],
      'author' : document['author'],
      'image' : document['image']// John Doe
        });
    setState(() {

    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 70),
            Expanded(
                flex: 40,
                child: Ink.image(fit: BoxFit.cover,image: NetworkImage((document.data() as dynamic)['image'])),

            ),
            Expanded(
              flex: 30,
              child: Container(
                margin: EdgeInsets.fromLTRB(15, 15, 15, 15),
                child: Column(
                  children: [
                    Text((document.data() as dynamic)['name'], style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
                    SizedBox(height: 15),
                    Text((document.data() as dynamic)['author'], style: TextStyle(fontSize: 16)),

                    // SizedBox(height: 15),
                    // Text(currentViewingProduct.getDescription(), style: TextStyle(fontSize: 16)),
                  ],
                ),
              ),
            ),
            // !DummyData.IsUserListedProduct(currentViewingProduct)?
            Expanded(
              flex: 20,
              child: Container(
                margin: EdgeInsets.fromLTRB(0, 70, 0, 25),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xFF000000),
                    elevation: 0,
                    minimumSize: Size(350, 40),
                  ),
                  child: Text("Save To Favorites", style: TextStyle(fontSize: 18)),
                  onPressed: () {
                    // DummyData.addToCart(currentViewingProduct);
                    addToUserFavorites(document);
                    showDialog(context: context, builder: (context) {
                      return AlertDialog(
                          title: Text("Added to Favorites!"),
                          content: Text((document.data() as dynamic)['name'] + " has been successfully added to favorites.")
                      );
                    });

                  },
                ),
              ),
            ) //: SizedBox(height: 5),
          ],
        ),
      ),
    );
  }
}
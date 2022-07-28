import 'package:flutter/material.dart';
import 'package:makerstudio/models/product.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FavoritedListingScreen extends StatefulWidget {
  DocumentSnapshot document;
  FavoritedListingScreen(this.document);

  @override
  State<FavoritedListingScreen> createState() => _FavoritedListingScreenState(this.document);
}

class _FavoritedListingScreenState extends State<FavoritedListingScreen> {
  DocumentSnapshot document;
  _FavoritedListingScreenState(this.document);
  var userID;

  Future<void> RemoveFromUserFavorites(DocumentSnapshot document) async {

    userID = (await FirebaseAuth.instance.currentUser)?.uid;

    await FirebaseFirestore.instance
        .collection("users")
        .doc(userID)
        .collection('favorites')
        .doc(document.id).delete();
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
                    Text((document.data() as dynamic)['author'], style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
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
                  child: Text("Remove From Favorites", style: TextStyle(fontSize: 18)),
                  onPressed: () {
                    // DummyData.addToCart(currentViewingProduct);
                    RemoveFromUserFavorites(document);
                    showDialog(context: context, builder: (context) {
                      return AlertDialog(
                          title: Text("Removed From Favorites!"),
                          content: Text((document.data() as dynamic)['name'] + " has been successfully removed from favorites.")
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
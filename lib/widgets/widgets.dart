import 'package:flutter/material.dart';
import 'package:makerstudio/screens/listing_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:makerstudio/screens/favorited_listing_screen.dart';

InkWell Listing(QueryDocumentSnapshot document, BuildContext context) {
  return InkWell(
    onTap: () {
      Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ListingScreen(document))
      );
    },
    child: Container(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Container(width: 170, height: 170, child: Ink.image(fit: BoxFit.cover,image: NetworkImage((document.data() as dynamic)['image'])))),
            SizedBox(height: 5),
            Text((document.data() as dynamic)['name'], style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 20)),
            SizedBox(height: 5),
            Text((document.data() as dynamic)['author'] + " ETH", style: TextStyle(fontWeight: FontWeight.w300, color: Colors.black, fontSize: 13)),
          ]
      ),
    ),
  );
}

InkWell ListingFavorite(DocumentSnapshot document, BuildContext context) {

  // QueryDocumentSnapshot document = getProductData(doc);

  return InkWell(
    onTap: () {
      Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => FavoritedListingScreen(document))
      );
    },
    child: Container(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Container(width: 150, height: 130, child: Ink.image(fit: BoxFit.cover,image: NetworkImage((document.data() as dynamic)['image'])))),
            SizedBox(height: 5),
            Text((document.data() as dynamic)['name'], style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 20)),
            SizedBox(height: 5),
            Text((document.data() as dynamic)['author'], style: TextStyle(fontWeight: FontWeight.w300, color: Colors.black, fontSize: 13)),
          ]
      ),
    ),
  );
}


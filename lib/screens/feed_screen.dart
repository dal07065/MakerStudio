
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:makerstudio/models/product.dart';
import 'package:flutter/material.dart';
import 'listing_screen.dart';
import 'package:makerstudio/widgets/widgets.dart';


class FeedScreen extends StatefulWidget {
  // final String documentId;
  FeedScreen();

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  bool isSearching = false;
  TextEditingController searchController = TextEditingController();

  // CollectionReference products = FirebaseFirestore.instance.collection('products');

  // List<QuerySnapshot> list = FirebaseFirestore.instance.collection('products').get();
  //     .then((QuerySnapshot querySnapshot) {
  //     querySnapshot.docs.forEach((doc) {
  //     print(doc["first_name"]);
  //   });
  // });

  Future<void> _pullRefresh() async
  {
    setState(() {

    });
  }

  // void setIsSearching() {
  //   setState(() {
  //     isSearching = !isSearching;
  //
  //     if(isSearching) {
  //       filtered = [];
  //       for(int i = 0; i < DummyData.productList.length; i++) {
  //         if(DummyData.productList.elementAt(i).name.contains(searchController.text)) {
  //           filtered.add(DummyData.productList.elementAt(i));
  //         }
  //       }
  //     }
  //     else{
  //       filtered = DummyData.productList;
  //     }
  //   });
  // }

  Stream<List<Product>> readProducts() => FirebaseFirestore.instance
      .collection('products')
      .snapshots()
      .map((snapshot) => snapshot.docs.map((doc) => Product.fromJson(doc.data())).toList());

  Widget buildProduct(Product product) => ListTile(
    leading: CircleAvatar(child: Text('${product.name}')),
    title: Text(product.author)
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // leading: Icon(Icons.emoji_emotions, size: 30),
          // centerTitle: false,
          title: Text("MakerStudio", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25)),
          backgroundColor: Colors.grey,

        ),
        resizeToAvoidBottomInset: false,
        body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('products').snapshots(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text('Something went wrong');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Text("Loading");
            }
            return
              Column(
                children: [
                  Expanded(
                    flex: (MediaQuery
                        .of(context)
                        .viewInsets
                        .bottom == 0) ? 85 : 75,
                    child: GridView(
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2, childAspectRatio: 0.75, mainAxisSpacing: 10, crossAxisSpacing: 10),
                      padding: const EdgeInsets.all(20),

                      children: (snapshot).data!.docs.map((document) {
                        return
                          Listing(document, context);
                        // Listing((document.data() as dynamic)['name'], (document.data() as dynamic)['author'], (document.data() as dynamic)['image'], context);
                      }).toList(),
                    ),
                  )
                ],
              );


            //   ListView(
            //   children: snapshot.data!.docs.map((DocumentSnapshot document) {
            //     Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
            //     return ListTile(
            //       title: Text(data['name']),
            //       subtitle: Text(data['author']),
            //     );
            //   }).toList(),
            // );
          },
        )
    );
  }

}


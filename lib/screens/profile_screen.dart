import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:makerstudio/widgets/widgets.dart';
import 'upload_post_screen.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  // final FirebaseAuth _ath = FirebaseAuth.instance;
  var userName;
  var userID;
  var product;
  // Future getUserData() async {
  //   final uid = FirebaseAuth.instance.currentUser?.uid;
  //   var data = await FirebaseFirestore.instance
  //       .collection('users')
  //       .doc(uid)
  //       .get();
  //   return data;
  // }
  Future<void> getUserData() async {

    userID = (await FirebaseAuth.instance.currentUser)?.uid;

    FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .get()
        .then((value) {
      setState(() {
        userName = (value.data() as dynamic)['name'].toString();
      });
    });
  }

  Future<void> getProductData(QueryDocumentSnapshot document) async {

    String id = document['productID'];
    product = await FirebaseFirestore.instance.collection('products').doc(id).get();
    //     .doc(document['productID'])
    //     .get()
    //     .then((value) {
    //   product = value;
    // });
  }

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  @override
  Widget build(BuildContext context) {
    // String userName = "Default";
    // final doc = getUserData();
    // userName = doc['data'];

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 30),
            Expanded(
              flex: 10,
              child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                        flex: 20,
                        child: InkWell(
                          child: Icon(Icons.account_circle, size: 40),
                          onTap: (){
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(builder: (context) => ProfileDetailScreen()),
                            // );
                          },)
                    ),
                    Expanded(
                        flex: 60,
                        child: Text('$userName', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30))
                    ),

                    Expanded(
                        flex: 20,
                        child: IconButton(
                            onPressed: (){
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(builder: (context) => WalletScreen()),
                              // );
                            },
                            icon: Icon(Icons.credit_card, size: 40))
                    ),
                  ]
              ),
            ),
            Divider(thickness: 5),
            Expanded(
              flex: 10,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.black,
                        elevation: 0,
                        minimumSize: Size(160, 35),
                      ),
                      child: Text("Upload A Post", style: TextStyle(fontSize: 15)),
                      onPressed: () {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(builder: (context) => UploadPost()),
                        // );
                      },
                    ),
                    SizedBox(width: 25),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.black,
                        elevation: 0,
                        minimumSize: Size(160, 35),
                      ),
                      child: Text("View Uploaded", style: TextStyle(fontSize: 15)),
                      onPressed: () {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(builder: (context) => UserListingList()),
                        // );
                      },
                    ),
                  ]
              ),
            ),
            Expanded(
              flex: 60,
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                      padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                  flex: 60,
                                  child: Text("Favorited Posts", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))),
                              // Expanded(
                              //   flex: 40,
                              //   child: ElevatedButton(
                              //     style: ElevatedButton.styleFrom(
                              //       primary: Colors.black,
                              //       elevation: 0,
                              //       minimumSize: Size(160, 35),
                              //     ),
                              //     child: Text("View Orders", style: TextStyle(fontSize: 15)),
                              //     onPressed: () {
                              //       // Navigator.push(
                              //       //   context,
                              //       //   MaterialPageRoute(builder: (context) => ViewOrdersScreen()),
                              //       // );
                              //     },
                              //   ),
                              // ),
                            ],
                          ),
                          Divider(thickness: 5),
                          StreamBuilder<QuerySnapshot>(
                            stream: FirebaseFirestore.instance.collection('users').doc(userID).collection('favorites').snapshots(),
                            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                              if (snapshot.hasError) {
                                return Text('Something went wrong');
                              }

                              if (snapshot.connectionState == ConnectionState.waiting) {
                                return Text("Loading");
                              }
                              return
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    GridView(
                                        shrinkWrap: true,
                                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 2,  childAspectRatio: 0.75, mainAxisSpacing: 10, crossAxisSpacing: 10),
                                        padding: const EdgeInsets.all(10),
                                        children: (snapshot).data!.docs.map((document) {

                                          return ListingFavorite(document, context);
                                        }).toList(),
                                      ),

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
                          ),

                        ],
                      )

                  ),

                  // Expanded(
                  //   child: RefreshIndicator(
                  //     onRefresh: _pullRefresh,
                  //     child: ListView.builder(
                  //       padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                  //       itemCount: DummyData.ownedItems.length,
                  //       itemBuilder: (BuildContext context, int index) {
                  //         return ownedItem(index);
                  //       },
                  //
                  //
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }


  Future<void> _pullRefresh() async {
    setState(() {

    });
  }
}
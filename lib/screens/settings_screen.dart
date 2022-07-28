import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'login_screen.dart';

// import 'list_product_screen.dart';

class SettingsScreen extends StatefulWidget {
  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 30),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.black,
                elevation: 0,
                minimumSize: Size(160, 35),
              ),
              child: Text("Sign Out", style: TextStyle(fontSize: 15)),
              onPressed: () {
                signout();

                // Navigator.popUntil(context, ModalRoute.withName("/"));
                Navigator.of(context, rootNavigator: true).pop(context);
              },
            ),

          ],
        ),
      ),
    );
  }

  Future<void> signout () async {
    await FirebaseAuth.instance.signOut();
  }

  Future<void> _pullRefresh() async {
    setState(() {

    });
  }
}
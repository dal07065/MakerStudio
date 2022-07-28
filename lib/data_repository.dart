import 'package:cloud_firestore/cloud_firestore.dart';

import 'models/product.dart';

class DataRepository {
  // 1
  final CollectionReference collection =
  FirebaseFirestore.instance.collection('products');
  // 2
  Stream<QuerySnapshot> getStream() {
    return collection.snapshots();
  }
  // 3
  Future<DocumentReference> addProduct(Product product) {
    return collection.add(product.toJson());
  }
  // 4
  void updateProduct(Product product) async {
    await collection.doc(product.referenceId).update(product.toJson());
  }
  // 5
  void deleteProduct(Product product) async {
    await collection.doc(product.referenceId).delete();
  }
}
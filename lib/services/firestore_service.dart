import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:project/provider/item_list.dart';

class CloudDataSourceImpl {
  final FirebaseFirestore firestoreInstance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  CloudDataSourceImpl(this.firestoreInstance);

  // Add Items
  Future<void> addItems(ItemList itemList) async {
    var collection = await firestoreInstance.collection("itemList");
    Map<String, dynamic> data = itemList.toMap();
    data.remove('firestoreId');
    var ref = await collection.add(data);
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';

class StoreController {
  CollectionReference ingredients =
      FirebaseFirestore.instance.collection('ingredients');
  void getTest() async {
    QuerySnapshot docs =
        await FirebaseFirestore.instance.collection('test').get();

    var result;
    docs.docs.forEach((element) {
      result = element.data();
    });

    print(result);
  }
}

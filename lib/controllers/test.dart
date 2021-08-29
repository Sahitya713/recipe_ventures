import 'package:cloud_firestore/cloud_firestore.dart';

class TestManager {
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

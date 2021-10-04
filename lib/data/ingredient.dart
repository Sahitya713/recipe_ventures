import 'package:cloud_firestore/cloud_firestore.dart';

class Ingredient {
  final String name;
  final int quantity;
  final String metric;
  final DateTime expiryDate;
  final String userID;
  static CollectionReference ingredients =
      FirebaseFirestore.instance.collection('ingredients');

  Ingredient(
      {this.name, this.userID, this.expiryDate, this.quantity, this.metric});
  factory Ingredient.createIngredientFromFirestore(DocumentSnapshot doc) {
    Map data = doc.data();

    if (data == null) return null;
    Ingredient x = Ingredient(
        name: data['name'] ?? null,
        quantity: data['quantity'] ?? 0,
        metric: data['metric'] ?? "items",
        expiryDate:
            (data['expiryDate'] != null) ? data['expiryDate'].toDate() : null,
        userID: data['userID'] ?? '');

    return x;
  }

  static Stream<List<dynamic>> getStore(String uid) {
    return ingredients
        .where('userID', isEqualTo: uid)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return Ingredient.createIngredientFromFirestore(doc);
      }).toList();
    });
  }
}

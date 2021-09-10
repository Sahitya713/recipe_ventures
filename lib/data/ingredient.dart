import 'package:cloud_firestore/cloud_firestore.dart';

class Ingredient {
  final String name;
  final int quantity;
  final DateTime expiryDate;
  final String userID;
  static CollectionReference ingredients =
      FirebaseFirestore.instance.collection('ingredients');

  Ingredient({this.name, this.userID, this.expiryDate, this.quantity});
  factory Ingredient.createIngredientFromFirestore(DocumentSnapshot doc) {
    Map data = doc.data();

    if (data == null) return null;
    Ingredient x = Ingredient(
        name: data['name'] ?? null,
        quantity: data['quantity'] ?? 0,
        expiryDate:
            (data['expiryDate'] != null) ? data['expiryDate'].toDate() : null,
        userID: data['userID'] ?? '');

    return x;
  }

  static Stream<List<dynamic>> getStore() {
    return ingredients.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return Ingredient.createIngredientFromFirestore(doc);
      }).toList();
    });
  }
}

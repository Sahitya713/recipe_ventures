import 'package:cloud_firestore/cloud_firestore.dart';

class FavRecipe {
  final String id;
  final String title;
  static CollectionReference _favRecipes =
      FirebaseFirestore.instance.collection('favRecipes');

  FavRecipe({this.title, this.id});

  String getTitle() {
    return title;
  }

  String getId() {
    return id;
  }

  factory FavRecipe.createFavRecipeFromFirestore(DocumentSnapshot doc) {
    Map data = doc.data();

    FavRecipe x = FavRecipe(title: data['title'] ?? "", id: doc.id);
    return x;
  }

  static Stream<List<FavRecipe>> getFavRecipes(String uid) {
    return _favRecipes
        .where('userID', isEqualTo: uid)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return FavRecipe.createFavRecipeFromFirestore(doc);
      }).toList();
    });
  }
}

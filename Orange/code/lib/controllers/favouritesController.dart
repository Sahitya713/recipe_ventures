import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import "factoryController.dart";

class FavouritesController {
  final firestore = FirebaseFirestore.instance;
  CollectionReference favRecipes =
      FirebaseFirestore.instance.collection('favRecipes');

  // add a favourite recipe, added only if fav recipe not alr in recipes
  Future addFavourite(int recipeID, String uid) async {
    // check whether the recipe id alr exists in users favourites
    var favourite = favRecipes
        .where("userID", isEqualTo: uid)
        .where("recipeID", isEqualTo: recipeID)
        .get();
    if (favourite == null) {
      return "Recipe already in favourites";
    }

    // add favourites to database if it doest exist
    try {
      final docRef =
          await favRecipes.add({"recipeID": recipeID, "userID": uid});
      return "success";
    } catch (e) {
      print(e.toString());
      return e.toString();
    }
  }

  // delete favourite recipe by id
  Future<String> deleteFavourite(String favRecipeID) async {
    return FactoryController().delete(favRecipeID, favRecipes);
  }
}

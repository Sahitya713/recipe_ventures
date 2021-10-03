import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'factoryController.dart';

class StoreController {
  final firestore = FirebaseFirestore.instance;
  CollectionReference ingredients =
      FirebaseFirestore.instance.collection('ingredients');

  // add ingredients that are not already present in the store
  // for ingredients that are already present in store, just update the quantity (not increase)
  Future addIngredients(List<Map> ingredientsToAdd, String uid) async {
    final batch = firestore.batch();
    ingredientsToAdd.forEach((element) async {
      Map<String, dynamic> data =
          element.map((key, value) => MapEntry(key.toString(), value));
      final ingredient = await ingredients
          .where("userID", isEqualTo: uid)
          .where("name", isEqualTo: data["name"])
          .get();
      if (ingredient == null) {
        data["userID"] = uid;
        final newDocRef = ingredients.doc();
        batch.set(newDocRef, data);
      } else {
        updateIngredient(
            ingredientId: ingredient.docs[0].id, ingredientDetails: data);
      }
    });

    return await batch.commit();
  }

  // update ingredient information. (expiry date or qty). pass it as a map with new details and indredient id.
  Future<String> updateIngredient(
      {@required String ingredientId, Map ingredientDetails}) async {
    return FactoryController()
        .update(ingredientId, ingredientDetails, ingredients);
  }

  // delete an ingredient from store
  Future<String> deleteIngredient(String ingredientID) async {
    return FactoryController().delete(ingredientID, ingredients);
  }
}

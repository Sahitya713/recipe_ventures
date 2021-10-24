import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:recipe_ventures/controllers/favouritesController.dart';
import 'package:recipe_ventures/data/recipe.dart';

class RecipeController {
  // generates recipes. pass in a list of ingredients. returns a json object with the recipes (curently returns 10)

  Future generateRecipes(
      {List<String> ingredients,
      String key = "fdaee5a82b29439689e4bda0644cc60f"}) async {
    print(key);
    var url = Uri.https('api.spoonacular.com', '/recipes/findByIngredients', {
      "apiKey": "8f75676c728a4e7ebac546f628cb0dfa",
      "ingredients": ingredients.join(","),
      "number": "5",
      "sort": "max-used-ingredients"
    });
    var response = await http.get(url);
    if (response.statusCode == 200) {
      String data = response.body;
      // print(data);
      var res = jsonDecode(data);
      for (var i = 0; i < res.length; i++) {
        bool isFav = await FavouritesController()
            .isFavourite(res[i]["id"], FirebaseAuth.instance.currentUser.uid);
        res[i]["isFavourite"] = isFav;
      }
      // print(res[5]["isFavourite"]);
      return res;
    } else {
      print(response.statusCode);
      if (response.statusCode == 402) {
        generateRecipes(
            ingredients: ingredients, key: "8f75676c728a4e7ebac546f628cb0dfa");
      }
    }
  }

  // get recipe details by passing in recipe id. returns a Recipe class instance.
  Future getRecipe(String id) async {
    var url = Uri.https('api.spoonacular.com', '/recipes/$id/information', {
      "apiKey": "fdaee5a82b29439689e4bda0644cc60f",
      "includeNutrition": "true",
    });
    var response = await http.get(url);
    if (response.statusCode == 200) {
      String data = response.body;
      Map<String, dynamic> res = jsonDecode(data);

      Recipe x = Recipe.createRecipeFromRes(res);

      return x;
    } else {
      print(response.statusCode);
    }
  }
}

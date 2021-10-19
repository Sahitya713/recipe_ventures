import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:recipe_ventures/data/recipe.dart';

class RecipeController {
  // generates recipes. pass in a list of ingredients. returns a json object with the recipes (curently returns 10)
  Future generateRecipes(List<String> ingredients) async {
    var url = Uri.https('api.spoonacular.com', '/recipes/findByIngredients', {
      "apiKey": "fdaee5a82b29439689e4bda0644cc60f",
      "ingredients": ingredients.join(","),
      // "number": "3",
      "sort": "max-used-ingredients"
    });
    var response = await http.get(url);
    if (response.statusCode == 200) {
      String data = response.body;
      // print(data);
      var res = jsonDecode(data);

      return res;
    } else {
      print(response.statusCode);
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

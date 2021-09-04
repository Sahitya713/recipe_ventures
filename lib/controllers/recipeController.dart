import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:recipe_ventures/data/recipe.dart';

class RecipeManager {
  Future generateRecipes(List<String> ingredients) async {
    var url = Uri.https('api.spoonacular.com', '/recipes/findByIngredients', {
      "apiKey": "fdaee5a82b29439689e4bda0644cc60f",
      "ingredients": ingredients.join(","),
      "number": "1",
      "sort": "max-used-ingredients"
    });
    var response = await http.get(url);
    if (response.statusCode == 200) {
      String data = response.body;
      var res = jsonDecode(data);
      print(res);
      return res;
    } else {
      print(response.statusCode);
    }
  }

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
      print(x);
      print(x.ingredients);
    } else {
      print(response.statusCode);
    }
  }
}

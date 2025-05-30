import 'package:flutter/material.dart';

class Recipe {
  final String id;
  final String userId;
  final String title;
  final String description;
  final List<String> ingredients;
  final List<String> steps;
  final DateTime createdAt;
  final String? imageUrl;

  Recipe({
    required this.id,
    required this.userId,
    required this.title,
    required this.description,
    required this.ingredients,
    required this.steps,
    required this.createdAt,
    this.imageUrl,
  });
}

class RecipeProvider with ChangeNotifier {
  final List<Recipe> _recipes = [];
  
  List<Recipe> get recipes => [..._recipes];
  
  List<Recipe> get trendingRecipes {
    final sorted = [..._recipes];
    // TODO: Implement actual trending algorithm
    sorted.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    return sorted.take(10).toList();
  }

  Future<void> addRecipe({
    required String userId,
    required String title,
    required String description,
    required List<String> ingredients,
    required List<String> steps,
    String? imageUrl,
  }) async {
    final recipe = Recipe(
      id: DateTime.now().toString(), // TODO: Use UUID or Firebase ID
      userId: userId,
      title: title,
      description: description,
      ingredients: ingredients,
      steps: steps,
      createdAt: DateTime.now(),
      imageUrl: imageUrl,
    );

    _recipes.add(recipe);
    notifyListeners();
  }

  List<Recipe> searchRecipes(String query) {
    return _recipes.where((recipe) {
      return recipe.title.toLowerCase().contains(query.toLowerCase()) ||
             recipe.description.toLowerCase().contains(query.toLowerCase());
    }).toList();
  }

  Future<void> deleteRecipe(String id) async {
    _recipes.removeWhere((recipe) => recipe.id == id);
    notifyListeners();
  }
}

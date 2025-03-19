import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/data/dummy_data.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/providers/filters_provider.dart';

class FavoriteMealsNotifier extends StateNotifier<List<Meal>> {
  FavoriteMealsNotifier() : super([]);

  bool toggleFavoriteMeal(Meal meal) {
    final isExisting = state.contains(meal);

    if (isExisting) {
      state = state.where((favMeal) => favMeal.id != meal.id).toList();
      return false;
    }
    state = [...state, meal];
    return true;
  }
}

final favoritesMealsProvider =
    StateNotifierProvider<FavoriteMealsNotifier, List<Meal>>(
      (ref) => FavoriteMealsNotifier(),
    );

final filteredMealsProvider = Provider((ref) {
  final selectedFilters = ref.watch(filtersProvider);

  bool mealsFilter(Meal meal) {
    if (selectedFilters[Filter.glutenFree]! && !meal.isGlutenFree) {
      return false;
    }
    if (selectedFilters[Filter.lactoseFree]! && !meal.isLactoseFree) {
      return false;
    }
    if (selectedFilters[Filter.vegetarian]! && !meal.isVegetarian) {
      return false;
    }
    if (selectedFilters[Filter.vegan]! && !meal.isVegan) {
      return false;
    }

    return true;
  }

  return dummyMeals.where(mealsFilter).toList();
});

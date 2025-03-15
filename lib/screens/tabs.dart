import 'package:flutter/material.dart';
import 'package:meals_app/data/dummy_data.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/screens/categories.dart';
import 'package:meals_app/screens/filters.dart';
import 'package:meals_app/screens/meals.dart';
import 'package:meals_app/widgets/main_drawer.dart';

const kInitialFilters = {
  Filters.glutenFree: false,
  Filters.lactoseFree: false,
  Filters.vegetarian: false,
  Filters.vegan: false,
};

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() {
    return _TabsState();
  }
}

class _TabsState extends State<TabsScreen> {
  final List<Meal> _favoriteMeals = [];
  Map<Filters, bool> _selectedFilters = kInitialFilters;
  int _selectedScreenIndex = 0;

  void _showStackBar(String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  void _toggleFavoriteMeal(Meal meal) {
    final isExisting = _favoriteMeals.contains(meal);

    if (isExisting) {
      setState(() {
        _favoriteMeals.remove(meal);
      });
      _showStackBar("Removed from favorites");
    } else {
      setState(() {
        _favoriteMeals.add(meal);
      });
      _showStackBar("Marked as favorites");
    }
  }

  void _setScreen(int index) {
    setState(() {
      _selectedScreenIndex = index;
    });
  }

  void _changeScreen(String identifier) async {
    Navigator.of(context).pop();
    if (identifier == 'filters') {
      final result = await Navigator.of(context).push<Map<Filters, bool>>(
        MaterialPageRoute(
          builder: (ctx) => FiltersScreen(currentFilters: _selectedFilters),
        ),
      );
      setState(() {
        _selectedFilters = result ?? kInitialFilters;
      });
    }
  }

  bool _mealsFilter(Meal meal) {
    if (_selectedFilters[Filters.glutenFree]! && !meal.isGlutenFree) {
      return false;
    }
    if (_selectedFilters[Filters.lactoseFree]! && !meal.isLactoseFree) {
      return false;
    }
    if (_selectedFilters[Filters.vegetarian]! && !meal.isVegetarian) {
      return false;
    }
    if (_selectedFilters[Filters.vegan]! && !meal.isVegan) {
      return false;
    }

    return true;
  }

  @override
  Widget build(BuildContext context) {
    final availableMeals = dummyMeals.where(_mealsFilter).toList();

    Widget activeScreen = CategoriesScreen(
      title: "Categories",
      meals: availableMeals,
      onToggleFavoriteMeal: _toggleFavoriteMeal,
    );

    if (_selectedScreenIndex == 1) {
      activeScreen = MealsScreen(
        title: "Your Favorites",
        meals: _favoriteMeals,
        onToggleFavoriteMeal: _toggleFavoriteMeal,
      );
    }

    return Scaffold(
      appBar: AppBar(),
      drawer: MainDrawer(onTileTap: _changeScreen),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) => _setScreen(index),
        currentIndex: _selectedScreenIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.set_meal),
            label: "Categories",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: "Favorites"),
        ],
      ),
      body: activeScreen,
    );
  }
}

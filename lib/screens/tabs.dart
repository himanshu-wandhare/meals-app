import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/providers/meals_provider.dart';
import 'package:meals_app/screens/categories.dart';
import 'package:meals_app/screens/filters.dart';
import 'package:meals_app/screens/meals.dart';
import 'package:meals_app/widgets/main_drawer.dart';

class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({super.key});

  @override
  ConsumerState<TabsScreen> createState() {
    return _TabsState();
  }
}

class _TabsState extends ConsumerState<TabsScreen> {
  int _selectedScreenIndex = 0;

  void _setScreen(int index) {
    setState(() {
      _selectedScreenIndex = index;
    });
  }

  void _changeScreen(String identifier) async {
    Navigator.of(context).pop();
    if (identifier == 'filters') {
      await Navigator.of(
        context,
      ).push(MaterialPageRoute(builder: (ctx) => const FiltersScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    final availableMeals = ref.watch(filteredMealsProvider);

    Widget activeScreen = CategoriesScreen(
      title: "Categories",
      meals: availableMeals,
    );

    if (_selectedScreenIndex == 1) {
      final favoriteMeals = ref.watch(favoritesMealsProvider);
      activeScreen = MealsScreen(title: "Your Favorites", meals: favoriteMeals);
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

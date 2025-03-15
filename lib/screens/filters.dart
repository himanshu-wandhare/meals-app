import 'package:flutter/material.dart';
import 'package:meals_app/widgets/switch_tile.dart';

enum Filters { glutenFree, lactoseFree, vegetarian, vegan }

class FiltersScreen extends StatefulWidget {
  const FiltersScreen({super.key, required this.currentFilters});

  final Map<Filters, bool> currentFilters;

  @override
  State<FiltersScreen> createState() {
    return _FiltersScreenState();
  }
}

class _FiltersScreenState extends State<FiltersScreen> {
  bool _isGlutenFree = false;
  bool _isLactoseFree = false;
  bool _isVegetarian = false;
  bool _isVegan = false;

  @override
  void initState() {
    super.initState();
    _isGlutenFree = widget.currentFilters[Filters.glutenFree]!;
    _isLactoseFree = widget.currentFilters[Filters.lactoseFree]!;
    _isVegetarian = widget.currentFilters[Filters.vegetarian]!;
    _isVegan = widget.currentFilters[Filters.vegan]!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Filters")),
      body: PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, result) async {
          if (didPop) {
            return;
          }
          Navigator.of(context).pop({
            Filters.glutenFree: _isGlutenFree,
            Filters.lactoseFree: _isLactoseFree,
            Filters.vegetarian: _isVegetarian,
            Filters.vegan: _isVegan,
          });
        },
        child: Column(
          children: [
            SwitchTile(
              value: _isGlutenFree,
              onChanged:
                  (isChecked) => setState(() => _isGlutenFree = isChecked),
              title: "Gluten free",
              subtitle: "Only includes gluten free meals",
            ),
            SwitchTile(
              value: _isLactoseFree,
              onChanged:
                  (isChecked) => setState(() => _isLactoseFree = isChecked),
              title: "Lactose free",
              subtitle: "Only includes lactose free meals",
            ),
            SwitchTile(
              value: _isVegetarian,
              onChanged:
                  (isChecked) => setState(() => _isVegetarian = isChecked),
              title: "Vegeterian",
              subtitle: "Only includes Vegeterian meals",
            ),
            SwitchTile(
              value: _isVegan,
              onChanged: (isChecked) => setState(() => _isVegan = isChecked),
              title: "Vegan",
              subtitle: "Only includes Vegan meals",
            ),
          ],
        ),
      ),
    );
  }
}

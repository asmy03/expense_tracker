import 'package:flutter/material.dart';

class CategorySelector extends StatelessWidget {
  final String selectedCategory;
  final ValueChanged<String> onCategorySelected;

  const CategorySelector({
    super.key,
    required this.selectedCategory,
    required this.onCategorySelected,
  });

  static const List<CategoryOption> categories = [
    CategoryOption(name: 'Food', icon: Icons.restaurant_outlined),
    CategoryOption(name: 'Transport', icon: Icons.directions_car_outlined),
    CategoryOption(name: 'Shopping', icon: Icons.shopping_bag_outlined),
    CategoryOption(name: 'Bills', icon: Icons.receipt_long_outlined),
    CategoryOption(name: 'Entertainment', icon: Icons.movie_outlined),
    CategoryOption(name: 'Health', icon: Icons.medical_services_outlined),
    CategoryOption(name: 'Education', icon: Icons.school_outlined),
    CategoryOption(name: 'Other', icon: Icons.more_horiz),
  ];

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: categories.map((category) {
        final isSelected = selectedCategory == category.name;

        return ChoiceChip(
          selected: isSelected,
          label: Text(category.name),
          avatar: Icon(category.icon, size: 18),
          onSelected: (_) {
            onCategorySelected(category.name);
          },
        );
      }).toList(),
    );
  }
}

class CategoryOption {
  final String name;
  final IconData icon;

  const CategoryOption({required this.name, required this.icon});
}

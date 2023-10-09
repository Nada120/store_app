import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store_app/provider/category_provider.dart';
import '../helper/colors.dart';

class CategoriesNameList extends StatelessWidget {
  final List<dynamic> categories;
  const CategoriesNameList({super.key, required this.categories});

  @override
  Widget build(BuildContext context) {
    final providerCategory = Provider.of<CategoryProvider>(context);
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: SizedBox(
        height: 40,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: categories.length,
          itemBuilder: (context, index) => GestureDetector(
            onTap: () {
              providerCategory.category = categories[index];
            },
            child: Container(
              width: 120,
              margin: const EdgeInsets.all(3),
              decoration: BoxDecoration(
                color: providerCategory.category == categories[index]
                    ? blueDark1
                    : Colors.white.withOpacity(0.6),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(
                  categories[index],
                  style: TextStyle(
                    color: providerCategory.category == categories[index]
                        ? Colors.white
                        : grey,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
